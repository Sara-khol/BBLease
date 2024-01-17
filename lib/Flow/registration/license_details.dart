
import 'package:bblease/Flow/registration/payment_webVIew.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';
import '../my_shared_preferences.dart';
import 'sucsses_registration.dart';
import 'package:bblease/utils/my_colors.dart' as colors;

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
  // final TextEditingController _degree =
  //     TextEditingController(text: User().licenseDegree);

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
            padding: EdgeInsets.only(right: 30.w, left: 30.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                const Icon(
                  Icons.account_circle_outlined,
                  color: Color.fromRGBO(0, 222, 222, 1),
                  size: 60,
                  weight: 100,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'פרטי רשיון נהיגה',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: colors.blackColorApp,
                        fontFamily: 'PLONI',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: colors.blackColorApp,
                  decoration: getInputDecoration('מספר רשיון נהיגה'),
                  style:
                      TextStyle(color: colors.blackColorApp, fontSize: 22.sp),
                  controller: _licenseId,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: colors.blackColorApp,
                  decoration: getInputDecoration('תוקף',
                      suffixIcon: Image.asset(
                        'assets/images/Calendar.png',
                        width: 18.w,
                      )),
                  style:
                      TextStyle(color: colors.blackColorApp, fontSize: 22.sp),
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
                  height: 16.h,
                ),
                TextFormField(
                  readOnly: true,
                  cursorColor: colors.blackColorApp,
                  decoration: getInputDecoration('תאריך הנפקה',
                      suffixIcon: const Icon(
                        Icons.calendar_today_outlined,
                        color: Color.fromRGBO(251, 37, 118, 1),
                      )),
                  style:
                      TextStyle(color: colors.blackColorApp, fontSize: 22.sp),
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
         /*       SizedBox(
                  height: 16.h,
                ),
                TextFormField(
                  cursorColor: colors.blackColorApp,
                  decoration: getInputDecoration('דרגת רשיון'),
                  style:
                      TextStyle(color: colors.blackColorApp, fontSize: 22.sp),
                  controller: _degree,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'זהו שדה חובה';
                    return null;
                  },
                ),*/
                SizedBox(
                  height: 60.h,
                ),
                ListTileTheme(
                  horizontalTitleGap: 1.0,
                  child: CheckboxListTile(
                    title: Text(
                      "נהג חדש",
                      style: TextStyle(
                          fontFamily: 'PLONI',
                          fontSize: 20.sp,
                          color: colors.blackColorApp),
                    ),
                    value: User().isNewDriver,
                    onChanged: (bool? value) {
                      setState(() {
                        User().isNewDriver = value!;
                      });
                    },
                    checkColor: colors.blackColorApp,
                    activeColor: Colors.transparent,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(
                      color: colors.blackColorApp,
                      width: 1.5,
                    ),
                  ),
                ),
                Container(
                  height: 48.h,
                  width: 250.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User().licenseId = _licenseId.text;
                          //User().licenseDegree = _degree.text;
                          User().licenseDegree ='';
                          User().licenseIssDate = iss.toString();
                          User().licenseExpDate = exp;
                          await registerUser();
                        }
                      },
                      child: Text('הבא',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500))),
                ),
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
        fontSize: 22.sp,
        fontWeight: FontWeight.w300,
        color: colors.blackColorApp,
        fontFamily: 'PLONI',
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colors.blackColorApp,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colors.blackColorApp,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: colors.blackColorApp,
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
