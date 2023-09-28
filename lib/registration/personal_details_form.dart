import 'package:bblease/class_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../design models/TextFormFieldClass.dart';
import 'license_details.dart';
import 'registration_main.dart';


class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsForm> createState() => _PersonalDetailsFormState();
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName=TextEditingController();
  TextEditingController _lastName=TextEditingController();
  TextEditingController _name=TextEditingController();
  TextEditingController _id=TextEditingController();
  TextEditingController _date=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _phone=TextEditingController();
  late DateTime bdate;

  bool checkboxValue1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 30.w,left: 30.w),
            child: ListView(
              shrinkWrap: true,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h,),
                const Icon(Icons.account_circle_outlined,color: Color.fromRGBO(0, 222, 222, 1),size: 60,weight: 100,),
                SizedBox(height: 10.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('פרטים אישיים',style: TextStyle(
                      fontSize: 24,
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
                      labelStyle:  TextStyle(fontSize: 18,
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
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color:Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                   /* hintStyle: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(15, 17, 21, 1),
                      fontFamily: 'PLONI', ),*/

                  ),
                  style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                  controller: _firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  onEditingComplete: () => User().firstName=_firstName.text,
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                    labelText: "שם משפחה",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                  ),
                  style: const TextStyle(color: Colors.red),

                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  controller: _lastName,
                  onEditingComplete: () => User().lastName=_lastName.text,

                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                    labelText: "שם לחשבונית (לא חובה)",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _name,
                  onEditingComplete: () => User().name=_name.text,

                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                    labelText: "תעודת זהות/ מספר דרכון",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _id,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length!=9)
                      return 'מספר זהות לא תקין';
                  },
                  onEditingComplete: () => User().id=_id.text,

                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                    labelText: "תאריך לידה (מגיל 21)",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
                      suffixIcon: Icon(Icons.calendar_today_outlined,color: Color.fromRGBO(251, 37, 118, 1),)

                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _date,
                  onTap: () async {
                    DateTime? date= await showDatePicker(context: context,
                        // initialDate: DateTime.now(),
                        initialDate: DateTime(DateTime.now().year-21),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(DateTime.now().year-21));
                    if(date!=null)
                      setState(() {
                        _date.text=intl.DateFormat('dd-mm-yyyy').format(date);
                        bdate=date;
                      });
                  },
                  onEditingComplete: () => User().birthDate=bdate,

                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "אימייל",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                    suffixIcon: Text("   הכנס אמייל פעיל  " , style:TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(4, 174, 185, 1),
                      fontFamily: 'PLONI',
                    )
                      ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 26),
                  ),
                  style: const TextStyle(color: Colors.blueAccent),
                  controller: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                      if(!emailValid) return 'אימיל לא תקין';
                    }
                  },
                  onEditingComplete: () => User().email=_email.text,
                ),
                SizedBox(height: 12.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "מס' נייד",
                    labelStyle:  TextStyle(fontSize: 18,
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                    suffixIcon: Text("   הכנס נייד זמין  " , style:TextStyle(fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(4, 174, 185, 1),
                      fontFamily: 'PLONI',
                    )
                    ),
                    suffixIconConstraints: BoxConstraints(maxHeight: 26),
                  ),
                  style: const TextStyle(fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color:  Color.fromRGBO(15, 17, 21, 1),
                    fontFamily: 'PLONI', ),

                  controller: _phone,
                  validator: (value) {
                    if(value==null || value.length<10)
                      return 'מספר לא תקין';
                  },
                  onEditingComplete: () => User().phoneNumber=_phone.text,

                ),
                SizedBox(height: 12.h,),
               // TextFormFieldClass(),
              /*  Switch(
                    value: User().getNotification,
                    activeColor: Colors.blueAccent,
                    onChanged: (value) => User().getNotification= value),*/
                ListTileTheme(
                  horizontalTitleGap: 1.0,
                  child: CheckboxListTile(
                    //contentPadding: EdgeInsets.zero,
                    title: Text("מעוניין לקבל מבצעים והטבות",style: TextStyle(fontFamily: 'PLONI',fontSize: 18.h,color: Color.fromRGBO(15, 21, 17, 1)),),

                    value: checkboxValue1,
                    onChanged:(bool? value) {
                      setState(() {
                        checkboxValue1 = value!;
                      });
                    },
                    checkColor:  Color.fromRGBO(15, 21, 17, 1),
                    activeColor: Colors.transparent,
                   // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(color:Color.fromRGBO(15, 21, 17, 1),width: 1.5,),
                  ),
                ),
                Expanded(child: Container()),
            Container(
              height: 42.h,
              width: 250.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                  onPressed: (){
                  // האימות בהערה רק לצורך ההדגמה
                    if(_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LicenseDetails()));
                    }
                  },
                  child: const Text('הבא',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
