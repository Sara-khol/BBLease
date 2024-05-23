import 'dart:async';
import 'dart:io';
//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'dart:typed_data';
import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/models/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CameraFaceDetection extends StatefulWidget {
  @override
  _CameraFaceDetectionState createState() => _CameraFaceDetectionState();
}

class _CameraFaceDetectionState extends State<CameraFaceDetection> {
  late CameraController _cameraController;
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
    //_initializeCamera();
    //_initializeFaceDetector();
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
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
          _orientations[_cameraController.value.deviceOrientation];
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
  }

  Future<bool> _initializeCamera() async {
    print('_initializeCamera');
    _initializeFaceDetector();
    print('_initializeCamera');
    cameras = await availableCameras();
     //selfiCamera= cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
    //selfiCamera = cameras[0];
    print(cameras.length);
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
      /*ResolutionPreset.medium,*/
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.yuv420 // for Android
          : ImageFormatGroup.bgra8888,
    );

   await _cameraController.initialize();
    await _cameraController.initialize().then((_) async {

      print('camera controller has been initialized');
       if (!mounted) {
         return;
       }
       if (mounted && _cameraController != null) {
         setState(() {});
         _startDetecting();
       }
       else {
         debugPrint('_cameraController is null or widget is not mounted');
         Sentry.addBreadcrumb(Breadcrumb(
             message: '_cameraController is null or widget is not mounted'));
         await Sentry.captureMessage('???? ');
       }
     });
return true;

  }

  void _initializeFaceDetector() {
    print('_initializeFaceDetector');

    //
    //  _faceDetector = FaceDetector(
    //   options: FaceDetectorOptions(
    //     enableContours: true,
    //     enableLandmarks: true,
    //     performanceMode: FaceDetectorMode.accurate,
    //     minFaceSize: 0.1, // Experiment with different values
    //   ),
    // );

    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
        performanceMode: FaceDetectorMode.accurate,
        minFaceSize: 0.1, // Experiment with different values
      ),
    );
  }

  void _startDetecting() {
    print('_startDetecting');

    _cameraController.startImageStream((CameraImage image) {
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
        }
      }
    });
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
          _cameraController.value.isStreamingImages) {
        try {
          await _cameraController.stopImageStream();
          await _cameraController.pausePreview();
          Sentry.addBreadcrumb(Breadcrumb(message: 'ok'));
          debugPrint('okkkkk');
          isCapture = true;

          XFile file = await _cameraController.takePicture();
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
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeCamera(),
      builder: (context,snapshot) {
        print('snapshot: $snapshot');
        if(snapshot.hasData) {
          return Column(
          children: [
            //Expanded(child: CameraPreview(_cameraController)),
            ElevatedButton.icon(
                icon: Icon(Icons.camera),
                onPressed: _capturePicture,
                label: Text('צלם'))
          ],
        );
        }
        else
          return Container();
      }
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
