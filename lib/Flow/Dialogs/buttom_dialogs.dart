import 'package:bblease/Flow/registration/license_front.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future errorNoMatch(BuildContext context, Widget page){
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context)=>
          Container(
            height: 230.h,
            child: Column(
              children: [
                SizedBox(height: 40.h,),
                Text('אופס, שימו לב', style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w600,color: Color(0xFFFB2576)),),
                SizedBox(height: 25.h,),
                Text('התמונה שעלתה באיכות גרועה לא נוכל לבצע אימות', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black,),),
                SizedBox(height: 30.h,),
                Container(
                  width: 332.w,
                  height: 42.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color(0xFF00DEDE),
                  ),
                  child: TextButton(
                    child: Text('נסה שנית',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                    onPressed: () {
                       Navigator.push(
                           context,
                          MaterialPageRoute(builder: (context) => page));
                    },
                  ),
                ),
                SizedBox(height: 22.h,),
              ],
            ),
          ),
      barrierColor: Colors.black12.withOpacity(0.1),
      isDismissible: false,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)

  );
}


Future uploadSucceed(BuildContext context, Widget prevPage,Widget nextPage){
  print('uploadSucceed');
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context)=>
          Container(
            height: 230.h,
            child: Column(
              children: [
                SizedBox(height: 45.h,),
                Text('התצלום עלה בהצלחה', style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w600,color: Color(0xFFFB2576)),),
                SizedBox(height: 70.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFF00DEDE),
                      ),
                      child: TextButton(
                        child: Text('סרוק פעם נוספת',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => prevPage));
                        },
                      ),
                    ),
                    SizedBox(width: 13.w,),
                    Container(
                      width: 160.w,
                      height: 42.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFF00DEDE),
                      ),
                      child: TextButton(
                        child: Text('אישור',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => nextPage));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 22.h,),
              ],
            ),
          ),
      barrierColor: Colors.black12.withOpacity(0.1),
      isDismissible: false,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)

  );
}