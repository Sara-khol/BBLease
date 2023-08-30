import 'package:bblease/class_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;


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
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('פרטים אישיים'),
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'שם פרטי',
                    hintStyle: TextStyle(color: Colors.blueAccent )
                  ),
                  style: const TextStyle(color: Colors.blueAccent),
                  controller: _firstName,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  onEditingComplete: () => User().firstName=_firstName.text,

                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),
                      hintText: 'שם משפחה'
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  controller: _lastName,
                  onEditingComplete: () => User().lastName=_lastName.text,

                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),

                      hintText: 'שם לחשבונית (לא חובה)'
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _name,
                  onEditingComplete: () => User().name=_name.text,

                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),

                      hintText: 'תעודת זהות/מספר דרכון'
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _id,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length!=9)
                      return 'מספר זהות לא תקין';
                  },
                  onEditingComplete: () => User().id=_id.text,

                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),

                      hintText: 'תאריך לידה(מגיל 21)'
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
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),

                      hintText: 'אימייל'
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
                SizedBox(height: 8.h,),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.blueAccent ),

                      hintText: 'מס נייד'
                  ),
                  style: const TextStyle(color: Colors.blueAccent),

                  controller: _phone,
                  validator: (value) {
                    if(value==null || value.length<10)
                      return 'מספר לא תקין';
                  },
                  onEditingComplete: () => User().phoneNumber=_phone.text,

                ),
                SizedBox(height: 8.h,),
                Switch(
                    value: User().getNotification,
                    activeColor: Colors.blueAccent,
                    onChanged: (value) => User().getNotification=value),

                Container(
                  height: 56.h,
                  width: 332.w,
                  child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PersonalDetailsForm()));
                        }
                      },
                      child: const Text('הבא')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
