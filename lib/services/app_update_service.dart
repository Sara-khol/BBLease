import 'dart:io';

import 'package:bblease/customWidgets/update_dialog.dart';
import 'package:bblease/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

/// One-stop service for "is there a newer version?" checks.
///
/// Flow:
///   1. Cooldown gate (1h) — to avoid hammering the API on rapid resumes.
///   2. GET app-version metadata from the server (platform-specific).
///   3. Compare with the installed version (from package_info_plus).
///   4. installed < minRequired  → blocking dialog (no "later").
///      installed < latest       → soft dialog (unless user already
///                                 dismissed *that exact* latestVersion).
///      otherwise                → nothing.
///   5. "Update" button opens the platform store via url_launcher.
class AppUpdateService {
  AppUpdateService._();
  static final AppUpdateService instance = AppUpdateService._();

  static const Duration _cooldown = Duration(hours: 1);
  static const String _kLastCheckAt = 'update_last_check_at';
  static const String _kDismissedVersion = 'update_dismissed_version';

  /// Apple App Store ID. Fixed for the lifetime of the app listing, so a
  /// const here is simpler than passing it through the server response.
  static const String _iosAppId = '6764411452';

  /// Set to true while a dialog is being shown, so a rapid resume can't
  /// stack a second dialog on top.
  bool _dialogVisible = false;

  /// Public entry point. Safe to call repeatedly — internal cooldown guards.
  /// Pass [force] = true to bypass the cooldown (e.g. from a "check now"
  /// button if you ever add one).
  Future<void> checkForUpdate(BuildContext context, {bool force = false}) async {
    if (_dialogVisible) return;

    try {
      final prefs = await SharedPreferences.getInstance();

      if (!force) {
        final lastMs = prefs.getInt(_kLastCheckAt) ?? 0;
        final since = DateTime.now().millisecondsSinceEpoch - lastMs;
        if (since < _cooldown.inMilliseconds) return;
      }

      final platform = Platform.isIOS ? 'ios' : 'android';
      final info = await ApiService().getAppVersionInfo(platform);
      if (info == null) return; // network/parse error — silent skip

      // Only update the cooldown stamp on a successful fetch, so that
      // a brief outage doesn't lock us out for an hour.
      await prefs.setInt(
          _kLastCheckAt, DateTime.now().millisecondsSinceEpoch);

      final latest = (info['latestVersion'] as String?)?.trim();
      final minReq = (info['minRequiredVersion'] as String?)?.trim();
      final notes = (info['releaseNotes'] as String?)?.trim() ?? '';
      if (latest == null || latest.isEmpty) return;

      final pkg = await PackageInfo.fromPlatform();
      final installed = pkg.version.trim();

      final forceUpdate =
          minReq != null && minReq.isNotEmpty && _isLower(installed, minReq);
      final hasNewer = _isLower(installed, latest);
      if (!forceUpdate && !hasNewer) return;

      // Respect "later" only for soft updates and only for the same target.
      if (!forceUpdate) {
        final dismissed = prefs.getString(_kDismissedVersion);
        if (dismissed == latest) return;
      }

      if (!context.mounted) return;
      _dialogVisible = true;
      try {
        await showUpdateDialog(
          context,
          latestVersion: latest,
          releaseNotes: notes,
          force: forceUpdate,
          onUpdate: () => _openStore(pkg.packageName),
          onLater: forceUpdate
              ? null
              : () async {
                  await prefs.setString(_kDismissedVersion, latest);
                },
        );
      } finally {
        _dialogVisible = false;
      }
    } catch (e, st) {
      // Never let an update check crash the app.
      debugPrint('AppUpdateService.checkForUpdate error: $e\n$st');
    }
  }

  Future<void> _openStore(String androidPackageName) async {
    if (Platform.isIOS) {
      // itms-apps:// opens the App Store app directly; https is a fallback
      // for the rare case it's unavailable (e.g. simulator).
      final native = Uri.parse('itms-apps://apps.apple.com/app/id$_iosAppId');
      if (await canLaunchUrl(native)) {
        await launchUrl(native, mode: LaunchMode.externalApplication);
        return;
      }
      await launchUrl(
        Uri.parse('https://apps.apple.com/app/id$_iosAppId'),
        mode: LaunchMode.externalApplication,
      );
      return;
    }

    // Android: market:// opens the Play Store app directly; if not present
    // (rare — emulators without Play Services), the https fallback works too.
    final market = Uri.parse('market://details?id=$androidPackageName');
    if (await canLaunchUrl(market)) {
      await launchUrl(market, mode: LaunchMode.externalApplication);
      return;
    }
    await launchUrl(
      Uri.parse(
          'https://play.google.com/store/apps/details?id=$androidPackageName'),
      mode: LaunchMode.externalApplication,
    );
  }

  /// Returns true if [a] is a strictly lower semver than [b].
  /// Tolerant: missing parts treated as 0, non-numeric parts ignored.
  /// Examples: 1.0.3 < 1.0.5, 1.0 < 1.0.1, 1.2 == 1.2.0.
  static bool _isLower(String a, String b) {
    final pa = _parse(a);
    final pb = _parse(b);
    final n = pa.length > pb.length ? pa.length : pb.length;
    for (var i = 0; i < n; i++) {
      final ai = i < pa.length ? pa[i] : 0;
      final bi = i < pb.length ? pb[i] : 0;
      if (ai < bi) return true;
      if (ai > bi) return false;
    }
    return false;
  }

  static List<int> _parse(String v) {
    // Strip a "+buildNumber" suffix if present (1.0.5+12 → 1.0.5).
    final core = v.split('+').first;
    return core
        .split('.')
        .map((p) => int.tryParse(p.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0)
        .toList();
  }
}
