import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bblease/Flow/registration/sucsses_registration.dart';
import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/models/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';



class CameraFaceDetection extends StatefulWidget {
  @override
  _CameraFaceDetectionState createState() => _CameraFaceDetectionState();
}

class _CameraFaceDetectionState extends State<CameraFaceDetection> {
   CameraController? _cameraController;
  late FaceDetector _faceDetector;
  late bool _isDetecting;

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

    List<CameraDescription> cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
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

        final inputImage = InputImage.fromBytes(
          bytes: _concatenatePlanes(image.planes),
          inputImageData: InputImageData(
            size: Size(image.width.toDouble(), image.height.toDouble()),
            imageRotation: InputImageRotation.rotation270deg,
            inputImageFormat: InputImageFormat.yuv420,
            planeData: [], // Adjust rotation based on your camera orientation
          ),
        );



        _faceDetector.processImage(inputImage).then((List<Face> faces) {
          print('faces.length ${faces.length}');

          if (faces.isNotEmpty) {
            print('faces.isNotEmpty');

            _capturePicture();
          }
          _isDetecting = false;
        });
      }
    });
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    print('_concatenatePlanes');
    // Concatenate the planes of a CameraImage into a single Uint8List
    final ByteData buffer = ByteData(planes.map((plane) => plane.bytes.length).reduce((value, element) => value + element));
    int offset = 0;
    planes.forEach((plane) {
      buffer.setUint8(offset,plane.bytesPerRow);
      offset += plane.bytes.length;
    });
    return buffer.buffer.asUint8List();
  }

  void _capturePicture() async {
    print('_capturePicture');
    XFile file = await _cameraController!.takePicture();
    print("Picture captured: ${file.path}");
    if(file!=null) {
      _cameraController?.stopImageStream();
      _cameraController?.pausePreview();

      User().regImages[2] = file;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Verification(),));
    }// You can save the file or perform other actions here
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
    if (_cameraController==null) {
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
}
