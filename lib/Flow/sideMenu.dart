import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/Flow/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bblease/services/support.dart' as support;
import '../models/class_user.dart';

Future sideMenu( context){
  return SideSheet.right(
    body: Padding(
      padding: EdgeInsets.only(left: 22.w,right: 20.w),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 22.h,),
            IconButton(
                onPressed: ()=>Navigator.pop(context),
                icon: Icon(Icons.close)
            ),
            SizedBox(height: 20.h,),
            TextButton(
                child: Padding(
                  padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Icon(Icons.account_circle_outlined,color: colors.blackColorApp,),
                     SizedBox(width: 10.w,),
                     Text('אזור אישי', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                    ],
                  ),
                ),
              onPressed: () {
                  Navigator.pop(context);
                  personalArea(context);
              },
            ),
            TextButton(
              child: Padding(
                padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(Icons.check_circle_outlined,color: colors.blackColorApp,),
                    SizedBox(width: 10.w,),
                    Text('הטבות ומבצעים', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                  ],
                ),
              ),
              onPressed: () {

              },
            ),
            TextButton(
              child: Padding(
                padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(Icons.account_balance_wallet_outlined,color: colors.blackColorApp,),
                    SizedBox(width: 10.w,),
                    Text('טבלת מחירים', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                  ],
                ),
              ),
              onPressed: () {

              },
            ),
            TextButton(
              child: Padding(
                padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(Icons.error_outline,color: colors.blackColorApp,),
                    SizedBox(width: 10.w,),
                    Text('תקנון החברה', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  Terms()));
              },
            ),
            TextButton(
              child: Padding(
                padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Icon(Icons.chair_outlined,color: colors.blackColorApp,),
                    SizedBox(width: 10.w,),
                    Text('הצטרף לצוות שלנו', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                  ],
                ),
              ),
              onPressed: () {

              },
            ),
            TextButton(
              child: Padding(
                padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.ondemand_video_outlined,color: colors.blackColorApp,),
                    SizedBox(width: 10.w),
                    Text('סרטון הדרכה\nלשימוש באפליקציה', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                  ],
                ),
              ),
              onPressed: () {

              },
            ),
            const Spacer(),
            SizedBox(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: colors.turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: (){
                    support.call;
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text('תמיכה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color: Colors.white),),
                        SizedBox(width: 35.w),
                        Icon(Icons.phone_outlined,color: Colors.white,)
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 30.h,),
          ],
        ),
      ),
    ),
    context: context,
    width: 255.w
  );
}

Future personalArea( context){
  return SideSheet.right(
    body: Padding(
        padding: EdgeInsets.only(left: 20.w,right: 20.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 22.h,),
              IconButton(
                  onPressed: ()=>Navigator.pop(context),
                  icon: Icon(Icons.close)
              ),
              SizedBox(height: 32.h,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('אזור אישי', style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.w700),),
                  SizedBox(height: 12.h,),
                  Icon(Icons.account_circle_outlined,size: 34.sp,color: colors.blackColorApp,),
                  SizedBox(height: 6.h,),
                  User().firstName.isNotEmpty&&User().lastName.isNotEmpty?
                  Text('${User().firstName} ${User().lastName}',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),)
                      :Text('שם משתמש',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(height: 45.h),
              TextButton(
                child: Padding(
                  padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle_outlined,color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Text('פרופיל אישי', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                    ],
                  ),
                ),
                onPressed: () {

                },
              ),
              TextButton(
                child: Padding(
                  padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.credit_card,color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Text('פרטי כרטיס אשראי', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                    ],
                  ),
                ),
                onPressed: () {

                },
              ),
              TextButton(
                child: Padding(
                  padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Icon(Icons.drive_eta_outlined,color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Text('פרטי רשיון נהיגה', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                    ],
                  ),
                ),
                onPressed: () {

                },
              ),
              TextButton(
                child: Padding(
                  padding:  EdgeInsets.only(top: 11.h,bottom: 11.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [
                      Icon(Icons.folder_outlined,color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Text('ההזמנות שלי', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600,color: colors.blackColorApp),)
                    ],
                  ),
                ),
                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersHistory(),)),
              ),
              const Spacer(),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colors.turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: (){
                        support.call;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('תמיכה',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color: Colors.white),),
                          SizedBox(width: 35.w),
                          Icon(Icons.phone_outlined,color: Colors.white,)
                        ],
                      )),
                ),
              ),
              SizedBox(height: 30.h,),
            ],

          ),
        ),
      ),
    context: context,
    width: 250.w
  );
}