import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/home_page.dart';
import 'package:bblease/models/class_rent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/class_user.dart';
import '../welcome.dart';
import 'package:bblease/utils/my_colors.dart' as colors;

class SucssesRegistrationForm extends StatefulWidget {
  const SucssesRegistrationForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SucssesRegistrationForm();
}

class _SucssesRegistrationForm extends State<SucssesRegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 160.h),
                Image.asset('assets/images/aaa.png'),
                SizedBox(height: 38.h),
                Text("היי ${User().firstName}!",
                    style: TextStyle(
                        fontSize: 28.sp,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: colors.blackColorApp)),
                Text("הרשמתך בוצעה בהצלחה",
                    style: TextStyle(
                        fontSize: 28.sp,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: colors.blackColorApp)),
                Text("כעת ניתן להזמין רכב על שמך!",
                    style: TextStyle(
                        fontSize: 24.sp,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: colors.blackColorApp)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 48.h,
                        width: 332.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.turquoiseColorApp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  HomePage()));
                            },
                            child: Text('לעבור לביצוע הזמנה',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500))),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: 332.w,
                        height: 48.h,
                        child: FloatingActionButton.extended(
                          label: Text(
                            'צא מהאפליקציה',
                            style: TextStyle(
                              color: Colors.white,
                                letterSpacing: 0.1,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          heroTag: "btn2",
                          elevation: 2,
                          backgroundColor: colors.turquoiseColorApp,
                          icon: const Icon(
                            Icons.exit_to_app_outlined,
                            fill: 0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomeForm()));
                          },
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
      ),
    );
  }
}
