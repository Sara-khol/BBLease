
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Flow/sideMenu.dart';


class AppBarBibilease extends StatefulWidget implements PreferredSizeWidget   {
  const AppBarBibilease({Key? key}) : super(key: key);
  @override
  State<AppBarBibilease> createState() => _AppBarBibileaseState();

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

class _AppBarBibileaseState extends State<AppBarBibilease> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 24.w,right: 24.w,top:32.h,bottom: 20.h),
        child: Row( children:[
           Text("Bibilease",
           style: TextStyle(
             fontSize: 24.sp,
             fontWeight: FontWeight.w700,
             color: Color(0xFF0F1511),
             fontFamily: 'PlusJakartaSans',)
            ,),
            Spacer(),
            IconButton(
              icon: Icon(Icons.menu,color:Color(0xFF0F1511),size: 24.w,),

              onPressed: () => sideMenu(context),
            ),
          ],
        ),
      ),
    );
  }


}








