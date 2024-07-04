
import 'package:bblease/Flow/registration/payment_webView.dart';
import 'package:bblease/landspace_widget.dart';
import 'package:bblease/models/additional_driver.dart';
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

import '../UserInformation/terms_and_conditions.dart';

class LicenseDetails extends StatefulWidget {
  const LicenseDetails({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<LicenseDetails> createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _licenseId ;
  late TextEditingController _expDate   ;
  late TextEditingController _issDate   ;
  late TextEditingController _degree    ;

  String exp = User().licenseExpDate;
  String iss = User().licenseIssDate;

  bool checkboxValue1 = false;

  @override
  void initState() {
    _licenseId = TextEditingController(text: widget.index==1?User().licenseId:'');
    _expDate   = TextEditingController(text: widget.index==1?User().licenseExpDate:'');
    _issDate   = TextEditingController(text: widget.index==1?User().licenseIssDate:'');
    _degree    = TextEditingController(text: widget.index==1?User().licenseDegree:'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: OrientationBuilder(
        builder: (context,orientation) {
          return  orientation==Orientation.landscape?
            LandSpaceWidget( mainWidget: buildContent(),imageProperties: ImageProperties('l_register1.png', 618.w)):
                buildContent();

        }
      ),
    );
  }

  buildContent()
  {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(right: 30.w, left: 31.w),
          child: ListView(
            children: [
              SizedBox(height: 53.h,),
              Visibility(
                visible: widget.index==1,
                child: Icon(
                  Icons.account_circle_outlined,
                  color: turquoiseColorApp,
                  size: 60.w,
                  weight: 100,
                ),
              ),
              SizedBox(height: widget.index==1?8.h:53.h,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'פרטי רשיון נהיגה',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: blackColorApp,
                      fontFamily: 'PLONI',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34.h,),
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
              SizedBox(height: 12),
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
                  else {
                    DateTime now = DateTime.now();
                    DateTime inputDate = intl.DateFormat('dd/MM/yyyy').parse(value);
                    if (inputDate.isBefore(DateTime(now.year, now.month, now.day))) {
                      return 'רישיון לא בתוקף';
                    }
                  }
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
              SizedBox(height: 12,),
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
              SizedBox(height: 12,),
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
              SizedBox(height: 27,),
              ListTileTheme(
                horizontalTitleGap: 1.0,
                child: CheckboxListTile(
                  title: Text(
                    "נהג חדש",
                    style: TextStyle(
                        fontFamily: 'PLONI',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                        color: blackColorApp),
                  ),
                  value: widget.index==1?User().isNewDriver:false,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.index==1?User().isNewDriver = value!:null;
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

              Visibility(
                  visible: widget.index==1,
                  child:  Row(
                    children: [
                      Text(
                        'יש לחתום על ',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Terms(index: 2,))),
                          child: Text(
                            'תנאי ההשכרה',
                            style: TextStyle(
                                color: blackColorApp,
                                fontSize: 18.sp,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  )
                /*checkColor: blackColorApp,
                          activeColor: Colors.transparent,
                          // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          controlAffinity: ListTileControlAffinity.leading,
                          checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          side: BorderSide(
                            color: blackColorApp,
                            width: 1.5,
                          ),
                        ),*/
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
                      print('submit pressed');
                      print('signature ${User().signature!=null}');
                      print(widget.index);

                      if (User().signature==null&&widget.index==1) {
                        print('signature is empty');
                        displayError(context,
                            message: 'יש לחתום על תנאי השכרה',
                            closeButton: true);
                      }
                      else /*if (_formKey.currentState!.validate())*/ {
                        print('signature is not empty');
                        if(widget.index==1){
                          User().licenseId = _licenseId.text;
                          User().licenseDegree = _degree.text;
                          User().licenseIssDate = iss.toString();
                          User().licenseExpDate = exp;
                          await registerUser();
                        }
                        if(widget.index==2){
                          User().additionalDriver.licenseId = _licenseId.text;
                          User().additionalDriver.licenseDegree = _degree.text;
                          User().additionalDriver.licenseIssDate = iss.toString();
                          User().additionalDriver.licenseExpDate = exp;
                        }
                      }
                    },
                    child: Text(widget.index==1?'הבא':'אשר פרטים',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.normal))
                ),
              ),
              SizedBox(height: 40.h,),
            ],
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
                    index: 1,
                      )),
              (route) => false);
        });

      }
    });
  }

  Future addDriverSucceed() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
          height: 180.h,
          decoration: const BoxDecoration(color:Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(children: [
            SizedBox(height: 25.h),
            // const Spacer(),
            Center(
              child: Text('הוספת נהג',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height:1,
                    color: pinkColorApp,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            //SizedBox(height: 20.h),
            SizedBox(
              height: 42.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    rent.additionalDriver=User().additionalDriver;
                    User().additionalDriver=AdditionalDriver();
                  },
                  child: Text(
                    'שמור והמשך בנסיעה',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal),
                  )),
            ),
            SizedBox(height: 22.h)
          ])),
      barrierColor: Colors.black12.withOpacity(0.1),
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    );
  }
}
