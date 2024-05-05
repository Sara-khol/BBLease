import 'package:bblease/Flow/Rental/Actions/report_accident.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/services/support.dart' as support;

Future errorNoMatch(BuildContext context, Widget page) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
            height: 230.h,
            child: Column(
              children: [
                SizedBox(height: 36.h,),
                Text('אופס, שימו לב', style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w600, color: pinkColorApp),),
                SizedBox(height: 25.h,),
                Text('התמונה שעלתה באיכות גרועה לא נוכל לבצע אימות', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400, color: Colors.black,),),
                SizedBox(height: 26.h,),
                Container(
                  width: 332.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: turquoiseColorApp,
                  ),
                  child: TextButton(
                    child: Text('נסה שנית', style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w500),),
                    onPressed: () {
                      Navigator.push(context,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),));
}

Future uploadSucceed(BuildContext context, Widget prevPage, Widget nextPage) {
  print('uploadSucceed');
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
            height: 230.h,
        decoration: const BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                Text('התצלום עלה בהצלחה', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: pinkColorApp,height: 1),),
                //SizedBox(height: 74.h,),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 160.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: turquoiseColorApp,
                      ),
                      child: TextButton(
                        child: Text('סרוק פעם נוספת',textAlign:TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500,height: 1),),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => prevPage));
                        },
                      ),
                    ),
                    SizedBox(width: 13.w,),
                    Container(
                      width: 160.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color:turquoiseColorApp,
                      ),
                      child: TextButton(
                        child: Text('אישור',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500,height: 1)),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ));
}

Future displayError(BuildContext context,{bool existsData=true,String type='',
  String message='',Function()? onEdit,bool closeButton=false}) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          height: 230.h,
          decoration: const BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(children: [
            SizedBox(height: 25.h),
            Text('שגיאה',
                style: TextStyle(
                    color: pinkColorApp,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    height: 1)),
           // const Spacer(),
            Expanded(
              child: Center(
                child: Text(
                 message==''?  existsData?  '$type כבר קיימת במערכת\nבמידה והינך רשום התחבר לאזור האישי שלך\nבמידה ואינך רשום פנה לנציג לברור השגיאה':
                   'מספר טלפון אינו תואם למספר אותו הכנסת באימות':message,
                   textAlign: TextAlign.center,
                    style: TextStyle(
                      height:1,
                      color: blackColorApp,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400,
                    )),
              ),
            ),
            //SizedBox(height: 20.h),
           !closeButton? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 160.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        if(onEdit!=null)
                          {
                            onEdit();
                          }
                        else {
                          Navigator.pop(context);
                        }
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
                        backgroundColor: turquoiseColorApp,
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
              ])
            :  SizedBox(
             height: 42.h,
             width: 160.w,
             child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: turquoiseColorApp,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(100),
                   ),
                 ),
                 onPressed: () {
                     Navigator.pop(context);
                 },
                 child: Text(
                   'סגור',
                   style: TextStyle(
                       color: Colors.white,
                       fontSize: 18.sp,
                       fontWeight: FontWeight.w500),
                 )),
           ),
            SizedBox(height: 22.h)
          ])),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      );
}

Future displayMessage(BuildContext context,{
  String message='',Function()? onClose}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
        height: 180.h,
        decoration: const BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(children: [
          SizedBox(height: 25.h),
          // const Spacer(),
          Expanded(
            child: Center(
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height:1,
                    color: blackColorApp,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ),
          //SizedBox(height: 20.h),
           SizedBox(
            height: 42.h,
            width: 160.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if(onClose!=null)
                    {
                      onClose();
                    }
                },
                child: Text(
                  'סגור',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(height: 22.h)
        ])),
    barrierColor: Colors.black12.withOpacity(0.1),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
  );
}

Future displayQuestion(BuildContext context,{
  String message='', required Function() onYes}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
        height: 180.h,
        decoration: const BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(children: [
          SizedBox(height: 25.h),
          // const Spacer(),
          Expanded(
            child: Center(
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height:1,
                    color: pinkColorApp,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ),
          //SizedBox(height: 20.h),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 100.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'לא',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(width: 13.h),
                SizedBox(
                  height: 42.h,
                  width: 100.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        onYes();
                      },
                      child: Text(
                        'כן',
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

Future displayQuestion1(BuildContext context,{
  required String header,required String message, required Function() onYes}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
       height: 250.h,
        decoration: const BoxDecoration(color:Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(children: [
          SizedBox(height: 35.h),
          Text(header,style: TextStyle(color: pinkColorApp,fontWeight: FontWeight.w600,fontSize: 28.sp)),
          // const Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height:1,
                        fontSize: 20.sp,
                      )),
                ],
              ),
            ),
          ),
         SizedBox(height: 20.h),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 42.h,
                  width: 160.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'ביטול',
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
                        backgroundColor: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        onYes();
                        Navigator.pop(context);

                      },
                      
                      child: Text(
                        'אישור',
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

Future reportAccident(context){
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 45.h),
                    Text(
                      'דווח על תקלה',
                      style: TextStyle(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w600,
                          color: pinkColorApp),
                    ),
                    SizedBox(height: 84.h),

                    Row(
                      children: [
                        Container(
                          height: 48.h,
                          width: 160.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: turquoiseColorApp,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () =>support.call,
                              child: Text('לתקשר עם נציג',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                        SizedBox(width: 13.w,),
                        Container(
                          height: 48.h,
                          width: 160.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: turquoiseColorApp,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context) => ReportAccident(),)),
                              child: Text('השאר הודעה',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                      ],
                    ),
                    SizedBox(height: 22.h),
                  ]
              ),
            )
        );
      }
  );
}

Future displayErrorInValidation(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Container(
      height: 230.h,
      decoration: const BoxDecoration(color:Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child:
        Column(children: [
          SizedBox(height: 45.h),
          Text('שגיאה',
              textAlign: TextAlign.center,
              style: TextStyle(
                height:1,
                color: pinkColorApp,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              )),
          // const Spacer(),
          SizedBox(height: 33.h),
          Text('המערכת נתקלה בבעיה בזיהוי שלך\nהועבר לבדיקה',
              textAlign: TextAlign.center,
              style: TextStyle(
                height:1,
                color: blackColorApp,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              )),
          SizedBox(height: 34.h),
          SizedBox(
            height: 42.h,
            width: 160.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'סגור',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                )),
          ),
          SizedBox(height: 22.h)
        ])),
    barrierColor: Colors.black12.withOpacity(0.1),
    // shape: const RoundedRectangleBorder(
    //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
  );
}



