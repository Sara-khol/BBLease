
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Flow/sideMenu.dart';


class AppBarBibilease extends StatefulWidget implements PreferredSizeWidget   {
  const AppBarBibilease({super.key});
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
        padding: EdgeInsets.only(right: 24.w),
        child: Row( children:[
          Image.asset('assets/images/logo_bibilease_new_no_background.png', height: 100.w, semanticLabel: 'לוגו ביביליס',),
           /*Text("Bibilease",
           style: TextStyle(
             fontSize: 24.sp,
             fontWeight: FontWeight.bold,
             color: Color(0xFF0F1511),
             fontFamily: 'PlusJakartaSans',)
            ,),*/
            const Spacer(),
            SizedBox(
              height: 70,
              width: 40,
              child: Center(
                child: IconButton(
                  constraints: const BoxConstraints(
                    minHeight: 30,
                  ),
                  icon:  Icon(Icons.menu,color:const Color(0xFF0F1511),size: 24.w,),
                  onPressed: () => sideMenu(context),
                  ),
              ),
            ),

          ],
        ),
      ),
    );
  }


}








