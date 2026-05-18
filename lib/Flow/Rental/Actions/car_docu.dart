import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../landspace_widget.dart';
import '../../../services/camera_service.dart';
import '../../../utils/common_funcs.dart';
import '../../Dialogs/buttom_dialogs.dart';

class CarDocu extends StatefulWidget {
  const CarDocu({super.key, required this.rentNum});

  final int rentNum;

  @override
  State<CarDocu> createState() => _CarDocuState();
}

class _CarDocuState extends State<CarDocu> {
  late List<XFile?> images;
  bool allLoaded = false;
  CameraController? _cameraController;
  late Orientation realOrientation;

  final List<String> requiredLabels = [
    'צד קדמי',
    'צד ימין',
    'צד אחורי',
    'צד שמאל',
  ];



  @override
  void initState() {
    // TODO: implement initState
    images = List<XFile?>.generate(4, (index) => null);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    realOrientation = View.of(context).physicalSize.width >
            View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
        body: LandSpaceWidget(
            mainWidget: buildContent(realOrientation),
            imageProperties:
                ImageProperties('image5.png', 1000.w, 'תמונת פעולות')));
  }

  buildContent(Orientation o) {
    return SingleChildScrollView(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, /*left: 30.w,right: 30.w*/
              ),
              child: Column(children: [
                if (o == Orientation.portrait)
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: CommonFuncs().getBackButton(context),
                  ),
               /* SizedBox(
                  height: 30.h,
                ),*/
                Text(
                  'תיעוד רכב',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  '\nמומלץ תמיד לתעד את הרכב\nבתחילת הנסיעה!!\n',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                  ),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'אם ישנם נזקים , נדע לא לחייב אתכם עליהם',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  ' \nנסיעה בטוחה :)',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Image.asset("assets/icons/heart.png"),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'צלמו תמונה חדה וברורה!',
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 25.h,
                ),
                GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      itemCount: images.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 1.05,
                      ),
                      itemBuilder: (context, index) {
                        if (index == images.length) {
                          return InkWell(
                            onTap: addExtraImage,
                            child: Container(
                              child: Center(
                                child: Text('+ תמונה נוספת'),
                              ),
                            ),
                          );
                        }

                        final label = getImageLabel(index);

                        return InkWell(
                          onTap: () => images[index] == null
                              ? showImageDialog(index)
                              : editImage(label, index),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFFF7F7F7),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                images[index] == null
                                    ? Icon(Icons.camera_alt_outlined, size: 24.sp)
                                    : Image.asset("assets/icons/done.png"),
                                SizedBox(height: 10.h),
                                Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                SizedBox(
                  height: 35.h,
                ),
                Container(
                  height: 48.h,
                  width: 332.w,
                  margin: EdgeInsets.only(
                    bottom: 35.h,
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allLoaded
                            ? turquoiseColorApp
                            : const Color(0xFFD9D9D9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 0.0,
                      ),
                      onPressed: () {
                        if (!requiredImagesLoaded) {
                          missingImage();
                          return;
                        }

                        sendImages();
                        // int i;
                        // for (i = 0; i < images.length; i++) {
                        //   if (images[i] == null) {
                        //     break;
                        //   }
                        // }
                        // if (i == 4) {
                        //   setState(() {
                        //     allLoaded = true;
                        //   });
                        //   sendImages();
                        // }
                        // if (!allLoaded) missingImage();
                      },
                      child: Text(
                        'שלח תמונות',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      )),
                ),
                SizedBox(
                  height: 20.h,
                )
              ]))),
    );
  }

  void addExtraImage() {
    showImageDialog(images.length, isNewExtra: true);
  }

  bool get requiredImagesLoaded {
    return images.take(4).every((image) => image != null);
  }

  showImageDialog(int index, {bool isNewExtra = false}) {
    showBottomDialog(Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoiseColorApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0.0,
              ),
              onPressed: () {
                Navigator.pop(context);
                pickImage(index, isNewExtra: isNewExtra);
              },
              child: Text(
                'לפתיחת מצלמה',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              )),
          SizedBox(
            height: 15.h,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoiseColorApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0.0,
              ),
              onPressed: () {
                Navigator.pop(context);
                openGallery(index, isNewExtra: isNewExtra);
              },
              child: Text(
                'לפתיחת גלריה',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  //height: 2.3
                ),
              )),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    ));
  }

  Future openGallery(int index, {bool isNewExtra = false}) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      if (isNewExtra) {
        images.add(image);
      } else {
        images[index] = image;
      }

      allLoaded = images.take(4).every((img) => img != null);
    });
  }

  void pickImage(int index, {bool isNewExtra = false}) async {
    if (!await CameraService.ensureGrantedWithUi(context)) return;
    if (!mounted) return;

    try {
      await CameraService().init(useFront: false);
    } catch (e) {
      debugPrint('❌ Camera init failed: $e');
      if (!mounted) return;
      CommonFuncs().showMyToast('שגיאה בפתיחת המצלמה');
      return;
    }
    _cameraController = CameraService().controller;

    if (!mounted || _cameraController == null) return;

    showCameraPreview(index, isNewExtra: isNewExtra);
  }

  void showCameraPreview(int index, {bool isNewExtra = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (!_cameraController!.value.isInitialized) {
          return Center(
              child: CircularProgressIndicator(
                color: pinkColorApp,
              ));
        }
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: 380.w,
                  //height: 380.h,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 380.w,
                      /*child: Transform.rotate(
                        angle: -_cameraController.description.sensorOrientation * pi / 180,*/
                      child: CameraPreview(
                        _cameraController!,
                        key: ValueKey(DateTime.now().millisecondsSinceEpoch),
                      ),
                      //),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h,),
              Container(
                height: 40.h,
                width: 80.w,
                decoration: BoxDecoration(
                    color: turquoiseColorApp,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(70))),
                child: TextButton(
                  onPressed: () async {
                    final image = await _cameraController!.takePicture();
                    debugPrint('imageeeeeee ${image.name}');
                    Navigator.pop(context);
                    setState(() {
                      if (isNewExtra) {
                        images.add(image);
                      } else {
                        images[index] = image;
                      }

                      allLoaded = images.take(4).every((img) => img != null);
                    });

                    CameraService().pauseCamera();
                  },
                  child: Text(
                    'צלם',
                    style: (TextStyle(color: Colors.white, fontSize: 16.sp)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  String getImageLabel(int index) {
    if (index < 4) return requiredLabels[index];
    return 'תמונה נוספת ${index - 3}';
  }

  Future missingImage() {
    Widget widget = Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            'חסרות תמונות',
            style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                color: pinkColorApp),
          ),
          SizedBox(height: 40.h),
          Text(
            'כדי לבצע שליחה עליך לצלם\nתמונות ל-4 הכיוונים ',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
            ),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 27.h),
          SizedBox(
            height: 48.h,
            width: 332.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('חזור לצלם',
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ))),
          ),
          SizedBox(height: 22.h),
        ]),
      ),
    );
    return showBottomDialog(widget);
  }

  Future editImage(String side, int index) {
    Widget widget = Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'עריכת תמונה',
          style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: pinkColorApp),
        ),
        SizedBox(height: 40.h),
        Text(
          'מה ברצונך לעשות עם תמונה\n "$side"',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.normal,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 27.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                // width: 160.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showImageDialog(index);
                    },
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(/*'צלם שוב'*/ 'תמונה חדשה',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    )),
              ),
            ),
            SizedBox(
              width: 13.w,
            ),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        images[index] = null;
                        allLoaded = false;
                      });
                      Navigator.pop(context);
                      deleteImage(index);
                    },
                    child: Text('מחק',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h),
      ]),
    );
    return showBottomDialog(widget);
  }

  Future deleteImage(int index) {
    Widget widget = Padding(
      padding: EdgeInsets.only(
        left: 30.w,
        right: 30.w,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'התמונה נמחקה',
          style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: pinkColorApp),
        ),
        SizedBox(height: 40.h),
        Text(
          'צלמו תמונה חדשה וברורה',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 52.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 48.h,
                // width: 160.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      showImageDialog(index);
                    },
                    child: Text('צלם שוב',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ))),
              ),
            ),
            SizedBox(
              width: 13.w,
            ),
            Expanded(
              child: SizedBox(
                height: 48.h,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('הבנתי',
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ),
        SizedBox(height: 22.h),
      ]),
    );
    return showBottomDialog(widget);
  }

  Future showBottomDialog(Widget content) {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: Colors.black12.withOpacity(0.1),
        backgroundColor: Colors.white,
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) {
          return SafeArea(
            top: false,
            maintainBottomViewPadding: true,
            minimum: EdgeInsets.only(bottom: 20.h),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 20.w, top: 18.h),
                      // height: 28.h,
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    content
                  ],
                )),
          );
        });
  }

  sendImages() {
    showLoading(context);
    debugPrint('lll ${images.length}');
    ApiService().carDocumentation(
      widget.rentNum,
      images,
          (res) {
        Navigator.pop(context);
        displayMessage(context, message: 'ההודעה התקבלה בהצלחה', onClose: () {
          // Navigator.pop(context);
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  void dispose() {
    CameraService().dispose();
    super.dispose();
  }
}
