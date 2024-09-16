
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/models/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class CameraFaceDetection extends StatefulWidget {
  @override
  _CameraFaceDetectionState createState() => _CameraFaceDetectionState();
}

class _CameraFaceDetectionState extends State<CameraFaceDetection> {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  late bool _isDetecting;
  bool isCapture = false;
  late List<CameraDescription> cameras;
  late CameraDescription selfiCamera;

  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };

  @override
  void initState() {
    super.initState();
    _isDetecting = false;
    _initializeCamera();
    //_initializeFaceDetector();
  }

  Future<void> _initializeCamera() async {
    print('_initializeCamera');
    _initializeFaceDetector();

    cameras = await availableCameras();
    selfiCamera= cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    //selfiCamera = cameras[0];
    _cameraController = CameraController(
      selfiCamera,
      ResolutionPreset.max,
      enableAudio: false,
      /*ResolutionPreset.medium,*/
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21 // for Android
          : ImageFormatGroup.bgra8888,
    );

    await _cameraController!.initialize();
    // _cameraController!.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    //   _startDetecting();
    // });

    if (mounted && _cameraController != null) {
      setState(() {});
      _startDetecting();
    } else {
      debugPrint('_cameraController is null or widget is not mounted');
      Sentry.addBreadcrumb(Breadcrumb(
          message: '_cameraController is null or widget is not mounted'));
      await Sentry.captureMessage('???? ');
    }
  }

  void _initializeFaceDetector() {
    print('_initializeFaceDetector');

    //
     _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 0.1),
    );

    // _faceDetector = GoogleMlKit.vision.faceDetector(
    //   FaceDetectorOptions(
    //    // enableContours: true,
    //    // enableLandmarks: true,
    //    // performanceMode: FaceDetectorMode.accurate,
    //    // minFaceSize: 0.1,
    //
    //       performanceMode: FaceDetectorMode.fast, enableLandmarks: true// Experiment with different values
    //   ),
    // );
  }

  void _startDetecting() {
    print('_startDetecting _isDetecting $_isDetecting');

    _cameraController!.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;

       final inputImage = _inputImageFromCameraImage(image);


        if (inputImage != null) {
          _faceDetector.processImage(inputImage).then((List<Face> faces) {
            print('faces.length ${faces.length}');

            if (faces.isNotEmpty) {
              print('faces.isNotEmpty');
              Sentry.addBreadcrumb(Breadcrumb(message: 'faces.isNotEmpty'));
              if (_isDetecting) {
                _capturePicture();
              }
            }
            _isDetecting = false;
          });
        } else {
          debugPrint('inputImage null');
        //  _isDetecting = false;
        }
      }
    });
  }

  /*  InputImage? _inputImageFromCameraImage(CameraImage image) {
    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
    final camera = selfiCamera;
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[_cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }*/

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
    final camera =selfiCamera;
    final sensorOrientation = camera.sensorOrientation;
    InputImageRotation? rotation;
    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else if (Platform.isAndroid) {
      var rotationCompensation =
      _orientations[_cameraController!.value.deviceOrientation];
      if (rotationCompensation == null) return null;
      if (camera.lensDirection == CameraLensDirection.front) {
        // front-facing
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        // back-facing
        rotationCompensation =
            (sensorOrientation - rotationCompensation + 360) % 360;
      }
      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }
    if (rotation == null) return null;

    // get image format
    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    debugPrint('format $format');
    // validate format depending on platform
    // only supported formats:
    // * nv21 for Android
    // * bgra8888 for iOS
    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888))
      {
        if(Platform.isAndroid)
          {
            const format = InputImageFormat.nv21;

            Uint8List nv21Bytes = getNv21Uint8List(image);
            debugPrint('nv21Bytes ${nv21Bytes.length}');
            // Create an InputImage from the converted NV21 bytes
            return   InputImage.fromBytes(
              bytes: nv21Bytes,
              metadata: InputImageMetadata(
                size: Size(image.width.toDouble(), image.height.toDouble()),
                rotation: rotation, // Consider setting the correct rotation value
                format: format,
                bytesPerRow: image.planes[0].bytesPerRow,
              ),
            );
          }
        else
          {
            return null;
          }

      }

    // since format is constraint to nv21 or bgra8888, both only have one plane
    if (image.planes.length != 1) return null;
    final plane = image.planes.first;

    // compose InputImage using bytes
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation, // used only in Android
        format: format, // used only in iOS
        bytesPerRow: plane.bytesPerRow, // used only in iOS
      ),
    );
  }

  Uint8List getNv21Uint8List(CameraImage image) {
    final width = image.width;
    final height = image.height;

    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    final yBuffer = yPlane.bytes;
    final uBuffer = uPlane.bytes;
    final vBuffer = vPlane.bytes;

    final numPixels = (width * height * 1.5).toInt();
    final nv21 = List<int>.filled(numPixels, 0);

    // Full size Y channel and quarter size U+V channels.
    int idY = 0;
    int idUV = width * height;
    final uvWidth = width ~/ 2;
    final uvHeight = height ~/ 2;
    // Copy Y & UV channel.
    // NV21 format is expected to have YYYYVU packaging.
    // The U/V planes are guaranteed to have the same row stride and pixel stride.
    // getRowStride analogue??
    final uvRowStride = uPlane.bytesPerRow;
    // getPixelStride analogue
    final uvPixelStride = uPlane.bytesPerPixel ?? 0;
    final yRowStride = yPlane.bytesPerRow;
    final yPixelStride = yPlane.bytesPerPixel ?? 0;

    for (int y = 0; y < height; ++y) {
      final uvOffset = y * uvRowStride;
      final yOffset = y * yRowStride;

      for (int x = 0; x < width; ++x) {
        nv21[idY++] = yBuffer[yOffset + x * yPixelStride];

        if (y < uvHeight && x < uvWidth) {
          final bufferIndex = uvOffset + (x * uvPixelStride);
          //V channel
          nv21[idUV++] = vBuffer[bufferIndex];
          //V channel
          nv21[idUV++] = uBuffer[bufferIndex];
        }
      }
    }
    return Uint8List.fromList(nv21);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    print('_concatenatePlanes');
    // Concatenate the planes of a CameraImage into a single Uint8List
    final ByteData buffer = ByteData(planes
        .map((plane) => plane.bytes.length)
        .reduce((value, element) => value + element));
    int offset = 0;
    planes.forEach((plane) {
      buffer.setUint8(offset, plane.bytesPerRow);
      offset += plane.bytes.length;
    });
    return buffer.buffer.asUint8List();
  }

  void _capturePicture() async {
    if (!isCapture) {
      print('_capturePicture');

      if (_cameraController != null &&
          _cameraController!.value.isStreamingImages) {
        try {
          await _cameraController!.stopImageStream();
          await _cameraController!.pausePreview();
          Sentry.addBreadcrumb(Breadcrumb(message: 'ok'));
          debugPrint('okkkkk');
          isCapture = true;

          XFile file = await _cameraController!.takePicture();
          print("Picture captured: ${file.path}");
          // if (file != null) {

          User().regImages[2] = file;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Verification(),
              ));
        }
        catch (e) {
          // Handle any exceptions that might occur during capture
          debugPrint("Error during capture: $e");
          Sentry.addBreadcrumb(Breadcrumb(message:"Error during capture: $e"));
          // Reset capturing flag even if there's an error
          isCapture = false;
        }
      }
      else {
        Sentry.addBreadcrumb(Breadcrumb(message: 'error??'));
      }
      await Sentry.captureMessage('_capturePicture ');
    }
    //  } // You can save the file or perform other actions here
    // // if(file!=null)
    //    Navigator.push(context, MaterialPageRoute(builder: (context) => SucssesRegistrationForm(),));
    //  // You can save the file or perform other actions here
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null) {
      return Container();
    }
    return Column(
      children: [
        Expanded(child: CameraPreview(_cameraController!)),
        ElevatedButton.icon(
            icon: Icon(Icons.camera),
            onPressed: _capturePicture,
            label: Text('צלם'))
      ],
    );
    /*SizedBox(
      height: 500,
        child: FutureBuilder<void>(
            future: _initializeCamera(),
            builder: (context,snapshot) {
              if(snapshot.hasData)
                return CameraPreview(_cameraController);
              return CircularProgressIndicator();
            },
    )
    );*/
  }

//  _stopDetecting() async{
//   print('_stopDetecting');
//   // Stop the image stream
//  await _cameraController?.stopImageStream();
// }
}

