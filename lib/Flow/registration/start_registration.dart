import 'package:bblease/Flow/registration/license_front.dart';
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
            // SizedBox(height: 56.h),
            Text("ברוכים הבאים לביביליס",style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 28.sp,),),
            SizedBox(height: 120.h),
            Image.asset('assets/icons/teenyicons_id.png',width: 159.w, fit: BoxFit.cover,),
            SizedBox(height: 130.h),
            Text("לתהליך הרישום, עליך להכין\nרשיון וכרטיס אשראי\nעל שמך בלבד!",
              style: TextStyle(color:Colors.black,fontWeight: FontWeight.w600,fontSize: 28.sp,)
               ,textDirection: TextDirection.rtl),

            SizedBox(height: 12.h),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(251, 37, 118, 1),
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
                  child:  Text('ביצוע הזמנה למשתמש קיים',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
          ],
        ),
      ),

    );
  }
}
