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
       body: Column(
         children: [
           Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
           SizedBox(height: 40.h,),
           Text('פרופיל אישי', style: TextStyle(color: Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.w600,),),
           SizedBox(height: 58.h,),
           SizedBox(
             width: 300.w,
             child: Column(
               children: [
                 Row(
                   children:[
                     Icon(Icons.account_circle_outlined,color: pinkColorApp,size: 26.sp,),
                     Text('  פרטים אישיים',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),

                     Spacer(),
                     //IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: pinkColorApp,))
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
               children: [
                 Row(
                     children:[
                       Icon(Icons.phone_outlined,color: pinkColorApp,size: 26.sp,),
                       Text('  פרטי התקשרות',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                       Spacer(),
                       IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: pinkColorApp,))
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
               children: [
                 Row(
                     children:[
                       Icon(Icons.quick_contacts_mail_outlined,color: pinkColorApp,size: 26.sp,),
                       Text('  רשיון נהיגה',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                       Spacer(),
                       IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: pinkColorApp,))
                     ]
                 ),
                 Text(User().licenseId,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                 Text(User().licenseExpDate,style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
               ],
             ),
           ),
           SizedBox(height: 38.h,),
           SizedBox(
             width: 300.w,
             child: Column(
               children: [
                 Row(
                     children:[
                       Icon(Icons.credit_card,color: pinkColorApp,size: 26.sp,),
                       Text('  אמצעי תשלום',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                       Spacer(),
                       IconButton(onPressed: () {}, icon: Icon(Icons.edit,color: pinkColorApp,))
                     ]
                 ),
                 Text('**** **** **** 1234',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                 Text('**/**',style: TextStyle(color: blackColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
               ],
             ),
           )
         ],
       ),
    );
  }
}
