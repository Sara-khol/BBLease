import 'package:bblease/landspace_widget.dart';
import 'package:bblease/models/class_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'license_details.dart';
import 'package:bblease/utils/my_colors.dart' ;

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstName ;
  late TextEditingController _lastName;
  late TextEditingController _name;
  late TextEditingController _tz;

  // TextEditingController _date = TextEditingController(
  //     text: User().birthDate == null
  //         ? intl.DateFormat('dd-mm-yyyy').format(User().birthDate)
  //         : null);
  late TextEditingController _date;

  late TextEditingController _email;
  late TextEditingController _phone;

  String bdate = User().birthDate;
  bool checkboxValue1 = true;
  bool formIsValid = false;
  @override
  void initState() {
    User user= User();
    _firstName = TextEditingController(text: user.firstName.isNotEmpty ? user.firstName : '');
    _lastName = TextEditingController(text: user.lastName.isNotEmpty ? user.lastName : '');
    _name= TextEditingController(text: user.firstName.isNotEmpty ? '${user.firstName} ${user.lastName}' : '');
    _tz = TextEditingController(text: user.tz.isNotEmpty ? user.tz : '');
   // _date = TextEditingController(text: user.birthDate??'');
    _date= TextEditingController(
          text: User().birthDate.isNotEmpty
              ? intl.DateFormat('dd/MM/yyyy').format(intl.DateFormat('yyyy-MM-dd').parse(User().licenseIssDate))
              : '');
    _email = TextEditingController(text:user.email.isNotEmpty?user.email:'' );
    _phone = TextEditingController(text:user.phoneNumber.isNotEmpty?user.phoneNumber:'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:LandSpaceWidget(mainWidget:buildContent(),imageProperties:
      ImageProperties('l_register1.png', 618.w,'תמונת הרשמה שלב 1'),showAppBar: false,)
    );
  }

  buildContent()
  {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            onChanged: () {
             //  setState(() => formIsValid = _formKey.currentState!.validate()),
              final valid = _formKey.currentState!.validate();
            if (valid != formIsValid) {
      setState(() => formIsValid = valid);
      }},
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 31.w, right: 30.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h,),
                  Icon(
                    Icons.account_circle_outlined,
                    color:turquoiseColorApp,
                    size: 60.w,
                    weight: 50,
                  ),
                  SizedBox(height: 8.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'פרטים אישיים',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PLONI',
                            height: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('שם פרטי'),
                    style: TextStyle(color: blackColorApp,fontWeight: FontWeight.w300,fontSize: 18.sp,),
                    controller: _firstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'זהו שדה חובה';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h,),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('שם משפחה'),
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'זהו שדה חובה';
                      }
                      return null;
                    },
                    controller: _lastName,
                  ),
                  SizedBox(height: 12.h,),
                   TextFormField(
                     textInputAction: TextInputAction.next,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('שם לחשבונית (לא חובה)'),
                   //floatingLabelBehavior: FloatingLabelBehavior.auto,
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                  controller: _name,
                  ),
                  SizedBox(height: 12.h,),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('תעודת זהות / דרכון'),
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                    controller: _tz,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 9) {
                        return 'מספר זהות לא תקין';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h,),
                  TextFormField(
                    readOnly: true,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration(
                        'תאריך לידה (מגיל 21 בלבד)',
                        isDate: true),
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                    controller: _date,
                    onTap: () async {
                      DateTime? date = await showDatePicker(
                          locale: const Locale("he", "HE"),
                          context: context,
                          // initialDate: DateTime.now(),
                          initialDate:  DateTime.now().subtract(const Duration(days: 21 * 365)),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now().subtract(const Duration(days: 21 * 365)));
                      if (date != null) {
                        setState(() {
                          _date.text = intl.DateFormat('dd/MM/yyyy').format(date);
                          bdate = intl.DateFormat('yyyy-MM-dd').format(date);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null) return 'זהו שדה חובה';
                      return null;
                    },
                  ),
                  SizedBox(height: 66.h,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    cursorColor: blackColorApp,
                    decoration: getInputDecoration('אימייל', suffixText: '   הכנס אמייל פעיל  '),
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                    controller: _email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (!emailValid) return 'אימיל לא תקין';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h,),
                 TextFormField(
                    keyboardType: TextInputType.number,
                  //  enabled: false,
                    textInputAction: TextInputAction.done,
                    cursorColor: blackColorApp,
                   readOnly: true,
                    decoration: getInputDecoration("מס' נייד", suffixText: '   הכנס נייד זמין  '),
                    style: TextStyle(color: blackColorApp,fontSize: 18.sp,fontWeight: FontWeight.w300,),
                    controller: _phone,
                    validator: (value) {
                      if (value == null || value.length < 10) {
                        return 'מספר לא תקין';
                      }
                      return null;
                    },
                  ),
               //   Container(height: 20,width: double.infinity,color: Colors.tealAccent,),
                  SizedBox(height: 24.h,),
                  ListTileTheme(
                    horizontalTitleGap: 1.0,
                    child: CheckboxListTile(
                      title: Text("מעוניין לקבל מבצעים והטבות",
                          style: TextStyle(
                              height: 1,
                              fontFamily: 'PLONI',
                              fontWeight: FontWeight.normal,
                              fontSize: 18.sp)),
                      value: checkboxValue1,
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValue1 = value!;
                        });
                      },
                      checkColor: blackColorApp,
                      activeColor: Colors.transparent,
                      controlAffinity: ListTileControlAffinity.leading,
                      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      side: BorderSide(
                        color: blackColorApp,
                        width: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height:  70.h),
                  SizedBox(
                    height: 42.h,
                   width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: formIsValid? turquoiseColorApp:Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          User().firstName = _firstName.text;
                          User().lastName = _lastName.text;
                          User().name = _name.text.isNotEmpty ? _name.text : '${_firstName.text} ${_lastName.text}';
                          User().tz = _tz.text;
                          User().birthDate = bdate;
                          User().email = _email.text;
                          //User().phoneNumber = _phone.text;
                          User().getNotification = checkboxValue1;
                          setState(() {});
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const LicenseDetails(index: 1,)));
                          }
                        },
                        child: Text(
                          'הבא',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal),
                        )),
                  ),
                  SizedBox(height: 40.h,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        const AssetImage("assets/icons/CalendarBig.png"),
        color:pinkColorApp,
      )
          : suffixText.isNotEmpty
              ? Text(suffixText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: turquoiseColorApp,
                    height: 1,
                  ))
              : null,
      suffixIconConstraints: !isDate ? const BoxConstraints(maxHeight: 26) : null,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
    );
  }
  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _name.dispose();
    _tz.dispose();
    _date.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }
}

