import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/my_colors.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController _name=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _text=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(

          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,left: 30.w,right: 30.w),
          child: Column(
            children: [
              SizedBox(height: 35.h,),
              IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios)),
              SizedBox(height: 62.h,),
              Text('יש שאלה?',style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
              Text('אנחנו כאן בשבילך',style: TextStyle(fontSize: 28.sp,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
              SizedBox(height: 19.h,),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: blackColorApp,
                decoration: getInputDecoration('שם מלא',332.w,suffixIcon:Icon(Icons.account_circle_outlined)),
                style:
                TextStyle(color: blackColorApp, fontSize: 18 .sp),
                controller: _name,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'זהו שדה חובה';
                  return null;
                },
              ),
              SizedBox(height: 13.h,),
              Row(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('טלפון',159.w,suffixIcon:Icon(Icons.phone_outlined)),
                    style:
                    TextStyle(color: blackColorApp, fontSize: 18.sp),
                    controller: _phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'זהו שדה חובה';
                      return null;
                    },
                  ),
                  SizedBox(width: 13.w,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('אימייל',160.w,suffixIcon:Icon(Icons.email_outlined)),
                    style:
                    TextStyle(color: blackColorApp, fontSize: 18.sp),
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'זהו שדה חובה';
                      return null;
                    },
                  ),
                ],
              ),
              SizedBox(height: 13.h,),
              TextFormField(
                keyboardType: TextInputType.multiline,
                cursorColor: blackColorApp,
                decoration: getInputDecoration('ההודעה שלך',332.w),
                style:
                TextStyle(color: blackColorApp, fontSize: 18.sp),
                controller: _text,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'זהו שדה חובה';
                  return null;
                },
              ),
              SizedBox(height: 29.h,),

              Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.fmd_good_outlined),
                      SizedBox(width:11.w),
                      Text('כפר העברי 1, נווה יעקב, ירושלים\nשלמה המלך 4, בני ברק\nהרב שך 34, ביתר עילית\nמנחם פורוש 1, בית שמש ',
                        style: TextStyle(fontSize: 18.sp),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined),
                      SizedBox(width:11.w),
                      Text('1700-700-700',
                        style: TextStyle(fontSize: 18.sp),)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(width:11.w),
                      Text('bibilease@gmail.com',
                        style: TextStyle(fontSize: 18.sp),)
                    ],
                  ),
                  SizedBox(height: 39.h,),
                  Text('במקרה חירום בהזמנה פעילה בלבד! \nנא לחייג ל 0000* שלוחה 0 באפשרותך לפנות אלינו במייל ותיענה בתוך 72 שעות.\n\n ', style: TextStyle(fontSize: 13.sp),),
                  SizedBox(height: 15.h,),
                  SizedBox(
                    height: 48.h,
                    width: 332.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: turquoiseColorApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'צרו איתי קשר',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getInputDecoration(String text,double width, {Widget? suffixIcon}) {
    return InputDecoration(
      constraints: BoxConstraints(maxWidth: width),
      isDense: true,
      labelText: text,
      labelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w300,
        color: blackColorApp,
        fontFamily: 'PLONI',
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: blackColorApp,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: Colors.redAccent,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
      suffixIcon: suffixIcon,
    );
  }
}
