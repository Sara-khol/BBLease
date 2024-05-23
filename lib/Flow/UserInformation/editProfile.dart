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

class EditPersonalDetails extends StatefulWidget {
  const EditPersonalDetails({Key? key}) : super(key: key);

  @override
  State<EditPersonalDetails> createState() => _EditPersonalDetailsState();


}

class _EditPersonalDetailsState extends State<EditPersonalDetails> {
  final TextEditingController _firstName = TextEditingController(text: User().firstName.isNotEmpty ? User().firstName : '');
  final TextEditingController _lastName = TextEditingController(text: User().lastName.isNotEmpty ? User().lastName : '');
  final TextEditingController _address = TextEditingController(text: User().address .isNotEmpty ? User().address : '');
  final TextEditingController _city= TextEditingController(text: User().city.isNotEmpty ? User().city : '');

  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
       body: SingleChildScrollView(
         reverse: true,
         child: Directionality(
           textDirection: ui.TextDirection.rtl,
           child: Column(
             children: [
               //Directionality(textDirection: ui.TextDirection.ltr, child: AppBarBibilease()),
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
               Text('פרופיל אישי', style: TextStyle(color: Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.bold,),),
               SizedBox(height: 35.h,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                   children:[
                     Icon(Icons.account_circle_outlined,color: pinkColorApp,size: 26.sp,),
                     Text('  פרטים אישיים',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
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
                       decoration: getInputDecoration('שם פרטי'),
                       style: TextStyle(color: blackColorApp,fontWeight: FontWeight.w300,fontSize: 18.sp,),
                       controller: _firstName,
                       // validator: (value) {
                       //   if (value == null || value.isEmpty)
                       //     return 'זהו שדה חובה';
                       //   return null;
                       // },
                     ),
                     SizedBox(height: 12.h,),
                     TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: blackColorApp,
                       decoration: getInputDecoration('שם משפחה'),
                       style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                       // validator: (value) {
                       //   if (value == null || value.isEmpty)
                       //     return 'זהו שדה חובה';
                       //   return null;
                       // },
                       controller: _lastName,
                     ),
                     SizedBox(height: 12.h,),
                     TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: blackColorApp,
                       decoration: getInputDecoration('כתובת'),
                       style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                       // validator: (value) {
                       //   if (value == null || value.isEmpty)
                       //     return 'זהו שדה חובה';
                       //   return null;
                       // },
                       controller:_address,
                     ),
                     SizedBox(height: 12.h,),
                     TextFormField(
                       textInputAction: TextInputAction.next,
                       cursorColor: blackColorApp,
                       decoration: getInputDecoration('עיר'),
                       style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                       // validator: (value) {
                       //   if (value == null || value.isEmpty)
                       //     return 'זהו שדה חובה';
                       //   return null;
                       // },
                       controller: _city,
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
                  fontWeight: FontWeight.normal),
            ),
            onPressed: () {
              User().firstName = _firstName.text;
              User().lastName = _lastName.text;
              User().address = _address.text;
              User().city = _city.text;

              Map<String, String> map = {
                "customer_id":User().userId.toString(),
                "f_name":_firstName.text,
                "l_name":_lastName.text,
                "address":_address.text,
                "city":_city.text,
              };
              showLoading(context);
              ApiService().updatePersonalDetails(map, (res) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalProfile(),),
                );

              });

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
          fontWeight: FontWeight.normal,
          color: turquoiseColorApp,
          fontFamily: 'PLONI',
          height: 1,
        ))
        : null,
    suffixIconConstraints: !isDate ? BoxConstraints(maxHeight: 26) : null,
    contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
  );
}
