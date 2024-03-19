
import 'package:bblease/Flow/registration/payment_webVIew.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';

import 'package:bblease/utils/my_colors.dart';

class LicenseDetails extends StatefulWidget {
  const LicenseDetails({Key? key}) : super(key: key);

  @override
  State<LicenseDetails> createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _licenseId =
      TextEditingController(text: User().licenseId);

  // TextEditingController _expDate=TextEditingController(text: intl.DateFormat('dd-mm-yyyy').format(User().licenseExpDate));
  final TextEditingController _expDate =
      TextEditingController(text: User().licenseExpDate);
  final TextEditingController _issDate =
      TextEditingController(text: User().licenseIssDate);
  final TextEditingController _degree =
       TextEditingController(text: User().licenseDegree);

  String exp = User().licenseExpDate;
  String iss = User().licenseIssDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 30.w, left: 31.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 53.h,
                ),
                 Icon(
                  Icons.account_circle_outlined,
                  color: turquoiseColorApp,
                  size: 60.w,
                  weight: 100,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'פרטי רשיון נהיגה',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: blackColorApp,
                        fontFamily: 'PLONI',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 34.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: blackColorApp,
                  decoration: getInputDecoration('מספר רשיון נהיגה'),
                  style: TextStyle(color: blackColorApp, fontSize: 18.sp),
                  controller: _licenseId,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: blackColorApp,
                  decoration: getInputDecoration('תוקף',
                      suffixIcon: Image.asset(
                        'assets/icons/Calendar.png',
                        width: 24.w,
                      )),
                  style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                  controller: _expDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        locale: const Locale("he", "HE"),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      setState(() {
                        _expDate.text =
                            intl.DateFormat('dd/MM/yyyy').format(date);
                        // exp=date;
                        exp = intl.DateFormat('yyyy-MM-dd').format(date);
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: blackColorApp,
                  decoration: getInputDecoration('תאריך הנפקה',
                      suffixIcon:   Image.asset(
                        'assets/icons/Calendar.png',
                        width: 24.w,
                      )),
                  style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                  controller: _issDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                        locale: const Locale("he", "HE"),
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());
                    if (date != null) {
                      setState(() {
                        _issDate.text =
                            intl.DateFormat('dd/MM/yyyy').format(date);
                        iss = intl.DateFormat('yyyy-MM-dd').format(date);
                      });
                    }
                  },
                ),
               SizedBox(
                  height: 12.h,
                ),
                TextFormField(
                  cursorColor: blackColorApp,
                  decoration: getInputDecoration('דרגת רשיון'),
                  style:
                      TextStyle(color: blackColorApp, fontSize: 18.sp),
                  controller: _degree,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                ),
                SizedBox(
                  height: 27.h,
                ),
                ListTileTheme(
                  horizontalTitleGap: 1.0,
                  child: CheckboxListTile(
                    title: Text(
                      "נהג חדש",
                      style: TextStyle(
                          fontFamily: 'PLONI',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          color: blackColorApp),
                    ),
                    value: User().isNewDriver,
                    onChanged: (bool? value) {
                      setState(() {
                        User().isNewDriver = value!;
                      });
                    },
                    checkColor: blackColorApp,
                    activeColor: Colors.transparent,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(
                      color: blackColorApp,
                      width: 1.5,
                    ),
                  ),
                ),
                //Spacer(),
                SizedBox(height: 152.h),
                Container(
                height: 42.h,
                width: 332.w,

                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User().licenseId = _licenseId.text;
                        User().licenseDegree = _degree.text;
                        User().licenseDegree ='';
                        User().licenseIssDate = iss.toString();
                        User().licenseExpDate = exp;
                        await registerUser();
                      }
                    },
                    child: Text('הבא',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500))),
                                  ),
                SizedBox(height: 40.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getInputDecoration(String text, {Widget? suffixIcon}) {
    return InputDecoration(
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

  registerUser() async {
    showLoading(context);
    await ApiService().registerCustomerDetails((res) async {
      if (res is String) {
        Navigator.pop(context);
        if (res.startsWith('in the system exists user with tz')) {
          displayError(context, type: 'תעודת זהות', onEdit: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (res.startsWith('in the system exists user with email')) {
          displayError(context, type: 'כתובת מייל', onEdit: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        } else if (res.startsWith('no exists user with phone')) {
          displayError(context, existsData: false, onEdit: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
      } else if (res is int) {
        User().userId = res;
        // MySharedPreferences().setLastUsage();
        // MySharedPreferences().setUserId(User().userId);
        await ApiService().getPaymentUrl(User().userId, (res) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentWebView(
                        url: res,
                      )),
              (route) => false);
        });

      }
    });
  }
}
