import 'package:bblease/Flow/registration/start_registration.dart';
import 'package:bblease/Flow/registration/tel_to_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {


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
            SizedBox(height: 48.h),
            SizedBox(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelToRegistrationForm()));
                    //departurePoint(context);

                  },
                  child: Text('התחברות',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('עדיין אין לכם חשבון אצלינו?',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400)),
              ],
            ),
            Container(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StartRegistration()));
                  },
                  child:  Text('הרשמה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
            ),
          ],
        ),
      ),

    );
  }
}
