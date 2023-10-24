import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:io';

import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/models/class_user.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:image/image.dart' as img;


class FaceScanning extends StatefulWidget {
  const FaceScanning({Key? key}) : super(key: key);

  @override
  State<FaceScanning> createState() => _FaceScanningState();
}

class _FaceScanningState extends State<FaceScanning> {

  late CameraController _controller;
  late Future<bool> cameraInitialization;
  final FaceDetector _faceDetector= GoogleMlKit.vision.faceDetector();
  bool isCapturing = false;


  @override
  void initState() {
    cameraInitialization = _initializeCamera();
    super.initState();
  }

  Future<bool> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _controller = CameraController(camera, ResolutionPreset.high,imageFormatGroup: ImageFormatGroup.yuv420);
    await _controller.initialize().then((_){
      print("_initializeCamera");
      _controller.startImageStream((image) {
        print('startImageStream');
        detectFaces(image);
      });
    });
    return true;
  }

  @override
  void dispose() {
    if (_controller.value.isStreamingImages) {
      _controller.stopImageStream();
    }
    _controller.dispose();
    _faceDetector.close();
    super.dispose();
  }

  /*void _initializeFaceDetector() {
    print("_initializeFaceDetector");
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableContours: true,
        enableClassification: true,
      ),
    );
  }*/


  /*void detectFaces(CameraImage image) async {
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromBytes(
      image.planes[0].bytes,
      buildMetaData(image),
    );

    final List<Face> faces = await _faceDetector.processImage(visionImage);

    if (faces.length > 0) {
      // Face detected
      // You can provide visual feedback or any other indication
    }
  }

  FirebaseVisionImageMetadata buildMetaData(CameraImage image) {
    return FirebaseVisionImageMetadata(
      rotation: ImageRotation.rotation0,  // Adjust based on orientation
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      planeData: image.planes.map(
            (plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }*/

  void detectFaces(CameraImage image) async {
    // Convert CameraImage to InputImage
    /*final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.rotation0deg,
        inputImageFormat: InputImageFormatValue.fromRawValue(image.format.raw)!, // Assuming YUV420
        planeData: image.planes.map(
              (plane) {
            return InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            );
          },
        ).toList(),
      ),
    );

    final List<Face> faces = await _faceDetector.processImage(inputImage);
    print('faces ${faces.length}');

    if (faces.isNotEmpty) {
      // Face detected
      // You can provide visual feedback or any other indication*/
    print('detect Faces');

    captureImage();
    await Future.delayed(Duration(seconds: 3));
       // introduce a slight delay
    _controller.pausePreview();
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Verification()));

    // }
  }

  void captureImage() async {
    print('capture image');
    if (isCapturing) {
      return;
    }
    isCapturing = true;
    if (_controller.value.isStreamingImages) {
      _controller.stopImageStream();
    }
    if (_controller != null) {
      final file = await _controller!.takePicture();
      //User().regImages[2] = file;
      final croppedFace = await cropFaceFromXFile(file);
      Uint8List croppedFaceBytes = img.encodePng(croppedFace!);
      final tempDir = await getTemporaryDirectory();
      final f1 = await File('${tempDir.path}/temp_image.png}').writeAsBytes(croppedFaceBytes);
      final xfile=XFile(f1.path);
      if(xfile!=null) {
        print('face detected successfully');
        User().regImages[2] = xfile;
      }


     }
    isCapturing = false;
  }

  Future<img.Image?> cropFaceFromXFile(XFile xFile) async {
    final inputImage = InputImage.fromFilePath(xFile.path);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    final List<Face> faces = await faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      img.Image oriImage = img.decodeImage(File(xFile.path).readAsBytesSync())!;
      Face face = faces[0];
      Rect rect = face.boundingBox;
      img.Image croppedImage = img.copyCrop(
        oriImage,
        x: rect.left.toInt(),
        y: rect.top.toInt(),
        width: rect.width.toInt(),
        height: rect.height.toInt(),
      );
      return croppedImage;
    }
    faceDetector.close();
    return null;
  }

 /* Future<void> _processImage(CameraImage image) async {
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
  }*/

  /*Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('סרוק פנים',style: TextStyle(color: Colors.black,fontFamily: 'PLONI',fontSize: 24.sp,fontWeight: FontWeight.w600),),
          SizedBox(height: 40.h,),
          Text('עמוד מול המצלמה',style: TextStyle(color: Colors.black,fontFamily: 'PLONI',fontSize: 16.sp,fontWeight: FontWeight.w400)),
          SizedBox(height: 35.h,),
          Stack(
            children:[
              FutureBuilder<bool>(
              future: cameraInitialization,
                builder:(context,snapshot){
                  if(snapshot.hasData) {
                    print('snapshot has data');
                    return _buildCameraPreview();
                  }
                  else {
                    return SizedBox(
                      height: 332.h,
                      width: 332.w,
                      child: Center(child: CircularProgressIndicator()));
                  }
                }
            ),
              Center(
                child: SizedBox(
                  height: 332.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 42.h,
                        width: 117.w,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9).withOpacity(0.3),
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Image.asset('assets/images/rec.png'),
                             SizedBox(width: 15.w,),
                            Text('...סורק',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
                            //User().regImages[2] !=null?Text('צולם בהצלחה',style: TextStyle(color: Colors.white),):Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),


          SizedBox(height: 60.h,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                width: 332.w,
                lineHeight: 17.h,
                percent: 1,
                animation: true,
                barRadius: const Radius.circular(16),
                linearGradient: LinearGradient(colors: [ Color.fromRGBO(254, 193, 216, 1), Color.fromRGBO(251, 39, 119, 1)], ),
                backgroundColor: Color.fromRGBO(247, 247, 247, 1),
                center: Padding(
                  padding: EdgeInsets.only(left: 270.w,),
                  child: Text('3/3',style: TextStyle(color: Colors.white, fontSize: 9.sp ),),
                ),
              ),
            ],
          ),
          SizedBox(height: 66.h,),

          Container(
            width: 332.w,
            height: 42.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Color(0xFF00DEDE),
            ),
            child: TextButton(
              child: Text('תמיכה',style: TextStyle(color: Colors.white,fontFamily: 'PLONI', fontSize: 18.sp, fontWeight: FontWeight.w500),),
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCameraPreview() {
    return Container(
     // width: 332.w,
      height: 332.h,

      child: OverflowBox(
        alignment: Alignment.center,
        child: Transform.rotate(
          angle: -pi / 2, // Rotate 90 degrees to the left
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: CameraPreview(_controller),
          ),
        ),
      ),
    );
  }
}



