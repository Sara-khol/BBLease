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
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'face_scanning.dart';
import 'license_front.dart';
import 'personal_details_form.dart';


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
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(15, 17, 21, 1),
                fontFamily: 'PLONI',
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 243.w,
              child: Text(
                'לצורך הסריקה נשתמש בטכנולוגית SC במידה וניתקלתם בבעיה פנו לנציג החברה',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color:  Color.fromRGBO(15, 17, 21, 1),
                  fontFamily: 'PLONI',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            Container(
              height: 380.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: InkWell(
                  onTap: _onCameraButtonPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/rect.png',),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Text(
                'רשיון נהיגה צד אחורי',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color:  Color.fromRGBO(15, 17, 21, 1),
                  fontFamily: 'PLONI',
                ),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 53.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearPercentIndicator(
                  width: 332.w,
                  lineHeight: 17.h,
                  percent: 0.66,
                  animation: true,
                  barRadius: const Radius.circular(16),
                  linearGradient: LinearGradient(colors: [ Color.fromRGBO(254, 193, 216, 1), Color.fromRGBO(251, 39, 119, 1)],),
                  backgroundColor: Color.fromRGBO(247, 247, 247, 1),
                  center: Padding(
                    padding: EdgeInsets.only(left: 60.w,),
                    child: Text('2/3',style: TextStyle(color: Colors.white, fontSize: 9.sp),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              height: 42.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(251, 37, 118, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PersonalDetailsForm()));
                  },
                  child: const Text('הבא (רק לצורך הדגמה)',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 129.w,
                  height: 42.h,
                  child:  FloatingActionButton.extended(
                    label: Text('תמיכה',),
                    backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                  onPressed: ()=>_cameraController.pausePreview(),
                  //tooltip: 'help',

                    icon: Image.asset('assets/images/PhoneW.png',width: 18.w,),
                ),
              ),
                SizedBox(width: 20.w),

                SizedBox(
                  width: 183.w,
                  height: 42.h,
                  child: FloatingActionButton.extended(
                    label: Text('העלאת תמונה'),
                    backgroundColor:  Color.fromRGBO(0, 222, 222, 1),
                  onPressed: _onUploadButtonPressed,
                  tooltip: 'Upload',
                    icon:  Image.asset('assets/images/Upload.png',width: 18.w,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
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
  