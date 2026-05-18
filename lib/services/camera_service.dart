import 'package:bblease/utils/common_funcs.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
//import 'package:web/web.dart' as web;

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

  /// Permission gate to call BEFORE [init]. Handles the full UX:
  /// asks the system for permission, and on refusal shows either a toast
  /// (regular denial) or an "open settings" dialog (permanent denial —
  /// system won't re-prompt, the user must flip the switch manually).
  ///
  /// Returns true only when the caller may proceed to open the camera.
  /// Returning false means the user has been informed; the caller should
  /// just bail out silently.
  static Future<bool> ensureGrantedWithUi(BuildContext context) async {
    var status = await Permission.camera.status;
    if (status.isGranted || status.isLimited) return true;

    status = await Permission.camera.request();
    if (status.isGranted || status.isLimited) return true;

    if (!context.mounted) return false;

    if (status.isPermanentlyDenied) {
      await _showOpenSettingsDialog(context);
    } else {
      CommonFuncs().showMyToast('נדרשת הרשאת מצלמה כדי להמשיך');
    }
    return false;
  }

  static Future<void> _showOpenSettingsDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('נדרשת הרשאת מצלמה'),
          content: const Text(
              'כדי להמשיך, יש לאפשר גישה למצלמה דרך הגדרות האפליקציה.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('ביטול'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                openAppSettings();
              },
              child: const Text('פתח הגדרות'),
            ),
          ],
        ),
      ),
    );
  }

  List<CameraDescription>? _cameras;
  CameraController? controller;
  bool _initializing = false;


  Future<void> init({bool useFront = false}) async {
    // אם כבר מאותחל, סוגרים קודם
    if (controller != null && controller!.value.isInitialized) {
      debugPrint('♻️ Reinitializing camera');
      await controller!.dispose();
      controller = null;
      await Future.delayed(const Duration(milliseconds: 800));
    }

    final cameras = await availableCameras();
    final selected = cameras.firstWhere(
          (c) => useFront
          ? c.lensDirection == CameraLensDirection.front
          : c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    controller = CameraController(
      selected,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
      // We only take stills — explicitly disable audio so the camera plugin
      // doesn't prompt for RECORD_AUDIO / mic permission.
      enableAudio: false,
    );
    await controller!.initialize();
    debugPrint('📸 Camera initialized (${useFront ? "front" : "back"})');
  }

  Future<void> dispose() async {
    if (controller != null && controller!.value.isInitialized) {
      await controller!.dispose();
      controller = null;
      debugPrint('Camera disposed');
    }
  }

  /// השהיית תצוגת מצלמה
  Future<void> pauseCamera() async {
    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isPreviewPaused == false) {
        await controller!.pausePreview();
        debugPrint('⏸️ Camera preview paused');
      }
    } catch (e) {
      debugPrint('⚠️ pauseCamera error: $e');
    }
  }

  /// חידוש תצוגת מצלמה
  Future<void> resumeCamera() async {
    try {
      if (controller != null &&
          controller!.value.isInitialized &&
          controller!.value.isPreviewPaused) {
        await controller!.resumePreview();
        debugPrint('▶️ Camera preview resumed');
      }
    } catch (e) {
      debugPrint('⚠️ resumeCamera error: $e');
    }
  }

  /// צילום תמונה
  Future<XFile?> capture() async {
    try {
      if (controller == null || !controller!.value.isInitialized) {
        debugPrint('⚠️ Camera not initialized');
        return null;
      }
      final file = await controller!.takePicture();
      debugPrint('📸 Picture captured: ${file.path}');
      return file;
    } catch (e) {
      debugPrint('❌ Capture error: $e');
      return null;
    }
  }


}
