import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bblease/Flow/registration/sucsses_registration.dart';
import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/models/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';


class CameraFaceDetection extends StatefulWidget {
  @override
  _CameraFaceDetectionState createState() => _CameraFaceDetectionState();
}

class _CameraFaceDetectionState extends State<CameraFaceDetection> {
  CameraController? _cameraController;
  late FaceDetector _faceDetector;
  late bool _isDetecting;
  late List<CameraDescription> cameras;

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

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    // get image rotation
    // it is used in android to convert the InputImage from Dart to Java
    // `rotation` is not used in iOS to convert the InputImage from Dart to Obj-C
    // in both platforms `rotation` and `camera.lensDirection` can be used to compensate `x` and `y` coordinates on a canvas
    final camera = cameras[0];
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
  }

  Future<void> _initializeCamera() async {
    print('_initializeCamera');
    _initializeFaceDetector();

    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[0],ResolutionPreset.max,
      enableAudio: false, /*ResolutionPreset.medium,*/ imageFormatGroup: Platform.isAndroid
        ? ImageFormatGroup.nv21 // for Android
        : ImageFormatGroup.bgra8888,);
    _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      _startDetecting();
    });
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

    _cameraController!.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;

        final inputImage =   _inputImageFromCameraImage(image);

        if(inputImage!=null) {
          _faceDetector.processImage(inputImage).then((List<Face> faces) {
            print('faces.length ${faces.length}');

            if (faces.isNotEmpty) {
              print('faces.isNotEmpty');

              _stopDetecting();
            }
            _isDetecting = false;
          });
        }
        else
          {
            debugPrint('inputImage null');
          }
      }
    });
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    print('_concatenatePlanes');
    // Concatenate the planes of a CameraImage into a single Uint8List
    final ByteData buffer = ByteData(
        planes.map((plane) => plane.bytes.length).reduce((value,
            element) => value + element));
    int offset = 0;
    planes.forEach((plane) {
      buffer.setUint8(offset, plane.bytesPerRow);
      offset += plane.bytes.length;
    });
    return buffer.buffer.asUint8List();
  }

  void _capturePicture() async {
    print('_capturePicture');
    XFile file = await _cameraController!.takePicture();
    print("Picture captured: ${file.path}");
    if (file != null) {
      _cameraController?.stopImageStream();
      _cameraController?.pausePreview();

      User().regImages[2] = file;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Verification(),));
    } // You can save the file or perform other actions here
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
          label: Text('צלם'),)
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

  void _stopDetecting() {
    print('_stopDetecting');
    // Stop the image stream
    _cameraController?.stopImageStream();
    _capturePicture();
  }
}
