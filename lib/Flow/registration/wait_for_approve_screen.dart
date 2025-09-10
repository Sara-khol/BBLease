import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/my_colors.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../my_shared_preferences.dart';

    class WAitForApproveScreen extends StatelessWidget{
  const WAitForApproveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'יש להמתין לאישור מנציג\nלהמשך התהליך.\nישלח מייל בעת העדכון.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize:35.sp,
                        fontWeight: FontWeight.bold,
                        color: pinkColorApp),
                  ),
                  SizedBox(height: 84.h),
                  Center(
                    child: SizedBox(
                      height: 48.h,
                      width: 160.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: turquoiseColorApp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: ()=> Navigator.pop(context),
                          child: Text('סגור',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                //height: 2.3
                              ))),
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Center(
                    child: SizedBox(
                      height: 48.h,
                      width: 160.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: turquoiseColorApp,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: (){
                            displayQuestion1(context,
                                header: 'להתנתק?',
                                message: 'האם ברצונך להתנתק מהאפליקציה?',
                                yesText: 'לצאת',
                                noText: 'הישאר', onYes: () {
                                  MySharedPreferences().clearAllSharedPreference();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const TelToRegistrationForm()),
                                          (route) => false);
                                });
                          },
                          child: Text('התנתק',
                              style: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                //height: 2.3
                              ))),
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }

    }