import 'package:bblease/Flow/UserInformation/profile.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

import '../../services/api_service.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';
import '../home_page.dart';

class EditContactInformationPersonal extends StatefulWidget {
  const EditContactInformationPersonal({Key? key}) : super(key: key);

  @override
  State<EditContactInformationPersonal> createState() => _EditContactInformationPersonalState();


}

class _EditContactInformationPersonalState extends State<EditContactInformationPersonal> {
  final TextEditingController _phoneNumber = TextEditingController(text: User().phoneNumber.isNotEmpty ? User().phoneNumber : '');
  final TextEditingController _anotherPhone = TextEditingController(text: User().anotherPhone.isNotEmpty ? User().anotherPhone : '');
  final TextEditingController _email = TextEditingController(text: User().email.isNotEmpty ? User().email : '');
  final _formKey = GlobalKey<FormState>();

  bool formIsValid = false;
  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
       body: SingleChildScrollView(
         reverse: true,
         child: Directionality(
           textDirection: ui.TextDirection.rtl,
           child: Form(
             onChanged: () =>
                 setState(() => formIsValid = _formKey.currentState!.validate()),
             key: _formKey,
             child: Column(
               children: [
                // Directionality(textDirection: ui.TextDirection.ltr, child: AppBarBibilease()),
                  SizedBox(height: 24.h,),
                  Padding(
                    padding:  EdgeInsets.only(right: 23.w),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
                  ),
                 SizedBox(height: 5.h,),
                 Icon(
                   Icons.account_circle_outlined,
                   color: turquoiseColorApp,
                   size: 60.w,
                   weight: 100,
                 ),
                 SizedBox(height: 8.h,),
                 Text('פרופיל אישי', style: TextStyle(color: Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.w600,),),
                 SizedBox(height: 35.h,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                     children:[
                       Image.asset('assets/icons/Phone.png',width: 26.w,),
                       SizedBox(width: 6.w),
                       Text('פרטי התקשרות',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.w400,)),
                     ]
                 ),
                 SizedBox(
                   width: 332.w,
                  // height: 42.h,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [

                       SizedBox(height: 33.h,),
                       TextFormField(
                         textInputAction: TextInputAction.next,
                         cursorColor: blackColorApp,
                         decoration: getInputDecoration('טלפון נייד'),
                         style: TextStyle(color: blackColorApp,fontWeight: FontWeight.w300,fontSize: 18.sp,),
                         controller: _phoneNumber,
                         validator: (value) {
                           if (value != null) {
                             if (value.isEmpty) {
                               return null; // מאפשר להשאיר ריק
                             } else if (value.length < 10) {
                               return 'מספר טלפון צריך להכיל לפחות 10 ספרות';
                             }
                             return null; // ולידציה עברה בהצלחה
                           }
                          },
                       ),
                       SizedBox(height: 12.h,),
                       TextFormField(
                         textInputAction: TextInputAction.next,
                         cursorColor: blackColorApp,
                         decoration: getInputDecoration('טלפון נוסף'),
                         style: TextStyle(color: blackColorApp,fontWeight: FontWeight.w300,fontSize: 18.sp,),
                         controller: _anotherPhone,
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return null; // מאפשר להשאיר ריק
                              } else if (value.length < 10) {
                                return 'מספר טלפון צריך להכיל לפחות 10 ספרות';
                              }
                              return null; // ולידציה עברה בהצלחה
                            }
                          }
                       ),
                       SizedBox(height: 12.h,),
                       TextFormField(
                         textInputAction: TextInputAction.next,
                         cursorColor: blackColorApp,
                         decoration: getInputDecoration('אימייל'),
                         style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                          validator: (value) {
                            if (value != null && !value.isEmpty) {
                              bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              if (!emailValid) return 'אימיל לא תקין';
                            }
                          },
                         controller: _email,
                       ),
                        ],
                   ),
                 ),
                 //Spacer(),
                 SizedBox(height: 12.h,),
                 Padding( // this is new
                     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
                 ),
               ],
             ),
           ),
         ),
       ),
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(bottom: 40.h),
        child: Container(
          height: 42.h,
          width: 332.w,
          child: FloatingActionButton.extended(
            backgroundColor: turquoiseColorApp,
            label: Text(
              'שמור שינויים',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              if(_formKey.currentState!.validate()) {
                User().phoneNumber = _phoneNumber.text;
                User().anotherPhone = _anotherPhone.text;
                User().email = _email.text;

                Map<String, String> map = {
                  "customer_id":User().userId.toString(),
                  "phone":_phoneNumber.text,
                  "another_phone":_anotherPhone.text,
                  "email":_email.text,
                };
                showLoading(context);
                ApiService().updatePersonalContact(map, (res) {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PersonalProfile(),),
                  );

                });
              }
              },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}
getInputDecoration(String text, {bool isDate = false, String suffixText = ''}) {
  return InputDecoration(
    isDense: true,
    labelText: text,

    labelStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w300,
        color: blackColorApp,
        fontFamily: 'PLONI'),
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
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: blackColorApp,
      ),
    ) ,
    suffixIcon: isDate
        ?ImageIcon(
      AssetImage("assets/icons/Calendar.png"),
      size: 24.w,
      color:pinkColorApp,
    )
        : suffixText.isNotEmpty
        ? Text(suffixText,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          color: turquoiseColorApp,
          fontFamily: 'PLONI',
          height: 1,
        ))
        : null,
    suffixIconConstraints: !isDate ? BoxConstraints(maxHeight: 26) : null,
    contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
  );
}
