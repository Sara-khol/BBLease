import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/registration/face_scanning.dart';
import 'package:bblease/Flow/registration/text_recognition.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/services/support.dart' as support;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bblease/utils/my_colors.dart';

import '../../utils/my_colors.dart';


class LicenseBack extends StatefulWidget {
  const LicenseBack({Key? key, required this.index}) : super(key: key);
  final int index;

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
    if(_cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 110.h,),
            Text(
              'סרוק רישיון',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: blackColorApp,
                fontFamily: 'PLONI',
                height: 1,
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'לצורך הסריקה נשתמש בטכנולוגית SC\n במידה וניתקלתם בבעיה פנו לנציג החברה',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
                color: blackColorApp,
                fontFamily: 'PLONI',
                height: 1,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 63.h),
            SizedBox(
              height: 254.h,
              child: Stack(
                children: [
                  Center(child: Image.asset('assets/images/rect.png',)),
                  Center(child: Text('פתח מצלמה',style: TextStyle(color: Color(0xFFD9D9D9),fontSize: 24.sp))),
                  InkWell(
                    onTap: _onCameraButtonPressed,
                  ),
                ],
              ),
            ),
            SizedBox(height: 63.h,),
            Text(
              'רשיון נהיגה צד אחורי',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: blackColorApp,
                fontFamily: 'PLONI',
                height: 1,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 60.h),
            Visibility(
              visible: widget.index==1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearPercentIndicator(
                    width: 332.w,
                    lineHeight: 17.h,
                    percent: 0.67,
                    animation: true,
                    barRadius: const Radius.circular(16),
                    linearGradient: LinearGradient(colors: [ Color.fromRGBO(254, 193, 216, 1), Color.fromRGBO(251, 39, 119, 1)], ),
                    backgroundColor: Color.fromRGBO(247, 247, 247, 1),
                    center: Padding(
                      padding: EdgeInsets.only(left: 65.w,),
                      child: Text('2/3',style: TextStyle(color: Colors.white, fontSize: 12.sp ,height: 0.11),),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 36.h,
            //   width: 332.w,
            //   child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: Color.fromRGBO(251, 37, 118, 1),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(100),
            //         ),
            //       ),
            //       onPressed: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>  FaceScanning()));
            //       },
            //       child:  Text(
            //         'הבא (רק לצורך הדגמה)',
            //         style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color:Colors.white),
            //       )),
            // ),
            SizedBox(height: 60.h),
            Visibility(
              visible: widget.index==1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 129.w,
                    height: 48.h,
                    child: FloatingActionButton.extended(
                      label: Text('תמיכה',style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                      heroTag: "btn2",
                      elevation: 2,
                      backgroundColor: turquoiseColorApp,
                      onPressed: ()=>support.call,
                        icon: ImageIcon(
                          AssetImage("assets/icons/Phone.png"),
                          size: 22.sp,
                            color: Colors.white,
                        ),),
                  ),
                  SizedBox(width: 20.w),

                  SizedBox(
                    width: 183.w,
                    height: 48.h,
                    child: FloatingActionButton.extended(
                      label: Text('העלאת תמונה',style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                      heroTag: "btn1",
                      elevation: 2,
                      backgroundColor: turquoiseColorApp,
                      onPressed: _onUploadButtonPressed,
                      icon:  Icon(Icons.file_upload_outlined,size: 22.sp,color: Colors.white,)
                    ),
                  ),
                ],
              ),
            ),
           // SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  void _onCameraButtonPressed() async {
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
    showCameraPreview();
  }

  void showCameraPreview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (!_cameraController.value.isInitialized) {
          return Center(child: CircularProgressIndicator(color: pinkColorApp,));
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 1,
          child: Stack(
            children: [
              Center(
                child: Container(
                  width: 380.w,
                  //height: 380,
                  child: OverflowBox(
                    alignment: Alignment.center,  // Change this if you want to crop a different section
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        width: 380.w,
                        //height: 380 / _cameraController.value.aspectRatio,
                        /*child: Transform.rotate(
                          angle: -_cameraController.description.sensorOrientation * pi / 180,*/
                          child: CameraPreview(_cameraController),
                        //),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 230.h,
                right: 130.w,
                child:  Container(
                  height: 40.h,
                  width: 80.w,
                  decoration: BoxDecoration(
                      color: turquoiseColorApp,
                      borderRadius: BorderRadius.all(Radius.circular(70))
                  ),
                  child: TextButton(
                    onPressed: () async{
                      XFile xfile=await _cameraController.takePicture();
                      widget.index==1?uploadSucceed(context,LicenseBack(index: 1),FaceScanning()):null;
                      setState(() {
                        _imageBack= xfile;
                        _cameraController.pausePreview();
                        if (_imageBack != null) {
                          User().regImages[1]=_imageBack;
                          TextRecognition(1);
                        }
                      });
                    },
                    child: Text('צלם',style: (TextStyle(color: Colors.white, )),),
                  ),
                ),)
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
    if(result != null) {
      uploadSucceed(context,LicenseBack(index: 1),FaceScanning());
      setState(() {
        _imageBack= result;
        //_cameraController.pausePreview();
        if (_imageBack != null) {
          User().regImages[1]=_imageBack;
          TextRecognition(1);
        }
      });
    }
    //showImagePreview;
  }

  showImagePreview(){
    if(_imageBack!=null) {
      print(_imageBack);
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
