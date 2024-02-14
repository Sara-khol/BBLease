import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/UserInformation/profile.dart';
import 'package:bblease/Flow/UserInformation/use_instructions.dart';
import 'package:bblease/Flow/my_shared_preferences.dart';
import 'package:bblease/Flow/welcome.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:bblease/Flow/UserInformation/ordersHistory.dart';
import 'package:bblease/Flow/UserInformation/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:bblease/services/support.dart' as support;
import '../models/class_user.dart';
import '../utils/my_colors.dart';
import 'UserInformation/contact_us.dart';


Future sideMenu(context) {
  return SideSheet.right(
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              SizedBox(height: 18.h,),
              Align(
                alignment: Alignment.topRight,
                  child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
              //SizedBox(height: 10.h,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('האיזור האישי שלי', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),),
                  SizedBox(height: 12.h,),
                  Icon(Icons.account_circle_outlined, size: 38.sp, color: colors.blackColorApp,),
                  SizedBox(height: 6.h,),
                  User().firstName.isNotEmpty && User().lastName.isNotEmpty
                      ? Text('${User().firstName} ${User().lastName}', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),)
                      : Text('שם משתמש', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600))
                ],
              ),
              SizedBox(height: 34.h),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.account_circle_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('פרופיל אישי', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalProfile(),)),
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.drive_eta_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('היסטורית הזמנות', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersHistory(),)),
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.car_crash, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('הזמנות עתידיות', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersHistory(),)),
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.credit_card, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('פרטי כרטיס אשראי',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, height: 1, color: blackColorApp)),)
                    ],
                  ),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.ondemand_video_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('סרטוני הדרכה', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UseInstructions(),)),
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.error_outline, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('תקנון', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => Terms())),
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.account_balance_wallet_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('מחירון', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.emoji_objects_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('הטבות ומבצעים', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: () {},
              ),
              TextButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.phone_outlined, color: colors.blackColorApp,),
                      SizedBox(width: 10.w,),
                      Flexible(child: Text('צור קשר', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.blackColorApp,height: 1),))
                    ],
                  ),
                ),
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(),),),
              ),
               Spacer(),
              getBottomButtons(context),
              SizedBox(height: 30.h,),
            ],
          ),
        ),
      ),
      context: context,
      width: 250.w);
}

getBottomButtons(context) {
   return Column(mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.center,
     children: [

      SizedBox(
       height: 60.h,
       width: 200.w,
       child: Center(
         child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: colors.turquoiseColorApp,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(100),
               ),
             ),
             onPressed: () {
               displayQuestion(context,message:'?האם אתה בטוח שברצונך להתנתק',onYes: ()
               {
                 MySharedPreferences().clearAllSharedPreference();
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const WelcomeForm(
                         )),
                         (route) => false);
               });
             },
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(
                   'התנתק',
                   style: TextStyle(
                       fontSize: 18.sp,
                       fontWeight: FontWeight.w500,
                       color: Colors.white),
                 ),
                 SizedBox(width: 18.w),
                 Icon(
                   Icons.logout,
                   color: Colors.white,
                 )
               ],
             )),
       ),
     ),
     //*SizedBox(height: 12.h,),*//*
     SizedBox(
       height: 60.h,
       width: 200.w,
       child: Center(
         child: ElevatedButton(
             style: ElevatedButton.styleFrom(
               backgroundColor: Color(0xFFFF0000),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(80),
               ),
             ),
             onPressed: () {
               support.call;
             },
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 Text(
                   'חיוג במקרה חירום ',
                   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white),
                 ),
                 //SizedBox(width: 18.w),
                 Icon(
                   Icons.phone_outlined,
                   color: Colors.white,
                   size: 18.sp,
                 )
               ],
             )),
       ),
     ),




   ],);
}
