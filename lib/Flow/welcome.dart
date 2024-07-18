import 'package:bblease/utils/my_colors.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeForm extends StatelessWidget {
  const WelcomeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    debugPrint('orientation ${orientation.name} ');
    return Scaffold(
      body: Center(
        child: Column(
          // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 56.h),
            Text(
              "Welcome to Bibilease",
              style: TextStyle(
                color: pinkColorApp,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
              ),
            ),
            SizedBox(height: 36.h),
            // OrientationBuilder(
            //   builder: (BuildContext context, Orientation orientation) {
            //     return orientation == Orientation.portrait
            //         ? Expanded(
            //             child: Image.asset('assets/images/BB.png',
            //                 width: 392.w, fit: BoxFit.contain))
            //         : Expanded(
            //             child: Image.asset('assets/images/BB.png',
            //                 width: 500.w,height: 200.h, fit: BoxFit.contain));
            //   },
            //   // child: Expanded(child: Image.asset('assets/images/BB.png',width: 392.w, fit: BoxFit.contain))
            // ),
            Expanded(
                child: Image.asset('assets/images/BB.png', width: 400.w, fit: BoxFit.contain)),
            SizedBox(height: 48.h),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: () {
                    /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrdersHistory()));*/
                    //departurePoint(context);
                  },
                  child: Text(
                    'צפו בסרטון ההדרכה שלנו',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        //height: 2.3
                    ),
                  )),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 48.h,
              width: 332.w,
              margin: EdgeInsets.only(bottom: 35.h),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: pinkColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                    const TelToRegistrationForm()));
                  },
                  child: Center(
                    child: Text(
                      'הבא',
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
