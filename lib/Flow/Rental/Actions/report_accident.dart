import 'package:flutter/material.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/class_user.dart';
import '../../../services/api_service.dart';
import '../../Dialogs/buttom_dialogs.dart';
import '../../home_page.dart';
import '../dialogs.dart';

class ReportAccident extends StatefulWidget {
  const ReportAccident({Key? key}) : super(key: key);

  @override
  State<ReportAccident> createState() => _ReportAccidentState();
}

class _ReportAccidentState extends State<ReportAccident> {
  TextEditingController _name=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _text=TextEditingController();

  XFile? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,left: 30.w,right: 30.w),
            child: Column(
              children: [
                SizedBox(height: 35.h,),
                Align(
                  alignment: Alignment.centerRight,
                    child: IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
                SizedBox(height: 62.h,),
                Text('דווח על תקלה',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                SizedBox(height: 36.h,),
                Text('נתקלת בבעיה בהפעלת הרכב?\nבעיה באפליקציה?\nלכל שאלה אנחנו כאן :)',
                  style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                SizedBox(height: 39.h,),
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
                  maxLines: 4,
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
                SizedBox(height: 14.h,),
                SizedBox(
                  height: 48.h,
                  width: 332.w,
                  child: FloatingActionButton(
                      backgroundColor: Color(0xFF03AEB9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
        
                      onPressed: () =>imageSource(context),
                      child: Text(
                        image==null?'צרף תמונה':image!.name,
                        style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                      )
                  ),
                ),
                SizedBox(height: 30.h,),
                SizedBox(
                  width: 242.w,
        
                  child: Text('נציגנו יקבלו את פנייתך ויענו לך בתוך 72 שעות מזמן הפניה.\n\nבמקרה חירום בהזמנה פעילה בלבד! נא לחייג ל 0000* שלוחה 0 ',
                      style: TextStyle(fontSize: 13.sp,),),
                ),
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
                      onPressed: () {
                        Map<String, String> map = {
                          "name":_name.text,
                          "tel":_phone.text,
                          "mail":_email.text,
                          "msg":_text.text,
                          "id":User().userId.toString()
                        };
                        showLoading(context);
                        ApiService().newOrder(map, (res) {
                          Navigator.pop(context);
                          displayMessage(context,
                              message: 'ההזמנה התקבלה בהצלחה',
                              onClose: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage(),),
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
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getInputDecoration1(String text,double width, {Widget? suffixIcon}) {
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

  Future imageSource(context){
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
              child: Wrap(
                children: [
                  Container(
                    height: 28.h,
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'צירוף תמונה',
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                color: pinkColorApp),
                          ),
                          SizedBox(height: 80.h),
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
                                    onPressed: () => pickImage(ImageSource.camera),
                                    child: Text('פתח מצלמה',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal))),
                              ),
                              SizedBox(width: 13.w),

                              Container(
                                height: 48.h,
                                width: 160.w,
                                padding: EdgeInsets.zero,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: turquoiseColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () => pickImage(ImageSource.gallery),
                                    child: Text('העלאה מהמכשיר',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 22.h),
                        ]
                    ),
                  ),
                ],
              )
          );
        }
    );
  }

  Future pickImage(ImageSource imageSource) async{
    final _image = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      image=_image;
    });
  }
}
