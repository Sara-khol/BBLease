import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
//import 'package:web/web.dart' as web;

class CameraService {
  static final CameraService _instance = CameraService._internal();
  factory CameraService() => _instance;
  CameraService._internal();

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
