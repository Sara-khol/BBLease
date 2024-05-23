import 'package:bblease/Flow/UserInformation/editContactInformation.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../Dialogs/buttom_dialogs.dart';
import '../home_page.dart';
import 'editDrivingLicense.dart';
import 'editProfile.dart';

class BenefitsAndPromotions extends StatefulWidget {
  const BenefitsAndPromotions({Key? key}) : super(key: key);

  @override
  State<BenefitsAndPromotions> createState() => _BenefitsAndPromotionsState();


}

class _BenefitsAndPromotionsState extends State<BenefitsAndPromotions> {
  @override
  Widget build(BuildContext context,) {


    return Scaffold(
       body: Directionality(
         textDirection: ui.TextDirection.rtl,
         child: Column(
           //mainAxisSize: MainAxisSize.max,
           children: [
             SizedBox(height: 24.h,),
             Padding(
               padding:  EdgeInsets.only(right: 23.w),
               child: Align(
                   alignment: Alignment.topRight,
                   child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
             ),
             SizedBox(height: 42.h,),
             Expanded(
               child: Column(
                // mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text('הטבות ומבצעים', style: TextStyle(color: Color(0xFF0F1511), fontSize: 22.sp, fontWeight: FontWeight.bold,),),
               
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Image.asset("assets/images/date_bad.png"),
                       SizedBox(height: 12.h,),
                       Text('אופס...\nכרגע אין הטבות\nומבצעים פעילים',style: TextStyle(color: Color(0xFFAAABAA), fontSize: 20.sp, fontWeight: FontWeight.normal,),),
                     ],
                   ),
                    Text('השארו מעודכנים וגלו מה חדש',style: TextStyle(color: Color(0xFF0F1511), fontSize: 18.sp, fontWeight: FontWeight.normal,),),
                 ],
               ),
             ),
           ],
         ),
       ),
    );
  }
}
