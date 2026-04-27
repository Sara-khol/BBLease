import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/registration/text_recognition.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bblease/services/support.dart' as support;
import '../../landspace_widget.dart';
import '../../services/camera_service.dart';
import 'license_back.dart';
// import 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;

class LicenseFront extends StatefulWidget {
  const LicenseFront({super.key, required this.index, this.orderId});
  final int index;
  final int? orderId;

  @override
  State<LicenseFront> createState() => _LicenseFrontState();
}

class _LicenseFrontState extends State<LicenseFront>  {
  late List<CameraDescription> cameras;
  late XFile _imageFront;
  bool cameraOn = false;



  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
   // WidgetsBinding.instance.removeObserver(this);
    debugPrint('dispose 1');
   // if(_cameraController!=null && _cameraController!.value.isInitialized) {
      //_cameraController!.dispose();
    // debugPrint('dispose camera 1');

    //}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:      LandSpaceWidget(mainWidget: buildContent(),imageProperties:
      ImageProperties('l_register1.png', 618.w,'תמונת הרשמה שלב 1'),showAppBar: false,)
    );
  }

  buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 80.h,),
          Text(
            'סרוק רישיון',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: blackColorApp,
              fontFamily: 'PLONI',
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            'לצורך הסריקה נשתמש בטכנולוגית SC\n במידה וניתקלתם בבעיה פנו לנציג החברה',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.normal,
                color:  blackColorApp,
                fontFamily: 'PLONI',
                height: 1
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 254.h,
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                      'assets/images/rect.png', semanticLabel: 'frame',
                    )),
                Center(
                    child: Text('פתח מצלמה',
                        style: TextStyle(
                            color: const Color(0xFFD9D9D9), fontSize: 24.sp))),
                InkWell(
                  onTap:
                  () async{
                    _onCameraButtonPressed();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 63.h,
          ),
          Text(
            'רשיון נהיגה צד קדמי',
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
                  percent: 0.33,
                  animation: true,
                  barRadius: const Radius.circular(16),
                  linearGradient:  LinearGradient(
                    colors: [
                     pinkColorApp.withValues(alpha: 0.5),
                      pinkColorApp
                    ],
                  ),
                  backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
                  center: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 140.w,
                      ),
                      child: Text(
                        '1/3',
                        style: TextStyle(color: Colors.white, fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60.h),
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
          //                 builder: (context) => const LicenseBack()));
          //       },
          //       child:  Text(
          //         'הבא (רק לצורך הדגמה)',
          //         style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,color:Colors.white),
          //       )),
          // ),
          // SizedBox(height: 12.h),
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

  void _onCameraButtonPressed() async {
//     late List<CameraDescription> _cameras;
//     _cameras = await availableCameras();
//
// // בוחר מצלמה אחורית אם קיימת
//     final camera = _cameras.firstWhere(
//           (cam) => cam.lensDirection == CameraLensDirection.back,
//       orElse: () => _cameras.first,
//     );
//       // final cameras = await availableCameras(); // Get a list of available cameras
//       // final camera = cameras.first; // Use the first camera
//       _cameraController = CameraController(
//         camera,
//         ResolutionPreset.high,
//         imageFormatGroup: ImageFormatGroup.yuv420,
//       );
//       await _cameraController!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {
//           cameraOn = true;
//         });
//       });
//       // Show the camera preview on the screen
//       showCameraPreview();
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
                  child: CameraPreview(controller),
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
            onPressed: () async {
              try {
                if (controller == null) {
                  debugPrint('Camera controller is null');
                  return;
                }

                if (!controller!.value.isInitialized) {
                  debugPrint('Camera is not initialized');
                  return;
                }

                if (controller!.value.isTakingPicture) {
                  debugPrint('Camera is already taking a picture');
                  return;
                }

                final XFile xfile = await controller!.takePicture();

                debugPrint('xfile name: ${xfile.name}');
                debugPrint('xfile path: ${xfile.path}');

                await controller!.pausePreview();

                if (!mounted) return;

                setState(() {
                  _imageFront = xfile;

                  if (widget.index == 1) {
                    User().regImages[0] = _imageFront;
                  } else {
                    User().additionalDriver.images[0] = _imageFront;
                  }
                });

                if (!kIsWeb && widget.index == 1) {
                  TextRecognition(0);
                }

                if (!mounted) return;

                uploadSucceed(
                  context,
                  LicenseFront(index: widget.index, orderId: widget.orderId),
                  LicenseBack(index: widget.index, orderId: widget.orderId),
                );
              } catch (e, s) {
                debugPrint('takePicture error: $e');
                debugPrint('$s');
              }
            },
            child: Text(
              'צלם',
              style: TextStyle(
                color: Colors.white,
                fontSize: kIsWeb ? 22.sp : 18.sp,
              ),
            ),
          ),
          /*TextButton(
            onPressed: () async{
              XFile xfile=await controller!.takePicture();
              debugPrint('xfile ${xfile.name}');
              uploadSucceed(context, LicenseFront(index: widget.index,orderId: widget.orderId,), LicenseBack(index: widget.index,orderId: widget.orderId));

              setState(() {
                _imageFront= xfile;
                controller!.pausePreview();
                widget.index==1
                    ?{
                  User().regImages[0] = _imageFront,
                  if(!kIsWeb){
                    TextRecognition(0)
                  }
                }
                    :User().additionalDriver.images[0]=_imageFront;
              });

            },
            child:  Text('צלם',style: (TextStyle(color: Colors.white,fontSize: kIsWeb?22.sp:18.sp )),),
          ),*/
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
    if (cameraOn) {
      await CameraService().pauseCamera();

      cameraOn = false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery,);

    if (result != null) {
        uploadSucceed(context,const LicenseFront(index: 1,), LicenseBack(index: widget.index,orderId: widget.orderId,));
        setState(() {
          _imageFront= result;
          //_cameraController.pausePreview();
          widget.index==1?User().regImages[0]=_imageFront:User().additionalDriver.images[0]=_imageFront;
          if(!kIsWeb) {
          widget.index==1? TextRecognition(0):null;}
                });
      //User().regImages[0] = _imageFront;
    }

    //showImagePreview;
  }

  showImagePreview() {
    print(_imageFront);
    }
}
