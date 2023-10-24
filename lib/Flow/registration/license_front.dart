import 'dart:math';
import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/registration/text_recognition.dart';
import 'package:bblease/models/class_user.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:capped_progress_indicator/capped_progress_indicator.dart';

import 'license_back.dart';


class LicenseFront extends StatefulWidget {
  const LicenseFront({Key? key}) : super(key: key);

  @override
  State<LicenseFront> createState() => _LicenseFrontState();
}

class _LicenseFrontState extends State<LicenseFront> {

  late List<CameraDescription> cameras;
  late CameraController _cameraController;
  late XFile _imageFront;
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 110.h,),
            Text(
              'סרוק רישיון',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(15, 17, 21, 1),
                fontFamily: 'PLONI',
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: 260.w,
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
            SizedBox(height: 60.h),
            SizedBox(
              height: 270.h,
              child: Stack(
                children: [
                  Center(child: Image.asset('assets/images/rect.png',)),
                  Center(child: Text('פתח מצלמה',style: TextStyle(color: Color(0xFFD9D9D9),fontFamily: 'PLONI',fontSize: 20.sp))),
                  InkWell(
                    onTap: _onCameraButtonPressed,
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h,),
            Text(
              'רשיון נהיגה צד קדמי',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color:  Color.fromRGBO(15, 17, 21, 1),
                fontFamily: 'PLONI',
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 53.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearPercentIndicator(
                  width: 332.w,
                  lineHeight: 17.h,
                  percent: 0.33,
                  animation: true,
                  barRadius: const Radius.circular(16),
                  linearGradient: LinearGradient(colors: [ Color.fromRGBO(254, 193, 216, 1), Color.fromRGBO(251, 39, 119, 1)], ),
                  backgroundColor: Color.fromRGBO(247, 247, 247, 1),
                  center: Padding(
                    padding: EdgeInsets.only(right: 140.w,),
                    child: Text('1/3',style: TextStyle(color: Colors.white, fontSize: 9.sp ),),
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
                         MaterialPageRoute(builder: (context) => const LicenseBack()));
                    //errorNoMatch(context,LicenseFront());
                  },
                  child: const Text('הבא (רק לצורך הדגמה)',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SizedBox(width: 129.w ,height: 42.h,),
                SizedBox(
                  width: 129.w,
                  height: 42.h,
                  child: FloatingActionButton.extended(
                    label: Text('תמיכה',),
                    heroTag: "btn2",
                    backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    onPressed: ()=>_cameraController.pausePreview(),
                    icon: Image.asset('assets/images/PhoneW.png',width: 18.w,),
                  ),
                ),
                SizedBox(width: 20.w),

                SizedBox(
                  width: 183.w,
                  height: 42.h,
                  child: FloatingActionButton.extended(

                    label: Text('העלאת תמונה'),
                    heroTag: "btn1",
                    backgroundColor:  Color.fromRGBO(0, 222, 222, 1),
                    onPressed: _onUploadButtonPressed,
                    //tooltip: 'Upload',
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

  // void showCameraPreview(){
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       print('showCameraPreview');
  //       if (!_cameraController.value.isInitialized) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       return Padding(
  //         padding: EdgeInsets.only(bottom: 250.h),
  //         child: SizedBox(
  //           //height: MediaQuery.of(context).size.height,
  //           child: Stack(
  //             children: [
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 //height: 380.h,
  //                 child: Transform.scale(
  //                   scale: MediaQuery.of(context).size.aspectRatio * _cameraController.value.aspectRatio,
  //                   child: Transform.rotate(
  //                       angle: -_cameraController.description.sensorOrientation * pi / 180,
  //                       child: CameraPreview(_cameraController)
  //                 ),
  //                   ),
  //               ),
  //               //Image.asset('assets/images/rect.png',),
  //               Positioned(
  //                 bottom: 0,
  //                 right: 170.w,
  //                 left: 170.w,
  //                 child: ElevatedButton(
  //                       onPressed: () async{
  //                         XFile xfile=await _cameraController.takePicture();
  //                         setState(() {
  //                           _imageFront= xfile;
  //                           _cameraController.pausePreview();
  //                           if (_imageFront != null) {
  //                             print('_imageFront $_imageFront');
  //                             //var registration = Registration.of(context);
  //                             //print('registration: $registration');
  //                             //print('registration.front: ${registration?.front}');
  //                             //registration?.front = _imageFront;
  //                             //print('Registration.of(context)?.front ${Registration.of(context)?.front}');
  //                             User().regImages[0]=_imageFront;
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(builder: (context) => Success(index: 0)),
  //                             );
  //                           }
  //                         });
  //                       },
  //                     child: Icon(Icons.circle_outlined),
  //                   ),
  //               ),
  //               // Container( //show captured image
  //               //   padding: EdgeInsets.all(30),
  //               //   child: _imageFront == null?
  //               //   Text("No image captured"):
  //               //   Image.file(File(_imageFront!.path), height: 300,),
  //               //   //display captured image
  //               // )
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  //
  // }
  void showCameraPreview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (!_cameraController.value.isInitialized) {
          return Center(child: CircularProgressIndicator());
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 1,
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 380.w,
                  //height: 380.h,
                  child: OverflowBox(
                    alignment: Alignment.center,  // Change this if you want to crop a different section
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Container(
                        width: 380.w,
                        //height: 380.h / _cameraController.value.aspectRatio,
                        child: Transform.rotate(
                          angle: -_cameraController.description.sensorOrientation * pi / 180,
                          child: CameraPreview(_cameraController),
                        ),
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
                   color: Color(0xFF00DEDE),
                     borderRadius: BorderRadius.all(Radius.circular(70))
                 ),

                 child: TextButton(
                     onPressed: () async{
                     XFile xfile=await _cameraController.takePicture();
                     uploadSucceed(context,LicenseFront(),LicenseBack());
                     setState(() {
                       _imageFront= xfile;
                       _cameraController.pausePreview();
                       if (_imageFront != null) {
                         print('_imageFront $_imageFront');
                         //var registration = Registration.of(context);
                         //print('registration: $registration');
                         //print('registration.front: ${registration?.front}');
                         //registration?.front = _imageFront;
                         //print('Registration.of(context)?.front ${Registration.of(context)?.front}');
                         User().regImages[0]=_imageFront;
                         TextRecognition(0);
                         /*Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => LicenseBack()),
                         );*/
                       }
                     });
                   },
                   child: Text('צלם',style: (TextStyle(color: Colors.white,fontFamily: 'PLONI', )),),
                 ),
               ),)
            ],
          ),
        );
      },
    );
  }


  // void _getFromCamera() async{
  //   XFile? pickedFile=await ImagePicker().pickImage(source: ImageSource.camera);
  //   _imageFront = File(pickedFile!.path);
  //   Navigator.pop(context);
  // }

  void _onUploadButtonPressed() async {
    if(cameraOn) {
      _cameraController.pausePreview();
      cameraOn=false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    // FilePicker.pickFiles(type: FileType.image,allowMultiple: false,);
    if(result != null) {
      setState(() {
        _imageFront = result;
      });
      User().regImages[0]=_imageFront;
    }
    //else {
    //   // User canceled the file picker
    // }
    showImagePreview;

  }

  showImagePreview(){
    print('showImagePreview');
    if(_imageFront!=null) {
      print(_imageFront);

    }
     else {

       SizedBox(
        height: 210.h,
        width: 375.w,
        child: Center(
          child: Positioned.fill(child: Text('No image selected.')),
        ),
      );
    }
  }
}
