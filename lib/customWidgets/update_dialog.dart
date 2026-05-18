import 'package:bblease/customWidgets/customText.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shown by [AppUpdateService]. Keep the visual style aligned with the rest
/// of the app's dialogs/buttons (turquoise primary, PLONI font via theme).
///
/// [force] = true:
///   - barrier is not dismissible
///   - back-button does nothing (WillPopScope)
///   - only the "update" button is rendered
Future<void> showUpdateDialog(
  BuildContext context, {
  required String latestVersion,
  required String releaseNotes,
  required bool force,
  required VoidCallback onUpdate,
  VoidCallback? onLater,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: !force,
    builder: (ctx) => PopScope(
      canPop: !force,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          title: CustomText(
            force ? 'נדרש עדכון' : 'יש גרסה חדשה',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomText(
                force
                    ? 'הגרסה שברשותך אינה נתמכת יותר. נא לעדכן כדי להמשיך להשתמש באפליקציה.'
                    : 'גרסה $latestVersion זמינה להורדה.',
                style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              if (releaseNotes.isNotEmpty) ...[
                SizedBox(height: 12.h),
                CustomText(
                  releaseNotes,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            if (!force && onLater != null)
              TextButton(
                onPressed: () {
                  onLater();
                  Navigator.of(ctx).pop();
                },
                child: CustomText(
                  'אחר כך',
                  style:
                      TextStyle(fontSize: 16.sp, color: Colors.black54),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoiseColorApp,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                padding: EdgeInsets.symmetric(
                    horizontal: 24.w, vertical: 10.h),
                elevation: 0,
              ),
              onPressed: () {
                if (!force) Navigator.of(ctx).pop();
                onUpdate();
              },
              child: CustomText(
                'עדכן עכשיו',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
