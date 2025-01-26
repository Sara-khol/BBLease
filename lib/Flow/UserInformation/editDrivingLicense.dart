import 'package:bblease/Flow/UserInformation/profile.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import 'dart:ui' as ui;

import '../../landspace_widget.dart';
import '../../services/api_service.dart';
import '../Rental/dialogs.dart';

class EditDrivingLicensePersonal extends StatefulWidget {
  const EditDrivingLicensePersonal({super.key});

  @override
  State<EditDrivingLicensePersonal> createState() => _EditDrivingLicensePersonalState();


}

class _EditDrivingLicensePersonalState extends State<EditDrivingLicensePersonal> {
  final TextEditingController _licenseId = TextEditingController(text: User().licenseId .isNotEmpty ? User().licenseId : '');
  final TextEditingController _licenseIssDate = TextEditingController(text: User().licenseIssDate.isNotEmpty ? User().licenseIssDate : '');
  final TextEditingController _licenseExpDate = TextEditingController(text: User().licenseExpDate.isNotEmpty ? User().licenseExpDate : '');
  final TextEditingController _licenseDegree = TextEditingController(text: User().licenseDegree .isNotEmpty ? User().licenseDegree : '');

  @override
  Widget build(BuildContext context,) {

    return OrientationBuilder(builder: (c,o){
      return o==Orientation.landscape?
      LandSpaceWidget(mainWidget: buildContent(), imageProperties: ImageProperties('image4.png', 1000.w,'תמונת פרטי רכב')) :buildContent();
    },);
  }


  buildContent(){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Column(
            children: [
              // Directionality(textDirection: ui.TextDirection.ltr, child: AppBarBibilease()),
              SizedBox(height: 24.h,),
              Padding(
                padding:  EdgeInsets.only(right: 23.w),
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios))),
              ),
              SizedBox(height: 5.h,),
              Icon(
                Icons.account_circle_outlined,
                color: turquoiseColorApp,
                size: 60.w,
                weight: 100,
              ),
              SizedBox(height: 8.h,),
              Text('פרופיל אישי', style: TextStyle(color: const Color(0xFF0F1511), fontSize: 24.sp, fontWeight: FontWeight.bold,),),
              SizedBox(height: 35.h,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset('assets/icons/car_icon_big.png'),
                    SizedBox(width: 6.w),
                    Text('רישיון נהיגה',style: TextStyle(color: pinkColorApp, fontSize: 20.sp, fontWeight: FontWeight.normal,)),
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
                      decoration: getInputDecoration('מספ רשיון נהיגה'),
                      style: TextStyle(color: blackColorApp,fontWeight: FontWeight.w300,fontSize: 18.sp,),
                      controller: _licenseId,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty)
                      //     return 'זהו שדה חובה';
                      //   return null;
                      // },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      readOnly: true,
                      cursorColor: blackColorApp,
                      decoration: getInputDecoration('תוקף',
                          suffixIcon: Image.asset(
                            'assets/icons/CalendarBig.png',
                            color: pinkColorApp,
                          )),
                      style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                      controller: _licenseExpDate,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) return 'זהו שדה חובה';
                      //   return null;
                      // },
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            locale: const Locale("he", "HE"),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          setState(() {
                            _licenseExpDate.text =
                                intl.DateFormat('yyyy-MM-dd').format(date);
                            // exp=date;
                            // exp= intl.DateFormat('dd/MM/yyyy').format(date);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      readOnly: true,
                      cursorColor: blackColorApp,
                      decoration: getInputDecoration('תאריך הנפקה',
                          suffixIcon:   Image.asset(
                              'assets/icons/CalendarBig.png')),
                      style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                      controller: _licenseIssDate,
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) return 'זהו שדה חובה';
                      //   return null;
                      // },
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                            locale: const Locale("he", "HE"),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now());
                        if (date != null) {
                          setState(() {
                            // iss =
                            //     intl.DateFormat('dd/MM/yyyy').format(date);
                            _licenseIssDate.text = intl.DateFormat('yyyy-MM-dd').format(date);
                          });
                        }
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      cursorColor: blackColorApp,
                      decoration: getInputDecoration('דרגת רישיון'),
                      style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty)
                      //     return 'זהו שדה חובה';
                      //   return null;
                      // },
                      controller: _licenseDegree,
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
        child: SizedBox(
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
              User().licenseId = _licenseId.text;
              User().licenseIssDate = _licenseIssDate.text;
              User().licenseExpDate = _licenseExpDate.text;
              User().licenseDegree = _licenseDegree.text;

              Map<String, String> map = {
                "customer_id":User().userId.toString(),
                "license_id":_licenseId.text,
                "license_iss_date":_licenseIssDate.text,
                "license_exp_date":_licenseExpDate.text,
                "license_degree":_licenseDegree.text,
              };
              showLoading(context);
              ApiService().updatePersonalDriverLicense(map, (res) {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalProfile(),),
                );

              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PersonalProfile()));
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
getInputDecoration(String text, {bool isDate = false, String suffixText = '',Widget? suffixIcon}) {
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
    suffixIcon: suffixIcon,
    contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
  );
}
