import 'package:bblease/models/class_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'license_details.dart';


class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {



  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName=TextEditingController(text: User().firstName.isNotEmpty?User().firstName:'');
  TextEditingController _lastName=TextEditingController(text: User().lastName.isNotEmpty?User().lastName:'');
  TextEditingController _name=TextEditingController(text: User().firstName.isNotEmpty?User().firstName+ ''+User().lastName:'');
  TextEditingController _id=TextEditingController(text: User().id.isNotEmpty?User().id:'');
  TextEditingController _date=TextEditingController(text: User().birthDate==null?intl.DateFormat('dd-mm-yyyy').format(User().birthDate):null);
  TextEditingController _email=TextEditingController();
  TextEditingController _phone=TextEditingController();
  TextEditingController _password=TextEditingController();
  late DateTime bdate;

  bool checkboxValue1 = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w,right: 30.w),
                child: Column(
                  children: [
                    SizedBox(height: 50.h,),
                    Icon(Icons.account_circle_outlined,color: Color.fromRGBO(0, 222, 222, 1),size: 60.sp,weight: 50,),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Text('פרטים אישיים',style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI',
                        ),),
                      ],
                    ),
                    SizedBox(height: 50.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                        isDense: true,
                          labelText: "שם פרטי",
                          labelStyle:  TextStyle(fontSize: 22.sp,
                            fontWeight: FontWeight.w300,
                            color:  Color.fromRGBO(15, 17, 21, 1),
                            fontFamily: 'PLONI', ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                           ),
                         ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                      ),
                      style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                      controller: _firstName,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'זהו שדה חובה';
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                          isDense: true,
                        labelText: "שם משפחה",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                      ),
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'זהו שדה חובה';
                      },
                      controller: _lastName,
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                          isDense: true,
                        labelText: "שם לחשבונית (לא חובה)",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                      ),
                      style: const TextStyle(color: Colors.black),
                      controller: _name,
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                          isDense: true,
                        labelText: "תעודת זהות / דרכון",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                      ),
                      style: const TextStyle(color: Colors.black),
                      controller: _id,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length!=9)
                          return 'מספר זהות לא תקין';
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                          isDense: true,
                        labelText: "תאריך לידה (מגיל 21 בלבד)",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                            color: Color.fromRGBO(15, 17, 21, 1),
                          ),
                          ),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                            color: Color.fromRGBO(15, 17, 21, 1),
                          ),
                          ),
                          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                            color: Color.fromRGBO(15, 17, 21, 1),
                          ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                            color:Color.fromRGBO(15, 17, 21, 1),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 20.w),
                          suffixIcon: Icon(Icons.calendar_today_outlined,color: Color.fromRGBO(251, 37, 118, 1),)

                      ),
                      style: const TextStyle(color: Colors.black),
                      controller: _date,
                      onTap: () async {
                        DateTime? date= await showDatePicker(context: context,
                            // initialDate: DateTime.now(),
                            initialDate: DateTime(DateTime.now().year-21),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(DateTime.now().year-21));
                        if(date!=null)
                          setState(() {
                            _date.text=intl.DateFormat('dd.MM.yyyy').format(date);
                            bdate=date;
                          });
                      },
                      validator: (value) {
                        if(value==null)
                          return 'זהו שדה חובה';
                      },
                    ),
                    SizedBox(height: 66.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "אימייל",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                        suffixIcon: Text("   הכנס אמייל פעיל  " , style:TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(4, 174, 185, 1),
                          fontFamily: 'PLONI',
                        )
                          ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 26),
                      ),
                      style: const TextStyle(color: Colors.black),
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                          if(!emailValid) return 'אימיל לא תקין';
                        }
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "מס' נייד",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                        suffixIcon: Text("   הכנס נייד זמין  " , style:TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(4, 174, 185, 1),
                          fontFamily: 'PLONI',
                        )
                        ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 26),
                      ),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w300,
                        color:  Color.fromRGBO(15, 17, 21, 1),
                        fontFamily: 'PLONI', ),
                      controller: _phone,
                      validator: (value) {
                        if(value==null || value.length<10)
                          return 'מספר לא תקין';
                      },
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(
                      obscureText: true,
                      cursorColor: Color.fromRGBO(15, 17, 21, 1),
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: "סיסמה",
                        labelStyle:  TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(15, 17, 21, 1),
                          fontFamily: 'PLONI', ),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Color.fromRGBO(15, 17, 21, 1),
                        ),
                        ),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color: Colors.red,
                        ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                          color:Colors.red,
                        ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                        suffixIcon: Text("   הכנס סיסמה  " , style:TextStyle(fontSize: 22.sp,
                          fontWeight: FontWeight.w300,
                          color:  Color.fromRGBO(4, 174, 185, 1),
                          fontFamily: 'PLONI',
                        )
                        ),
                        suffixIconConstraints: BoxConstraints(maxHeight: 26),
                      ),
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w300,
                        color:  Color.fromRGBO(15, 17, 21, 1),
                        fontFamily: 'PLONI', ),
                      controller: _password,
                      validator: (value) {
                        RegExp regex = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (value==null||regex.hasMatch(value)) {
                            return 'סיסמה לא תקינה';
                          }
                          else {
                            return null;
                          }
                      },
                    ),
                    Text('סיסמה תקינה כוללת אות אחת לפחות, ספרה אחת לפחות, ותו מיוחד אחד לפחות, באורך 8 תווים לפחות.',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w300),),
                    SizedBox(height: 5.h,),
                    ListTileTheme(
                      horizontalTitleGap: 1.0,
                      child: CheckboxListTile(
                        title: Text("מעוניין לקבל מבצעים והטבות",
                          style: TextStyle(fontFamily: 'PLONI',fontSize: 22.sp.h,color: Color.fromRGBO(15, 21, 17, 1)),
                        ),
                        value: checkboxValue1,
                        onChanged:(bool? value) {
                          setState(() {
                            checkboxValue1 = value!;
                          });
                        },
                        checkColor:  Color.fromRGBO(15, 21, 17, 1),
                        activeColor: Colors.transparent,
                        controlAffinity: ListTileControlAffinity.leading,
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        side: BorderSide(color:Color.fromRGBO(15, 21, 17, 1),width: 1.5,),
                      ),
                    ),
                    Container(
                      height: 48.h,
                      width: 332.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                          onPressed: (){
                          setState(() {});
                          User().firstName=_firstName.text;
                          User().lastName=_lastName.text;
                          User().name=_name.text;
                          User().id=_id.text;
                          User().birthDate=bdate;
                          User().email=_email.text;
                          User().phoneNumber=_phone.text;
                          User().password=_password.text;
                          User().getNotification= checkboxValue1;
                            if(_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LicenseDetails()));
                            }
                          },
                          child: Text('הבא',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
                    ),
                    SizedBox(height: 40.h,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
