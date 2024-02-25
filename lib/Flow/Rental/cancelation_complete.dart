
import 'package:bblease/Flow/sideMenu.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:signature/signature.dart';

import '../../models/class_rent.dart';
import '../../utils/my_colors.dart';

class CancelationComplete extends StatelessWidget {
  const CancelationComplete({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarBibilease(),
          SizedBox(height: 40.h,),
          Text('ההזמנה בוטלה',style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
          SizedBox(height: 33.h,),
          Text('מידע נוסף מחכה לך באזור האישי',
            style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
          SizedBox(height: 60.h,),
          Image.asset('assets/images/image1.png',width: 300.w,),
          SizedBox(height: 70.h,),
          Text('מקווים לראותך שוב בקרוב!',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,textDirection: TextDirection.rtl,),
          SizedBox(height: 138.h,),
          Container(
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
                  sideMenu(context);
                },
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('לאזור האישי',
                          style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500)
                      ),
                      SizedBox(width: 166.h,),
                      Icon(Icons.account_circle_outlined,color: Colors.white,)

                    ],
                  ),
                )
            ),
          ),
          SizedBox(height: 12.h,),
          Container(
            height: 48.h,
            width: 332.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {    },
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('צא מהאפליקציה',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)
                      ),
                      SizedBox(width: 136.h,),
                      Icon(Icons.logout,color: Colors.white),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
