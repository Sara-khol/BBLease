import 'dart:async';
import 'dart:typed_data';

import 'package:bblease/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';


class FaceScanning extends StatefulWidget {
  const FaceScanning({Key? key}) : super(key: key);

  @override
  State<FaceScanning> createState() => _FaceScanningState();
}

class _FaceScanningState extends State<FaceScanning> {

  late CameraController _controller;
  late FaceDetector _faceDetector;
  late bool _isDetectingFaces;

  @override
  void initState() {
    super.initState();
    _isDetectingFaces = false;
    _initializeCamera();
    _initializeFaceDetector();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.high,imageFormatGroup: ImageFormatGroup.yuv420);
    await _controller.initialize().then((_){
      print("_initializeCamera");
      _controller.startImageStream((image) {
        print('startImageStream');
        if (!_isDetectingFaces) {
          _isDetectingFaces = true;
          print('is detecting face');
          _processImage(image);
        }
      });
    });
  }

  void _initializeFaceDetector() {
    print("_initializeFaceDetector");
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
        enableClassification: true,
      ),
    );
  }

  Future<void> _processImage(CameraImage image) async {
    print("_processImage");

    final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormat.yuv420,
        planeData: [], // set default format
      ),
    );

    final faces = await _faceDetector.processImage(inputImage);
    print('faces.length ${faces.length}');

    if (faces.isNotEmpty) {
      print('faces is Not Empty');
      // Face detected, capture image here
      final capturedImage = await _controller.takePicture();
      // TODO: Do something with the captured image
      // Set the captured image to the User's registration images list
      User().regImages[2]=capturedImage;
      _controller.pausePreview();
    }
    _isDetectingFaces = false;
    print(User().regImages);
  }

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  @override
  void dispose() {
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('סרוק פנים',style: TextStyle(color: Colors.white),),
          SizedBox(height: 40.h,),
          Text('עמוד מול המצלמה',style: TextStyle(color: Colors.white)),
          SizedBox(height: 35.h,),
          Container(
            height: 300.h,
            width: 300.w,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white)
            ),
            child: FutureBuilder(
              future: _initializeCamera(),
                builder:(context,snapshot){
                if(snapshot.hasData) {
                  print('snapshot has data');
                    return _buildCameraPreview();
                  }
                else {
                  return CircularProgressIndicator();
                }
                }
            ),
          ),
          SizedBox(height: 70.h,),
          Container(
            height: 75.h,
            width: 284.w,
            decoration: BoxDecoration(
              color: Colors.green
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.pages_sharp,color: Colors.white,),
                SizedBox(width: 33.w,),
                const Text('סורק...',style: TextStyle(color: Colors.white),),
                User().regImages[2] !=null?Text('צולם בהצלחה',style: TextStyle(color: Colors.white),):Text(''),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _buildCameraPreview() {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller),
      );
  }
}
