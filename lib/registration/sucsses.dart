import 'package:bblease/class_user.dart';
import 'package:bblease/registration/face_scanning.dart';
import 'package:bblease/registration/license_back.dart';
import 'package:bblease/registration/license_front.dart';
import 'package:bblease/registration/registration_main.dart';
import 'package:bblease/registration/text_recognition.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Success extends StatefulWidget {
  const Success({super.key,required this.index});

  final int index;

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //SizedBox(height: 200.h),
          Container(
            height: 402.h,
            width: 255.w,
            decoration: BoxDecoration(
              color: Color(0xFFF5F6FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 216.h,
                    child: Image(image: XFileImage(User().regImages[widget.index]!))),
                Text('התצלום עבר בהצלחה!',style: TextStyle(fontSize: 24.sp,color: Colors.blueAccent),textDirection: TextDirection.rtl,)
              ],
            ),
          ),
          SizedBox(height: 40.h),
          Container(
            height: 56.h,
            width: 332.w,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8)
            ),
            child: TextButton(
                child: Text('סרוק פעם נוספת', style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w700),),
                onPressed: () {
                  Navigator.pop(context,MaterialPageRoute(builder: (context) => widget.index==0?LicenseFront():LicenseBack()),);
                },
            ),
          ),
          SizedBox(height: 22.h),
          Container(
            height: 56.h,
            width: 332.w,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8)
            ),
            child: TextButton(
                child: Text('אישור', style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w700),),
                onPressed: () {
                  widget.index==0?
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LicenseBack()),
                ):
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TextRecognition()),
                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
