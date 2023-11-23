
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Flow/sideMenu.dart';


class AppBarBibilease extends StatefulWidget  {
  const AppBarBibilease({Key? key}) : super(key: key);
  @override
  State<AppBarBibilease> createState() => _AppBarBibileaseState();


}

class _AppBarBibileaseState extends State<AppBarBibilease> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w,right: 24.w,),
      child: Row( children:[
         Text("Bibilease",
         style: TextStyle(
           fontSize: 24.sp,
           fontWeight: FontWeight.w700,
           color: Color(0xFF0F1511),
           fontFamily: 'PlusJakartaSans',)
          ,),
          Spacer(),
          GestureDetector(
              child: Icon(Icons.menu,color:Color(0xFF0F1511),size: 24.w,),
            onTap: () => sideMenu(context),
          ),
          SizedBox(width: 14.w,),
          GestureDetector(
              child: Icon(Icons.account_circle_outlined,color:Color(0xFF0F1511),size:28.w),
            onTap: ()=>personalArea(context),
          ),
        ],
      ),
    );
  }
}








