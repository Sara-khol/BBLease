import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/registration/face_detector.dart';
import 'package:bblease/Flow/registration/face_scanning.dart';
import 'package:bblease/Flow/registration/personal_details_form.dart';
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
        child: Directionality(
          textDirection: TextDirection.rtl,
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
                          MaterialPageRoute(builder: (context) => const TelToRegistrationForm(isRegister: false,)));
                      //departurePoint(context);

                    },
                    child: Text('כניסה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color: Colors.white),)),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 45.w,),
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

                          MaterialPageRoute(builder: (context) =>  StartRegistration()));

                          // MaterialPageRoute(builder: (context) =>  FaceScanning()));
                          MaterialPageRoute(builder: (context) => const TelToRegistrationForm(isRegister: true));

                    },
                    child:  Text('זיהוי פנים',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color: Colors.white),)),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
