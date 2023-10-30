
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


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
          Icon(Icons.menu,color:Color(0xFF0F1511),size: 24.w,),
          SizedBox(width: 14.w,),
          ImageIcon(AssetImage("assets/images/Profil.png"),color:Color(0xFF0F1511),size:28.w),
        ],
      ),
    );
  }
}








