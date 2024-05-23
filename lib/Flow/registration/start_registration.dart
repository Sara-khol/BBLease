import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
            SizedBox(height: 120.h),
            Text("תהליך הרשמה",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 23.sp,),),
            SizedBox(height: 32.h),
            Text("לתהליך הרישום, עליך להכין\nרשיון וכרטיס אשראי\nעל שמך בלבד!",
                style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.sp,)
                ,textDirection: TextDirection.rtl,textAlign: TextAlign.center),
            SizedBox(height: 28.h),
            Image.asset('assets/images/image1.png',width: 300.w, fit: BoxFit.cover,),
            Spacer(),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LicenseFront(index: 1,)));
                  },
                  child:  Text('אני מוכן!',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,
                  color: Colors.white),textDirection: TextDirection.rtl)),
            ),
            SizedBox(height: 40.h,)
          ],
        ),
      ),
    );
  }
}
