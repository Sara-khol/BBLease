import 'package:bblease/Flow/registration/license_front.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/utils/my_colors.dart' as colors;



class StartRegistration extends StatefulWidget {
  const StartRegistration({Key? key}) : super(key: key);

  @override
  State<StartRegistration> createState() => _StartRegistrationState();
}

class _StartRegistrationState extends State<StartRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(height: 56.h),
            Text("ברוכים הבאים לביביליס",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 28.sp,),),
            SizedBox(height: 120.h),
            Image.asset('assets/icons/teenyicons_id.png',width: 159.w, fit: BoxFit.cover,),
            SizedBox(height: 130.h),
            Text("לתהליך הרישום, עליך להכין\nרשיון וכרטיס אשראי\nעל שמך בלבד!",
              style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 22.sp,)
               ,textDirection: TextDirection.rtl,textAlign: TextAlign.center),

            SizedBox(height: 50.h),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: colors.turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LicenseFront()));
                  },
                  child:  Text('אני מוכן!',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),textDirection: TextDirection.rtl)),
            ),
          ],
        ),
      ),

    );
  }
}
