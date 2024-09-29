import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';

class SucssesRegistrationForm extends StatefulWidget {
  const SucssesRegistrationForm({super.key});

  @override
  State<StatefulWidget> createState() => _SucssesRegistrationForm();
}

class _SucssesRegistrationForm extends State<SucssesRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('image6.png', 1000.w,'עבר בהצלחה'));
        }
        return buildContent();
      }),
    );
  }

  buildContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 160.h),
              Image.asset('assets/images/aaa.png',semanticLabel: 'תמונה רישום עבר בהצלחה',),
              SizedBox(height: 38.h),
              Text("היי ${User().firstName}!",
                  style: TextStyle(
                      fontSize: 28.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Text("הרשמתך בוצעה בהצלחה",
                  style: TextStyle(
                      fontSize: 28.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Text("כעת ניתן להזמין רכב על שמך!",
                  style: TextStyle(
                      fontSize: 24.sp,
                      height: 1,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  const RentalWidget()));
                          },
                          child: Text('לעבור לביצוע הזמנה',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal))),
                    ),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  const TelToRegistrationForm()));
                          },

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.exit_to_app_outlined,
                                fill: 0,
                                color: Colors.white,
                              ),
                              Text('   צא מהאפליקציה',
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
}
