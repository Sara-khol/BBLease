import 'package:bblease/Flow/Rental/active_rent.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/registration/payment_webView.dart';
import 'package:bblease/Flow/registration/start_registration.dart';
import 'package:bblease/Flow/UserInformation/terms_and_conditions.dart';
import 'package:bblease/Flow/registration/wait_for_approve_screen.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart'  ;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:sms_autofill/sms_autofill.dart'hide Orientation;

import '../../models/class_rent.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../Dialogs/buttom_dialogs.dart';
import '../Rental/dialogs.dart';
import '../my_shared_preferences.dart';
import 'package:bblease/customWidgets/customText.dart';

class TelToRegistrationForm extends StatefulWidget {

  const TelToRegistrationForm({super.key});

  @override
  State<TelToRegistrationForm> createState() => _TelToRegistrationFormState();
}

class _TelToRegistrationFormState extends State<TelToRegistrationForm> {
  bool checkboxValue1 = false;
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  FocusNode textSecondFocusNode = FocusNode();
  bool isRegister=true;

  bool didSendCode = false;

  @override
  void initState() {
    User().clear();
    super.initState();
    _listenForSmsCode();
  }

  void _listenForSmsCode() async {
    SmsAutoFill().listenForCode;
  }

  // late int status;
  // late int code;
  final _formKey = GlobalKey<FormState>();

