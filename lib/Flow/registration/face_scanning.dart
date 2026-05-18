import 'package:bblease/Flow/registration/verification.dart';
import 'package:bblease/services/support.dart' as support;
import 'package:bblease/utils/common_funcs.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../../services/camera_service.dart';
import 'face_detector.dart';


class FaceScanning extends StatefulWidget {
  const FaceScanning({super.key});

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

 late CameraController controller;
 bool cameraReady = false;
 // True once the user has refused camera permission, so we render an
 // in-screen retry/settings UI instead of an infinite spinner. We deliberately
 // do NOT pop the route — the registration flow uses pushReplacement-style
 // navigation, so popping would land the user back on StartRegistration.
 bool cameraDenied = false;

  @override
  initState()  {
    super.initState();
    // Defer until context is mounted so the permission dialog/toast can use it.
    WidgetsBinding.instance.addPostFrameCallback((_) => _initCamera());
  }

 Future<void> _initCamera() async {
   if (!mounted) return;
   // Reset state on retry so the spinner shows while we ask again.
   if (cameraDenied) {
     setState(() {
       cameraDenied = false;
     });
   }
   if (!await CameraService.ensureGrantedWithUi(context)) {
     if (!mounted) return;
     setState(() {
       cameraDenied = true;
     });
     return;
   }
   try {
     await CameraService().init(useFront: true);
   } catch (e) {
     debugPrint('❌ Camera init failed: $e');
     if (!mounted) return;
     CommonFuncs().showMyToast('שגיאה בפתיחת המצלמה');
     setState(() {
       cameraDenied = true;
     });
     return;
   }
   if (!mounted) return;
   controller = CameraService().controller!;

   setState(() {
    cameraReady=true;
   });
 }

 Widget _buildPermissionDeniedUi() {
   return Padding(
     padding: EdgeInsets.symmetric(horizontal: 24.w),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         Icon(Icons.no_photography_outlined,
             size: 56.sp, color: Colors.black54),
         SizedBox(height: 12.h),
         Text(
           'נדרשת הרשאת מצלמה',
           textAlign: TextAlign.center,
           style: TextStyle(
               fontSize: 20.sp,
               fontWeight: FontWeight.bold,
               color: Colors.black),
         ),
         SizedBox(height: 8.h),
         Text(
           'כדי לסרוק את הפנים, יש לאפשר גישה למצלמה.',
           textAlign: TextAlign.center,
           style: TextStyle(fontSize: 14.sp, color: Colors.black54),
         ),
         SizedBox(height: 16.h),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             ElevatedButton(
               style: ElevatedButton.styleFrom(
                 backgroundColor: turquoiseColorApp,
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(100)),
               ),
               onPressed: openAppSettings,
               child: Text('פתח הגדרות',
                   style: TextStyle(
                       color: Colors.white, fontSize: 14.sp)),
             ),
             SizedBox(width: 12.w),
             OutlinedButton(
               style: OutlinedButton.styleFrom(
                 shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(100)),
               ),
               onPressed: _initCamera,
               child: Text('נסה שוב',
                   style: TextStyle(
                       color: Colors.black, fontSize: 14.sp)),
             ),
           ],
         ),
         SizedBox(height: 8.h),
         // Escape hatch — registration can proceed without the face image.
         // ApiService.faceRecognition is defensive about regImages[2] being
         // null (sends a hasFace=1 flag), so the customer just gets a manual
         // approval step on the server side.
         TextButton(
           onPressed: _skipFaceScan,
           child: Text(
             'המשך בלי סריקה',
             style: TextStyle(
                 fontSize: 14.sp,
                 color: Colors.black54,
                 decoration: TextDecoration.underline),
           ),
         ),
       ],
     ),
   );
 }

 void _skipFaceScan() {
   Navigator.push(
     context,
     MaterialPageRoute(builder: (context) => const Verification()),
   );
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandSpaceWidget(mainWidget: buildContent(),
        imageProperties:ImageProperties('l_register3.png', 618.w,'תמונת הרשמה שלב 3'),showAppBar: false,));
  }

  buildContent() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40.h,),
          Text('סרוק פנים',style: TextStyle(color: Colors.black,fontSize: 28.sp,fontWeight: FontWeight.bold),),
          SizedBox(height: 5.h,),
          Text('עמוד מול המצלמה',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.normal)),
          SizedBox(height: 35.h,),
          Expanded(
            child:Center(
              child: cameraReady
                  ? Column(
                children: [
                  Expanded(
                    child: CameraPreview(
                      controller,
                      key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: _capturePicture,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.camera, size: 20.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'צלם',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              )
                  : cameraDenied
                      ? _buildPermissionDeniedUi()
                      : const CircularProgressIndicator(),
            )
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
                linearGradient:  LinearGradient(colors: [  pinkColorApp.withValues(alpha: 0.5),
                pinkColorApp,]),
                center: Padding(
                  padding: EdgeInsets.only(left: 270.w,),
                  child: Text('3/3',style: TextStyle(color: Colors.white, fontSize: 9.sp )),
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
                    fontWeight: FontWeight.normal,height: 1),),
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const Verification(),));
               support.call;

              },
            ),
          ),
        ],
      ),
    );}

 void _capturePicture() async {
   try {
     // Pausing preview works on both web and mobile
     await CameraService().pauseCamera();

     // Take a picture works on both web and mobile
     XFile file = await controller.takePicture();
     debugPrint("Picture captured: ${file.path}");

     // Store the captured image
     User().regImages[2] = file;

     // Navigate to the Verification screen
     Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => const Verification(),
         ));
   } catch (e) {
     // Handle any exceptions that might occur during capture
     debugPrint("Error during capture: $e");
   }
  }

  @override
  void dispose() {
    CameraService().dispose();
    super.dispose();
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