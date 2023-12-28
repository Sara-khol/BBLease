import 'package:bblease/Flow/registration/payment_webVIew.dart';
import 'package:bblease/Flow/registration/start_registration.dart';
import 'package:bblease/Flow/registration/sucsses_registration.dart';
import 'package:bblease/Flow/terms_and_conditions.dart';
import 'package:bblease/utils/common_funcs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/utils/my_colors.dart' as colors;

import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';
import '../Rental/map.dart';
import '../my_shared_preferences.dart';

class TelToRegistrationForm extends StatefulWidget {
  final bool isRegister;

  const TelToRegistrationForm({Key? key, required this.isRegister})
      : super(key: key);

  @override
  State<TelToRegistrationForm> createState() => _TelToRegistrationFormState();
}

class _TelToRegistrationFormState extends State<TelToRegistrationForm> {
  bool checkboxValue1 = false;
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  FocusNode textSecondFocusNode = new FocusNode();

  bool didSendCode = false;

  @override
  void initState() {
    User().clear();
    super.initState();
  }

  // late int status;
  late int code;
  final _formKey = GlobalKey<FormState>();

  getVerificationCode(bool isSms) async {
    showLoading(context);
    await ApiService().getVerificationCode(_phone.text, isSms, (value) {
      Navigator.pop(context);
      int status = value['status'];

      if (widget.isRegister) {
        if (status == 4 || status == 5) {
          code = value['code'];
          debugPrint('status $status code $code');
          didSendCode = true;
          textSecondFocusNode.requestFocus();
        } else {
          // if (status == 1)
          {
            displayError(context,
                message: 'מספר הטלפון שהזנת  כבר קיים  במערכת');
          }
        }
      } else {
        if (status == 1) {
          code = value['code'];
          debugPrint('status $status code $code');
          didSendCode = true;
          textSecondFocusNode.requestFocus();
        } else {
          if (status == 4 || status == 5) {
            displayError(context,
                message: 'מספר הטלפון שהזנת אינו קיים במערכת');
          } else {
            if (status == 3) {
              displayError(context, message: 'משתמש זה חסום');
            }
          }
        }
      }
      setState(() {});
    });
  }

  verifyCode() async {
    showLoading(context);
    await ApiService().codeVerification(_phone.text, code.toString(),
        (response) {
      // Navigator.pop(context);
      int vStatus = response['status'];
      // in case code is not correct get from service error.
      // not supposed to get to here because checked before sending
      if (vStatus == 3) {
        displayError(context, message: 'קוד האימות אינו תואם');
      } else {
        if (widget.isRegister) {
          if (vStatus == 5) {
            User().phoneNumber = _phone.text;

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StartRegistration()));
          }
        } else {
          if (vStatus == 1) {
            User.fromJson(response['customer']);
            debugPrint('user name  ${User().firstName}');
            MySharedPreferences().setLastUsage();
            MySharedPreferences().setUserId(User().userId);
            if (User().tranzilaStatus) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const SucssesRegistrationForm() /*RentalWidget()*/),
                  (route) => false);
            }
            else
              {
                ApiService().getPaymentUrl(User().userId, (res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaymentWebView(
                            url: res,
                          )),
                          (route) => false);
                });
              }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 30.w, left: 30.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 121.h,
                ),
                Text(
                  widget.isRegister
                      ? "הזן מספר טלפון להרשמה"
                      : "הזן מספר טלפון להתחברות",
                  style:
                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 50.h,
                ),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.number,
                  cursorColor: colors.blackColorApp,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "מס' נייד",
                    labelStyle: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color: colors.blackColorApp,
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
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 20.w,
                    ),
                    prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 14.w),
                        child: Icon(Icons.phone,
                            size: 23.sp,
                            color: colors
                                .pinkColorApp) //Image.asset('assets/images/Phone.png', width: 24.w,),
                        ),
                    prefixIconConstraints: const BoxConstraints(
                      maxHeight: 26,
                    ),
                    suffixIcon: didSendCode
                        ? Padding(
                            padding: EdgeInsets.only(left: 14.w),
                            child: Icon(Icons.edit_note,
                                size: 23.sp,
                                color: colors
                                    .turquoiseColorApp) //Image.asset('assets/images/Phone.png', width: 24.w,),
                            )
                        : null,
                  ),
                  style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color: colors.blackColorApp),
                  validator: (value) {
                    if (value == null || value.length < 10)
                      return 'מספר הטלפון חייב להיות בן 10 ספרות';
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                Visibility(
                  visible: didSendCode && checkboxValue1,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _code,
                    focusNode: textSecondFocusNode,
                    cursorColor: colors.blackColorApp,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: "הזן סיסמא שהתקבלה",
                      labelStyle: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w300,
                        color: colors.blackColorApp,
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
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 20.w,
                      ),
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 20.w, left: 14.w),
                          child: Icon(Icons.password,
                              size: 23.sp,
                              color: colors
                                  .pinkColorApp) //Image.asset('assets/images/Phone.png', width: 24.w,),
                          ),
                      prefixIconConstraints: const BoxConstraints(
                        maxHeight: 26,
                      ),
                      prefixIconColor: colors.pinkColorApp,
                    ),
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w300,
                        color: colors.blackColorApp),
                    validator: (value) {
                      //todo remove checking code correct here ??
                      if (value == null || value != code.toString())
                        return 'קוד שגוי';
                      return null;
                    },
                  ),
                ),
                Visibility(
                  visible: !didSendCode,
                  child: ListTileTheme(
                    horizontalTitleGap: 1.0,
                    child: CheckboxListTile(
                      value: checkboxValue1,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValue1 = value!;
                        });
                      },
                      title: Row(
                        children: [
                          Text(
                            'אני מאשר/ת את ',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                          GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Terms())),
                              child: Text(
                                'תנאי השימוש',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    decoration: TextDecoration.underline),
                              )),
                        ],
                      ),
                      checkColor: colors.blackColorApp,
                      activeColor: Colors.transparent,
                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(
                        color: colors.blackColorApp,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                Visibility(
                  visible: didSendCode,
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            _code.text = '';
                            getVerificationCode(true);
                          },
                          child: Text('שלח שוב SMS',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22.sp,
                                  decoration: TextDecoration.underline,
                                  color: colors.blackColorApp))),
                      TextButton(
                          onPressed: () {
                            _code.text = '';
                            getVerificationCode(false);
                          },
                          child: Text(
                            'שלח שוב שיחה קולית',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 22.sp,
                                decoration: TextDecoration.underline,
                                color: colors.blackColorApp),
                          )),
                      // SizedBox(
                      //   height: 100.h,
                      // ),
                    ],
                  ),
                ),

                Flexible(
                  fit: FlexFit.loose,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 40.h),
                      child: SizedBox(
                        height: 48.h,
                        width: 332.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.turquoiseColorApp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () {
                              if (!didSendCode) {
                                if (_formKey.currentState!.validate() &&
                                    checkboxValue1) {
                                  setState(() {});
                                  getVerificationCode(true);
                                } else {
                                  if (!checkboxValue1) {
                                    displayError(context,
                                        message: 'יש לאשר את תנאי השימוש',
                                        closeButton: true);
                                  }
                                }
                              }
                              // if (step == 1 && didSendCode == true) {
                              else {
                                if (_formKey.currentState!.validate()) {
                                  verifyCode();
                                }
                              }
                            },
                            child: Text('אישור',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