  getVerificationCode(int type) async {
    showLoading(context);
    if(!isRegister)
      {
        await ApiService().sendCodeToRegistration(_phone.text, type, (value) {
          Navigator.pop(context);
          int status = value['status'];
          print('status: $status');
            if (status == 4 || status == 5) {
              //  code = value['code'];
              // debugPrint('status $status code $code');
              didSendCode = true;
              textSecondFocusNode.requestFocus();
            }
            if (status == 3) {
              displayError(context,
                  message: 'תעודת הזהות שהכנסת נחסמה בעבר הועבר לבדיקה');
            }
            else {
              if (status == 1)
              {
                displayError(context,
                    message: 'מספר הטלפון שהזנת  כבר קיים  במערכת');
              }
            }
          setState(() {});
        });
      }
    else
      {
        await ApiService().getVerificationCode(_phone.text, type, (value) {
          Navigator.pop(context);
          int status = value['status'];
          print('status: $status');
            if (status == 1) {
              // code = value['code'];
              // debugPrint('status $status code $code');
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
          setState(() {});
        });
      }

  }

  verifyCode() async {
    showLoading(context);
    try {
      await ApiService().codeVerification(_phone.text, _code.text,
              (response) {
            Navigator.pop(context);
            int vStatus = response['status'];
            // in case code is not correct get from service error.
            // not supposed to get to here because checked before sending
            if (vStatus == 3) {
              displayError(context, message: 'קוד האימות אינו תואם');
            } else {
              if (!isRegister) {
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

                  //todo: go to active rent
                  if (response["active_order"].isNotEmpty) {
                    print('active order is not empty');
                    User().currentRent =
                        Rental.fromJson(response["active_order"]);
                  }
                  print('after if');
                  MySharedPreferences().setLastUsage();
                  MySharedPreferences().setUserId(User().userId);
                  if (User().tranzilaStatus) {
                    if(User().customerStatus=='active_customer') {
                      if (User().currentRent != null) {
                        print('current rent is not null');
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const ActiveRentDetails()),
                                (route) => false);
                      }
                      else {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const RentalWidget()),
                                (route) => false);
                      }
                    }
                    else{
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const WAitForApproveScreen()),
                              (route) => false);
                    }
                 }
                  else {
                    ApiService().getPaymentUrl(User().userId, (res) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PaymentWebView(url: res)),
                              (route) => false);
                    });
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       // builder: (context) => PaymentWebView(url: res)),
                    //         builder: (context) => RentalWidget()),
                    //         (route) => false);
                  }
                }
              }
            }
          });
    }
   on DioException catch (e) {
  print('Dio error: ${e.message}');
  } catch (e) {
  print('General error: $e');
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('l_image.png', 580.w,'תמונת כניסה'),showAppBar: false,);
        }
        return buildContent();
      }),
    );
  }

  buildContent() {
    return Stack(
      children: [
        SingleChildScrollView(
             //reverse: true,
              child: Container(padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(right: 31.w, left: 30.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 100.h,
                          ),
                          CustomText('התחברות',
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                                height: 1),
                          ),
                          SizedBox(height: 29.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isRegister = true;
                                    });
                                  },
                                  child: CustomText('התחבר',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: isRegister ? TextDecoration.underline : TextDecoration.none,
                                        height: 1),
                                  )),
                             // SizedBox(width: 150.w,),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isRegister = false;
                                    });
                                  },
                                  child: CustomText('הירשם',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                        decoration: isRegister ? TextDecoration.none : TextDecoration.underline,
                                        height: 1),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 70.h,
                          ),
                          CustomText(
                              isRegister
                                  ? 'הזן מספר טלפון לקבלת קוד התחברות'
                                  : 'הזן מספר טלפון לקבלת קוד הרשמה',
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  height: 1)),
                          SizedBox(height: 34.h),
                          SizedBox(
                            height: 70.h,
                            child: TextFormField(
                              controller: _phone,
                              keyboardType: TextInputType.number,
                              cursorColor: blackColorApp,
                              decoration: InputDecoration(
                                constraints: BoxConstraints(maxHeight: 48.h),
                                isDense: true,
                                labelText: "מס' נייד",
                                labelStyle: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp,
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
                                  child: Image.asset("assets/icons/Phone.png"),

                                ),
                                prefixIconConstraints: const BoxConstraints(
                                  maxHeight: 26,
                                  minHeight: 26
                                ),
                                prefixIconColor: pinkColorApp,
                                suffixIcon: didSendCode
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 14.w),
                                        child: Image.asset("assets/icons/edit.png"),
                                      )
                                    : null,
                                suffixIconConstraints: const BoxConstraints(
                                    maxHeight: 26,
                                    minHeight: 26
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.normal,
                                  color: blackColorApp),
                              validator: (value) {
                                if (value == null || value.length != 10) {
                                  return 'מספר הטלפון חייב להיות בן 10 ספרות';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Visibility(
                            visible: didSendCode && checkboxValue1,
                            child: SizedBox(
                              height: 71.h,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _code,
                                focusNode: textSecondFocusNode,
                                cursorColor: blackColorApp,
                                decoration: InputDecoration(
                                  constraints: BoxConstraints(maxHeight: 48.h),
                                  isDense: true,
                                  labelText: "הזן סיסמא שהתקבלה",
                                  labelStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    color: blackColorApp,
                                    height: 1,
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
                                    child: Image.asset("assets/icons/Password.png"),
                                  ),
                                  prefixIconConstraints: const BoxConstraints(maxHeight: 26,minHeight: 26),
                                  prefixIconColor: pinkColorApp,
                                ),
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.normal,
                                    color: blackColorApp),
                                validator: (value) {
                                  if (value == null) {
                                    return 'נא הזן קוד';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          Visibility(
                            visible: !didSendCode,
                            child: SizedBox(
                              height: 40.h,
                              child: ListTileTheme(
                                horizontalTitleGap: 1.0,
                                child: CheckboxListTile(
                                  value: checkboxValue1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      checkboxValue1 = value!;
                                    });
                                  },
                                  title: Wrap(
                                    children: [
                                      CustomText(
                                        ' אני מאשר/ת את ',
                                        style: TextStyle(fontSize: 18.sp),
                                      ),
                                      GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => const Terms(
                                                        index: 1,
                                                      ))),
                                          child: CustomText(
                                            'תנאי השימוש',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                decoration: TextDecoration.underline),
                                          )),
                                    ],
                                  ),
                                  checkColor: blackColorApp,
                                  activeColor: Colors.transparent,
                                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                  side: BorderSide(color: blackColorApp, width: 1.5,),
                                ),
                              ),
                            ),
                          ),
                          //SizedBox(height: 81.h,),
                          //Spacer(),
                          Visibility(
                            visible: didSendCode,
                            child: SizedBox(
                              height: 350.h,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          _code.text = '';
                                          getVerificationCode(0);
                                        },
                                        child: CustomText('שלח שוב SMS',
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18.sp,
                                                decoration: TextDecoration.underline,
                                                color: blackColorApp))),
                                    TextButton(
                                        onPressed: () {
                                          _code.text = '';
                                          getVerificationCode(1);
                                        },
                                        child: CustomText(
                                          'שלח שוב שיחה קולית',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18.sp,
                                              decoration: TextDecoration.underline,
                                              color: blackColorApp),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          _code.text = '';
                                          getVerificationCode(2);
                                        },
                                        child: CustomText(
                                          'שלח שוב ווטסאפ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18.sp,
                                              decoration: TextDecoration.underline,
                                              color: blackColorApp),
                                        )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          /*Visibility(
                              visible: !didSendCode,
                              child: SizedBox(
                                height: 340.h,
                              )
                          ),
                            Flexible(
                              fit: FlexFit.loose,
                              child:
                            ),*/
                          ],
                        ),
                      ),
                    ),
                  ),
              )),
        Align(
          alignment: Alignment.bottomCenter,
          child:
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: SizedBox(
              height: 48.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:_phone.text.length<10&&!checkboxValue1?Colors.grey:turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    if(didSendCode && _code.text==''){
                      displayError(context,
                          message: 'יש להכניס קוד אימות',
                          closeButton: true);
                    }
                    else if (!didSendCode) {
                      if (_formKey.currentState!.validate() &&
                          checkboxValue1) {
                        setState(() {});
                        getVerificationCode(0);
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
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ))),
            ),
          ),
        ),
      ],
    );

  }
}