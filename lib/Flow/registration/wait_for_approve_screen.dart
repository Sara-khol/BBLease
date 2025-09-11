import 'dart:io';

import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/api_service.dart';
import '../../utils/my_colors.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../my_shared_preferences.dart';
import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import 'package:flutter/foundation.dart';


class WAitForApproveScreen extends StatefulWidget {
  const WAitForApproveScreen({super.key});


  @override
  State<WAitForApproveScreen> createState() => _WAitForApproveScreenState();
}

class _WAitForApproveScreenState extends State<WAitForApproveScreen> {

  late bool _isMounted;

  @override
  void initState() {
    _isMounted = true;
    getStatus();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(context),
              imageProperties: ImageProperties(
                  'image6.png', 1000.w, 'עבר בהצלחה'));
        }
        return buildContent(context);
      }),
    );
  }

  buildContent(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 160.h),
              Image.asset('assets/images/aaa.png',
                semanticLabel: 'תמונה רישום עבר בהצלחה',),
              SizedBox(height: 38.h),
              Text("היי ${User().firstName}!",
                  style: TextStyle(
                      fontSize: 28.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Text("הרשמתך בוצעה בהצלחה",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Text(
                  'יש להמתין לאישור מנציג\nלהמשך התהליך.\nישלח מייל בעת העדכון.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (defaultTargetPlatform == TargetPlatform.android)
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
                            onPressed: () {
                              SystemNavigator.pop(); // Only works on Android.
                            },
                            child: Text('סגור',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal))),
                      ),
                    if (defaultTargetPlatform == TargetPlatform.android)
                      SizedBox(height: 12.h),
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
                          onPressed: () {
                            displayQuestion1(context,
                                header: 'להתנתק?',
                                message: 'האם ברצונך להתנתק מהאפליקציה?',
                                yesText: 'לצאת',
                                noText: 'הישאר',
                                onYes: () {
                                  MySharedPreferences()
                                      .clearAllSharedPreference();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const TelToRegistrationForm()),
                                          (route) => false);
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.exit_to_app_outlined,
                                fill: 0,
                                color: Colors.white,
                              ),
                              Text('התנתק',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal)),
                            ],
                          )
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getStatus() async {
    await Future.delayed(const Duration(minutes: 5));
    await ApiService().getUserById(User().userId, (res)
    async {
      User.fromJson(res['customer']);
      if (User().customerStatus== 'active_customer') {
        debugPrint('active_customer');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const RentalWidget()),
                (route) => false);
      }
      else{
          if (_isMounted) {
            getStatus();
          }
      }
    });
  }
}


