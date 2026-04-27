import 'package:bblease/Flow/Rental/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../../utils/common_funcs.dart';
import '../../utils/my_colors.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  final TextEditingController _name=TextEditingController();
  final TextEditingController _phone=TextEditingController();
  final TextEditingController _email=TextEditingController();
  final TextEditingController _text=TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LandSpaceWidget(
          mainWidget: buildContent(),imageProperties:ImageProperties('image5.png', 1000.w,'תמונת פעולות')),
    );
  }

  buildContent() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(

          padding: EdgeInsets.only(
              bottom: MediaQuery
                  .of(context)
                  .viewInsets
                  .bottom, left: 30.w, right: 30.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CommonFuncs().getBackButton(context),
             //SizedBox(height: 62.h,),
             SizedBox(height: 20.h),
              Text('יש שאלה?',
                style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              Text('אנחנו כאן בשבילך',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
              SizedBox(height: 19.h,),
              TextFormField(
                keyboardType: TextInputType.name,
                cursorColor: blackColorApp,
                decoration: getInputDecoration(
                  'שם מלא',
                  332.w,
                  suffixIcon: SizedBox(
                    width:26.sp.clamp(22.0, 30.0),
                    height: 26.sp.clamp(22.0, 30.0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Icon(
                        Icons.account_circle_outlined,
                        color: blackColorApp,
                        size:22.sp.clamp(20.0, 26.0),
                      ),
                    ),
                  ),
                ),
                style:
                TextStyle(color: blackColorApp, fontSize: 18.sp),
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
                  decoration: getInputDecoration(
                    'טלפון',
                    159.w,
                    suffixIcon: SizedBox(
                      width:26.sp.clamp(22.0, 30.0),
                      height: 26.sp.clamp(22.0, 30.0),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Icon(
                          Icons.phone_outlined,
                          color: blackColorApp,
                          size:22.sp.clamp(20.0, 26.0),
                        ),
                      ),
                    ),
                  ),
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
                      decoration: getInputDecoration(
                        'אימייל',
                        160.w,
                        suffixIcon: SizedBox(
                          width:26.sp.clamp(22.0, 30.0),
                          height: 26.sp.clamp(22.0, 30.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Icon(
                              Icons.email_outlined,
                              color: blackColorApp,
                              size:22.sp.clamp(20.0, 26.0),
                            ),
                          ),
                        ),
                      ),
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
                decoration: getInputDecoration('ההודעה שלך', 332.w),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Row(
                    children: [
                       Icon(Icons.fmd_good_outlined,size: 22.sp.clamp(20.0, 26.0),),
                      SizedBox(width: 11.w),
                      Text(
                        'כפר העברי 1, נווה יעקב, ירושלים\nשלמה המלך 4, בני ברק\nהרב שך 34, ביתר עילית\nמנחם פורוש 1, בית שמש ',
                        style: TextStyle(fontSize: 18.sp),)
                    ],
                  ),*/
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                       Icon(Icons.phone_outlined,size: 22.sp.clamp(20.0, 26.0),),
                      SizedBox(width: 11.w),
            SelectableText(
              '+972 53-548-4682\n*6873',
              style: TextStyle(fontSize: 18.sp),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
            )
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    children: [
                       Icon(Icons.email_outlined,size: 22.sp.clamp(20.0, 26.0),),
                      SizedBox(width: 11.w),
                      SelectableText('officeBclick@gmail.com',
                        style: TextStyle(fontSize: 18.sp))
                    ],
                  ),
                  SizedBox(height: 39.h,),
                  Text('באפשרותך לפנות אלינו במייל ותיענה בתוך 72 שעות.',
                    style: TextStyle(fontSize: 13.sp),),
                  SizedBox(height: 20.h,),
                  SelectableText(
                    'במקרה חירום בהזמנה פעילה בלבד! \nנא לחייג ל 6873* שלוחה 5 ',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 13.sp),),
                  SizedBox(height: 15.h,),
                  SizedBox(
                    height: 48.h,
                    width: 332.w,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: turquoiseColorApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          Map<String, String> map = {
                            "name": _name.text,
                            "tel": _phone.text,
                            "mail": _email.text,
                            "msg": _text.text,
                            "id": User().userId.toString()
                          };
                          showLoading(context);
                          ApiService().sendFeedback(map, (res) {
                            Navigator.pop(context);
                            displayMessage(context,
                                message: 'ההודעה התקבלה בהצלחה',
                                onClose: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RentalWidget(),),
                                  );
                                });
                          });
                        },
                        child: Text(
                          'צרו איתי קשר',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        )
                    ),
                  ),
                  SizedBox(height: 31.h,),
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
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
      suffixIcon: suffixIcon,
    ).copyWith(
      suffixIconConstraints: const BoxConstraints(
        minWidth: 0,
        minHeight: 0,
      ),
    );
  }
}
