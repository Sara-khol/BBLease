import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/registration/face_scanning.dart';
import 'package:bblease/Flow/registration/license_details.dart';
import 'package:bblease/Flow/registration/personal_details_form.dart';
import 'package:bblease/Flow/registration/text_recognition.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/services/support.dart' as support;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bblease/utils/my_colors.dart';

import '../../landspace_widget.dart';
import '../../services/camera_service.dart' show CameraService;


class LicenseBack extends StatefulWidget {
  const LicenseBack({super.key, required this.index, this.orderId});
  final int index;
  final int? orderId;

  @override
  State<LicenseBack> createState() => _LicenseBackState();
}

class _LicenseBackState extends State<LicenseBack> {

  late XFile _imageBack;
  bool cameraOn=false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debugPrint('dispose 2');
 /*   if(_cameraController!=null && _cameraController!.value.isInitialized) {
      if (!kIsWeb) {
        _cameraController?.dispose();
        debugPrint('dispose camera 2');
      } else {
        debugPrint('⚠️ Skip dispose on Web');
      }
    }*/
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LandSpaceWidget(mainWidget: buildContent(),
        imageProperties:ImageProperties('l_register2.png', 618.w,'תמונת הרשמה שלב 2'),showAppBar: false)
    );
  }

  buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 110.h,),
          Text(
            'סרוק רישיון',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
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
              fontWeight: FontWeight.normal,
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
                Center(child: Image.asset('assets/images/rect.png', semanticLabel: 'frame',)),
                Center(child: Text('פתח מצלמה',style: TextStyle(color: const Color(0xFFD9D9D9),fontSize: 24.sp))),
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
              fontWeight: FontWeight.normal,
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
                  linearGradient:  LinearGradient(colors: [ pinkColorApp.withValues(alpha: 0.5),
                    pinkColorApp], ),
                  backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
                  center: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 65.w,),
                      child: Text('2/3',style: TextStyle(color: Colors.white, fontSize: 9.sp ),),
                    ),
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
          //         style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,color:Colors.white),
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,

                      elevation: 2,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                    onPressed: () => support.call,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/Phone.png",
                          width: 24.sp.clamp(20.0, 28.0),
                          height: 24.sp.clamp(20.0, 28.0),
                          color: Colors.white,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'תמיכה',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20.w),

                SizedBox(
                  width: 183.w,
                  height: 48.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      elevation: 2,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                    onPressed: _onUploadButtonPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.file_upload_outlined,
                          size: 24.sp.clamp(20.0, 28.0),
                          color: Colors.white,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'העלאת תמונה',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // SizedBox(height: 40),
        ],
      ),
    );}

  // void _onCameraButtonPressed() async {
  //  if(widget.controller==null || !widget.controller!.value.isInitialized) {
  //    final cameras = await availableCameras(); // Get a list of available cameras
  //    // בוחר מצלמה אחורית אם קיימת
  //    final camera = cameras.firstWhere(
  //          (cam) => cam.lensDirection == CameraLensDirection.back,
  //      orElse: () => cameras.first,
  //    );
  //    _cameraController = CameraController(camera, ResolutionPreset.high,
  //      imageFormatGroup: ImageFormatGroup.yuv420,);
  //
  //    await _cameraController!.initialize().then((_) {
  //      if (!mounted) {
  //        return;
  //      }
  //
  //      setState(() {
  //        cameraOn = true;
  //      });
  //    });
  //    debugPrint('📸 Camera initialized successfully!');
  //
  //  }
  //  else {
  //    debugPrint('📸 Camera already initialized.');
  //
  //    _cameraController = widget.controller;
  //    setState(() {
  //      cameraOn = true;
  //    });
  //  }
  //   showCameraPreview();
  // }

  void _onCameraButtonPressed() async {
/*    try {
      if (widget.controller == null || !widget.controller!.value.isInitialized) {
        // Dispose previous controller if exists
        if (_cameraController != null) {
          await _cameraController!.dispose();
        }

        final cameras = await availableCameras();
        final camera = cameras.firstWhere(
              (cam) => cam.lensDirection == CameraLensDirection.back,
          orElse: () => cameras.first,
        );

        _cameraController = CameraController(
          camera,
          ResolutionPreset.high,
          imageFormatGroup: ImageFormatGroup.yuv420,
        );

        await _cameraController!.initialize();
        if (mounted) {
          setState(() => cameraOn = true);
        }
        debugPrint('📸 Camera initialized successfully!');
      } else {
        debugPrint('📸 Camera already initialized.');
        _cameraController = widget.controller;
        setState(() => cameraOn = true);
      }

      showCameraPreview();
    } catch (e) {
      debugPrint('❌ Camera initialization failed: $e');
      if (mounted) {
        setState(() => cameraOn = false);
      }
    }*/
    await CameraService().init(useFront: false); // אחורית
    final controller = CameraService().controller;

    if (!mounted || controller == null) return;

    setState(() {
      cameraOn = true;
    });
  showCameraPreview(controller);
  }


  void showCameraPreview(CameraController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Widget cameraPrev = Center(
          child: kIsWeb
              ? SizedBox(
            width: 380.w,
            height: 280.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CameraPreview(controller,
                key: ValueKey(DateTime.now().millisecondsSinceEpoch)),
            ),
          )
              : SizedBox(
            width: 380.w,
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 380.w,
                  child: CameraPreview(controller,
                    key: ValueKey(DateTime.now().millisecondsSinceEpoch)),
                ),
              ),
            ),
          ),
        );

        Widget cameraButton= Container(
          height:kIsWeb?60.h: 55.h,
          width:kIsWeb?140.h: 80.w,
          decoration: BoxDecoration(
              color: turquoiseColorApp,
              borderRadius: const BorderRadius.all(Radius.circular(70))
          ),

          child: TextButton(
            onPressed: () async{
              XFile xfile=await controller!.takePicture();
              widget.index==1
                  ?uploadSucceed(context,LicenseBack(index: widget.index,),const FaceScanning())
                  :uploadSucceed(context,LicenseBack(index: widget.index,orderId: widget.orderId,),LicenseDetails(index: widget.index,orderId: widget.orderId,));
              setState(() {
                _imageBack= xfile;
                controller!.pausePreview();
                widget.index==1?User().regImages[1]=_imageBack:User().additionalDriver.images[1]=_imageBack;
                widget.index==1 && !kIsWeb ?TextRecognition(1):null;});
            },
            child:  Text('צלם',style: (TextStyle(color: Colors.white,fontSize: kIsWeb?22.sp:18.sp )),),
          ),
        );
        if (!controller!.value.isInitialized) {
          return Center(child: CircularProgressIndicator(color: pinkColorApp,));
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 1,
          child:kIsWeb?Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [Container(margin:EdgeInsets.only(bottom: 15.h),child: cameraPrev),cameraButton],),
          ): Stack(
            children: [
              cameraPrev,
              Positioned(
                bottom: 230.h,
                right: 130.w,
                child: cameraButton,
              )
            ],
          ),
        );
      },
    );
  }


  void _onUploadButtonPressed() async {
    if(cameraOn) {
     CameraService().pauseCamera();
      cameraOn=false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(result != null) {
      uploadSucceed(context,LicenseBack(index: 1,),/*PersonalDetailsForm()*/const FaceScanning());
      setState(() {
        _imageBack= result;
        //_cameraController.pausePreview();
        widget.index==1
            ? {
                User().regImages[1] = _imageBack,
        if(!kIsWeb){
          TextRecognition(1)
        }
              }
            :User().additionalDriver.images[1]=_imageBack;

            });
    }
    //showImagePreview;
  }

}