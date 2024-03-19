import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({Key? key}) : super(key: key);

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
         child: Directionality(
           textDirection: TextDirection.rtl,
           child: Column(
             children: [
               Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
               SizedBox(height: 5.h,),
               Icon(
                 Icons.account_circle_outlined,
                 color: turquoiseColorApp,
                 size: 60.w,
                 weight: 100,
               ),
               SizedBox(height: 8.h,),
               Text('פרופיל אישי', style: TextStyle(color: Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.w600,),),
               SizedBox(height: 40.h,),
               SizedBox(
                 width: 300.w,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children:[
                         Icon(Icons.account_circle_outlined,color: pinkColorApp,size: 26.sp,),
                         Text('  פרטים אישיים',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                         Spacer(),
                         IconButton(onPressed: () {},icon:  Image.asset('assets/icons/edit.png',color: pinkColorApp,width: 26.w), )
                 ]
                     ),
                     Text('${User().firstName} ${User().lastName}',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                     Text(User().tz,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                   ],
                 ),
               ),
               SizedBox(height: 38.h,),
               SizedBox(
                 width: 300.w,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                         children:[
                           Image.asset('assets/icons/Phone.png',width: 26.w,),
                           Text('  פרטי התקשרות',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                           Spacer(),
                           IconButton(onPressed: () {},icon:  Image.asset('assets/icons/edit.png',color: pinkColorApp,width: 26.w), )
                         ]
                     ),
                     Text(User().phoneNumber,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                     Text(User().email,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                   ],
                 ),
               ),
               SizedBox(height: 38.h,),
               SizedBox(
                 width: 300.w,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                         children:[
                           Image.asset('assets/icons/driver_license.png',width: 26.w,),
                           Text('  רשיון נהיגה',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                           Spacer(),
                           IconButton(onPressed: () {},icon:  Image.asset('assets/icons/edit.png',color: pinkColorApp,width: 26.w,), )
                         ]
                     ),
                     Text(User().licenseId,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,),),
                     Text(User().licenseExpDate,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                   ],
                 ),
               ),
               SizedBox(height: 38.h,),
               SizedBox(
                 width: 300.w,
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                         children:[
                           Image.asset('assets/icons/f7_creditcard.png',width: 26.w,),
                           Text('  אמצעי תשלום',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,),),
                           Spacer(),
                           IconButton(onPressed: () {},icon:  Image.asset('assets/icons/edit.png',color: pinkColorApp,width: 26.w,), )
                         ]
                     ),
                     Text('**** **** **** 1234',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                     Text('**/**',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                   ],
                 ),
               ),
               SizedBox(height: 74.h,),
               SizedBox(
                 width: 332.w,
                 height: 42.h,
                 child: FloatingActionButton.extended(
                     label: Text('מחיקת חשבון',style: TextStyle(
                         fontSize: 18.sp,
                         fontWeight: FontWeight.w500,
                         color: Colors.white)),

                     //elevation: 2,
                     backgroundColor: turquoiseColorApp,
                     onPressed: (){},
                     icon:  Icon(Icons.arrow_back_ios_sharp,size: 22.sp,color: Colors.white,)
                 ),
               ),
               SizedBox(height: 40.h,),
             ],
           ),
         ),
       ),
    );
  }
}
