
import 'dart:ui';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bblease/services/support.dart' as support;
import 'face_detector.dart';


class FaceScanning extends StatefulWidget {
  const FaceScanning({Key? key}) : super(key: key);

  @override
  State<FaceScanning> createState() => _FaceScanningState();
}

class _FaceScanningState extends State<FaceScanning> {

  /*late CameraController _controller;
  late Future<void> cameraInitialization;
  final FaceDetector _faceDetector= GoogleMlKit.vision.faceDetector();
  bool isCapturing = false;


  @override
  void initState() {
    //cameraInitialization = _initializeCamera();
    super.initState();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(camera, ResolutionPreset.high, imageFormatGroup: ImageFormatGroup.yuv420);
    await _controller.initialize();

    _controller.startImageStream((CameraImage image) {
      detectFaces(image);
    });

    if (mounted) {
      setState(() {});
    }
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
    final inputImage = InputImage.fromBytes(
      bytes: _concatenatePlanes(image.planes),
      inputImageData: InputImageData(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        imageRotation: InputImageRotation.rotation270deg,
        inputImageFormat: InputImageFormat.yuv420,
        planeData: [], // Adjust rotation based on your camera orientation
      ),
    );

    final List<Face> faces = await _faceDetector.processImage(inputImage);

    if (faces.isNotEmpty) {
      captureImage();
    }
  }


  Uint8List _concatenatePlanes(List<Plane> planes) {
    // Concatenate the planes of a CameraImage into a single Uint8List
    final ByteData buffer = ByteData(planes.map((plane) => plane.bytes.length).reduce((value, element) => value + element));
    int offset = 0;
    planes.forEach((plane) {
      buffer.setUint8(offset, plane.bytes.first);
      offset += plane.bytes.length;
    });
    return buffer.buffer.asUint8List();
  }

  void captureImage() async {
    if (isCapturing) {
      return;
    }
    isCapturing = true;
    if (_controller.value.isStreamingImages) {
      _controller.stopImageStream();
    }
    if (_controller != null) {
      final file = await _controller!.takePicture();
      // Handle the captured image file as needed
    }
    isCapturing = false;
  }

  Future<img.Image?> cropFaceFromXFile(XFile xFile) async {
    final inputImage = InputImage.fromFilePath(xFile.path);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    final List<Face> faces = await faceDetector.processImage(inputImage);
print('faces.length: ${faces.length}');
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
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('סרוק פנים',style: TextStyle(color: Colors.black,fontSize: 28.sp,fontWeight: FontWeight.w600),),
            SizedBox(height: 5.h,),
            Text('עמוד מול המצלמה',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.w400)),
            SizedBox(height: 35.h,),
            Expanded(
              child: Stack(
                  children:[
                    Center(child: CameraFaceDetection()),
                    /*FutureBuilder(
                        future: _initializeCamera(),
                        builder:(context,snapshot){
                          if(snapshot.hasData) {
                            print('snapshot has data');
                            return _buildCameraPreview();
                          }else if (snapshot.hasError) {
                            // Handle error
                            return Text('Error initializing camera: ${snapshot.error}');
                          }
                          else {
                            return SizedBox(
                                height: 332.h,
                                width: 332.w,
                                child: Center(child: CircularProgressIndicator()));
                          }
                        }
                    ),*/
                    Center(
                      child:/* SizedBox(
                        height: 332.h,
                        child:*/ Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 48.h,
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
                                  Text('...סורק',style: TextStyle(color: Colors.black,fontSize: 22.sp),),
                                  //User().regImages[2] !=null?Text('צולם בהצלחה',style: TextStyle(color: Colors.white),):Text(''),
                                ],
                              ),
                            ),
                          ],
                        ),
                     // ),
                    ),
                  ]),
            ),
            SizedBox(height: 60.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearPercentIndicator(
                  width: 332.w,
                  lineHeight: 17.h,
                  percent: 0.99,
                  animation: true,
                  barRadius: const Radius.circular(16),
                  linearGradient: LinearGradient(colors: [ Color.fromRGBO(254, 193, 216, 1), Color.fromRGBO(251, 39, 119, 1)]),
                  backgroundColor: Color.fromRGBO(247, 247, 247, 1),
                  center: Padding(
                    padding: EdgeInsets.only(left: 270.w,),
                    child: Text('3/3',style: TextStyle(color: Colors.white, fontSize: 12.sp ,height: 0.11),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60.h,),
            Container(
              width: 332.w,
              height: 44.h,
              margin:EdgeInsets.only(bottom:40.sp ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: turquoiseColorApp,
              ),
              child: TextButton(
                child: Text('תמיכה',
                    textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,height: 1),),
                onPressed: () {
                  support.call;
                  //TODO: call for help
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  _controller.startImageStream((image) {
  print('startImageStream');
  detectFaces(image);
  });*/

  /*_buildCameraPreview() {
    print('_buildCameraPreview');
    Container(
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
  }*/
}