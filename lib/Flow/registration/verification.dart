import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/class_user.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: 120.h,),
              Text('התצלום עלה בהצלחה',style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w600,fontFamily: 'PLONI'),),
              SizedBox(height: 50.h,),
              Text('המערכת בסריקה',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600,fontFamily: 'PLONI'),),
              SizedBox(height: 30.h,),
              Text('תהליך זה עלול להימשך כמה דקות אנא התאזר בסבלנות תודה',style: TextStyle(fontSize: 18.sp,fontFamily: 'PLONI')),
              SizedBox(height: 30.h,),
            Image(image: XFileImage(User().regImages[2]!)),

            ],
          ),
        ),
      ),
    );
  }
}
