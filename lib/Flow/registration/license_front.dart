import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/registration/text_recognition.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:bblease/services/support.dart' as support;
import '../../landspace_widget.dart';
import 'license_back.dart';

class LicenseFront extends StatefulWidget {
  const LicenseFront({super.key, required this.index, this.orderId});
  final int index;
  final int? orderId;

  @override
  State<LicenseFront> createState() => _LicenseFrontState();
}

class _LicenseFrontState extends State<LicenseFront>  {
  late List<CameraDescription> cameras;
   CameraController? _cameraController;
  late XFile _imageFront;
  bool cameraOn = false;



  @override
  void initState() {
    super.initState();
   // WidgetsBinding.instance.addObserver(this);

  }

  @override
  void dispose() {
   // WidgetsBinding.instance.removeObserver(this);
    debugPrint('dispose 1');
    if(_cameraController!=null && _cameraController!.value.isInitialized) {
      _cameraController!.dispose();
      debugPrint('dispose camera 1');

    }
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('l_register1.png', 618.w,'תמונת הרשמה שלב 1'),showAppBar: false,);
        }
        return buildContent();
      }),
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
          SizedBox(height: 63.h),
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
                  onTap: _onCameraButtonPressed,
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
                  child: FloatingActionButton.extended(
                    label: Text('תמיכה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,color: Colors.white)),
                    elevation: 2,
                    heroTag: "btn2",
                    backgroundColor: turquoiseColorApp,
                    onPressed: ()=>support.call,
                    icon: ImageIcon(
                      const AssetImage("assets/icons/Phone.png"),
                      size: 22.w,
                      color:Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 20.w),
                SizedBox(
                  width: 183.w,
                  height: 48.h,
                  child: FloatingActionButton.extended(
                      elevation: 2,
                      label: Text('העלאת תמונה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,color: Colors.white)),
                      heroTag: "btn1",
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
    );}

  void _onCameraButtonPressed() async {
    final cameras = await availableCameras(); // Get a list of available cameras
    final camera = cameras.first; // Use the first camera
    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await _cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraOn = true;
      });
    });
    // Show the camera preview on the screen
    showCameraPreview();
  }

  void showCameraPreview() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (!_cameraController!.value.isInitialized) {
          return Center(child: CircularProgressIndicator(color: pinkColorApp,));
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 1,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 380.w,
                  //height: 380.h,
                  child: OverflowBox(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: 380.w,
                        /*child: Transform.rotate(
                          angle: -_cameraController.description.sensorOrientation * pi / 180,*/
                          child: CameraPreview(_cameraController!),
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
                     borderRadius: const BorderRadius.all(Radius.circular(70))
                 ),

                 child: TextButton(
                     onPressed: () async{
                     XFile xfile=await _cameraController!.takePicture();
                     debugPrint('xfile ${xfile.name}');
                     uploadSucceed(context, LicenseFront(index: widget.index,orderId: widget.orderId,), LicenseBack(index: widget.index,orderId: widget.orderId,));

                       setState(() {
                       _imageFront= xfile;
                       _cameraController!.pausePreview();
                       widget.index==1
                           ?{
                              User().regImages[0] = _imageFront,
                              TextRecognition(0)
                            }
                           :User().additionalDriver.images[0]=_imageFront;
                                          });

                   },
                   child: const Text('צלם',style: (TextStyle(color: Colors.white, )),),
                 ),
               ),
              )
            ],
          ),
        );
      },
    );
  }

  void _onUploadButtonPressed() async {
    if (cameraOn) {
      _cameraController!.pausePreview();
      cameraOn = false;
    }
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
        uploadSucceed(context,const LicenseFront(index: 1,), LicenseBack(index: widget.index,));
        setState(() {
          _imageFront= result;
          //_cameraController.pausePreview();
          widget.index==1?User().regImages[0]=_imageFront:User().additionalDriver.images[0]=_imageFront;
          widget.index==1?TextRecognition(0):null;
                });
      //User().regImages[0] = _imageFront;
    }

    //showImagePreview;
  }

  showImagePreview() {
    print(_imageFront);
    }
}
