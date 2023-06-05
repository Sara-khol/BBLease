import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bblease/class_user.dart';
import 'package:bblease/registration/registration_main.dart';
import 'package:bblease/registration/sucsses.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';


class LicenseBack extends StatefulWidget {
  const LicenseBack({Key? key}) : super(key: key);

  @override
  State<LicenseBack> createState() => _LicenseBackState();
}

class _LicenseBackState extends State<LicenseBack> {

  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  late XFile _imageBack;
  bool cameraOn=false;

  Future<void> awaitCameras() async {
    cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'סרוק רישיון',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 243.w,
              child: Text(
                'לצורך הסריקה נשתמש בטכנולוגית SC במידה וניתקלתם בבעיה פנו לנציג החברה',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 34.h),
            Container(
              height: 180.h,
              width: 170.w,
              decoration: BoxDecoration(
                color: Color(0xFFD4E7FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: InkWell(
                  onTap: _onCameraButtonPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo_camera_rounded, color: Colors.blueAccent,
                          size: 45.sp),
                      Text(
                        'פתח מצלמה',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueAccent,
                        ),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 120.w,
              child: Text(
                'רשיון נהיגה צד אחורי',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 160.h),
            Row(
              children: [
                SizedBox(width: 35.w),
                FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: ()=>_cameraController.pausePreview(),
                  tooltip: 'help',
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 180.w),

                FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: _onUploadButtonPressed,
                  tooltip: 'Upload',
                  child: const Icon(
                    Icons.file_upload_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onCameraButtonPressed() async {
    print('camera button pressed');
    final cameras = await availableCameras(); // Get a list of available cameras
    final camera = cameras.first; // Use the first camera
    _cameraController = CameraController(camera, ResolutionPreset.high,imageFormatGroup: ImageFormatGroup.yuv420,);
    await _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraOn=true;
      });
    });
    // Show the camera preview on the screen
    print('before showCameraPreview');
    showCameraPreview();
    print('after showCameraPreview');
  }

  void showCameraPreview(){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        print('showCameraPreview');
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Center(
                child: Transform.scale(
                  scale: MediaQuery.of(context).size.aspectRatio * _cameraController.value.aspectRatio,
                  child: Transform.rotate(
                      angle: -_cameraController.description.sensorOrientation * pi / 180,
                      child: CameraPreview(_cameraController)),
                ),
              ),
              Center(
                  child: Container(
                    height: 250.h,
                    width: 350.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow,width: 3)
                    ),
                  )
              ),
              Positioned(
                bottom: 0,
                right: 170.w,
                left: 170.w,
                child: ElevatedButton(
                  onPressed: () async{
                    XFile xfile=await _cameraController.takePicture();
                    setState(() {
                      _imageBack= xfile;
                      _cameraController.pausePreview();
                      if (_imageBack != null) {
                        print('_imageBack $_imageBack');
                        User().regImages[1]=_imageBack;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Success(index: 1)),
                        );
                      }
                    });
                  },
                  child: Icon(Icons.circle_outlined),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void _onUploadButtonPressed() async {
    if(cameraOn) {
      _cameraController.pausePreview();
      cameraOn=false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    // FilePicker.pickFiles(type: FileType.image,allowMultiple: false,);
    if(result != null) {
      setState(() {
        _imageBack = result;
        // Registration.of(context)?.front=_imageBack;
      });
      User().regImages[1]=_imageBack;
    }
    //else {
    //   // User canceled the file picker
    // }
    showImagePreview;

  }

  showImagePreview(){
    print('showImagePreview');
    if(_imageBack!=null) {
      print(_imageBack);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Success(index: 0,)),
      );
    }
    else {
      const SizedBox(
        height: 210,
        width: 375,
        child: Center(
          child: Positioned.fill(child: Text('No image selected.')),
        ),
      );
    }
  }
}
  