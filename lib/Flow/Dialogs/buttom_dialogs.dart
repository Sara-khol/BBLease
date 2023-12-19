import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future errorNoMatch(BuildContext context, Widget page) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
            height: 230.h,
            child: Column(
              children: [
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  'אופס, שימו לב',
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.pinkColorApp),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'התמונה שעלתה באיכות גרועה לא נוכל לבצע אימות',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                Container(
                  width: 332.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Color(0xFF00DEDE),
                  ),
                  child: TextButton(
                    child: Text(
                      'נסה שנית',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => page));
                    },
                  ),
                ),
                SizedBox(
                  height: 22.h,
                ),
              ],
            ),
          ),
      barrierColor: Colors.black12.withOpacity(0.1),
      isDismissible: false,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ));
}

Future uploadSucceed(BuildContext context, Widget prevPage, Widget nextPage) {
  print('uploadSucceed');
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
            height: 230.h,
            child: Column(
              children: [
                SizedBox(
                  height: 45.h,
                ),
                Text(
                  'התצלום עלה בהצלחה',
                  style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.pinkColorApp),
                ),
                SizedBox(
                  height: 64.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFF00DEDE),
                      ),
                      child: TextButton(
                        child: Text(
                          'סרוק פעם נוספת',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => prevPage));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Container(
                      width: 160.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Color(0xFF00DEDE),
                      ),
                      child: TextButton(
                        child: Text(
                          'אישור',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => nextPage));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22.h,
                ),
              ],
            ),
          ),
      barrierColor: Colors.black12.withOpacity(0.1),
      isDismissible: false,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ));
}

Future errorExistsDetails(BuildContext context, String type) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          height: 230.h,
          decoration: BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(children: [
            SizedBox(height: 35.h),
            Text('שגיאה',
                style: TextStyle(
                    color: colors.pinkColorApp,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    height: 1)),
            Spacer(),
            Text(
                '$type כבר קיימת במערכת\nבמידה והינך רשום התחבר לאזור האישי שלך\nבמידה ואינך רשום פנה לנציג לברור השגיאה',
               textAlign: TextAlign.center,
                style: TextStyle(
                  height:1,
                  color: colors.blackColorApp,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                )),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 160.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ערוך פרטים',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(width: 13.h),
                SizedBox(
                  height: 42.h,
                  width: 160.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'פניה לנציג',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ]),
            SizedBox(height: 22.h)
          ])),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      );
}
