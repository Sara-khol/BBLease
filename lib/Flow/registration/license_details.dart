import 'package:bblease/models/class_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'sucsses_registration.dart';


class LicenseDetails extends StatefulWidget {
  const LicenseDetails({Key? key}) : super(key: key);

  @override
  State<LicenseDetails> createState() => _LicenseDetailsState();
}

class _LicenseDetailsState extends State<LicenseDetails> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _licenseId=TextEditingController(text: User().licenseId);
  TextEditingController _expDate=TextEditingController(text: intl.DateFormat('dd-mm-yyyy').format(User().licenseExpDate));
  TextEditingController _issDate=TextEditingController(text: intl.DateFormat('dd-mm-yyyy').format(User().licenseIssDate));
  TextEditingController _degree=TextEditingController(text: User().licenseDegree);

  late DateTime exp;
  late DateTime iss;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(right: 30.w,left: 30.w),
            child: Column(
              children: [
                SizedBox(height: 50.h,),
                const Icon(Icons.account_circle_outlined,color: Color.fromRGBO(0, 222, 222, 1),size: 60,weight: 100,),
                SizedBox(height: 10.h,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('פרטי רשיון נהיגה',style: TextStyle(
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
                    labelText: "מספר רשיון נהיגה",
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
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color:Colors.redAccent,
                    ),
                    ),
                    contentPadding:  EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                  controller: _licenseId,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                ),
                SizedBox(height: 16.h,),
                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: "תוקף",
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
                      contentPadding:  EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                    //  suffixIcon: Icon(Icons.calendar_today_outlined,color: Color.fromRGBO(251, 37, 118, 1),)
                      suffixIcon:   Image.asset('assets/images/Calendar.png', width: 18.w,),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                  controller: _expDate,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  onTap: () async {
                    DateTime? date= await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100));
                    if(date!=null)
                      setState(() {
                        _expDate.text=intl.DateFormat('dd.MM.yyyy').format(date);
                        exp=date;
                      });
                  },

                ),
                SizedBox(height: 16.h,),

                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                      isDense: true,
                      labelText: "תאריך הנפקה",
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
                      contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                      suffixIcon: Icon(Icons.calendar_today_outlined,color: Color.fromRGBO(251, 37, 118, 1),)

                  ),
                  style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                  controller: _issDate,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },
                  onTap: () async {
                    DateTime? date= await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());
                    if(date!=null)
                      setState(() {
                        _issDate.text=intl.DateFormat('dd.MM.yyyy').format(date);
                        iss=date!;
                      });

                  },

                ),
                SizedBox(height: 16.h,),

                TextFormField(
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "דרגת רשיון",
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
                      color: Colors.redAccent,
                    ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color:Colors.redAccent,
                    ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                  ),
                  style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                  controller: _degree,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'זהו שדה חובה';
                  },

                ),
                SizedBox(height: 60.h,),
                ListTileTheme(
                  horizontalTitleGap: 1.0,
                  child: CheckboxListTile(
                    title: Text("נהג חדש",style: TextStyle(fontFamily: 'PLONI',fontSize: 22.h,color: Color.fromRGBO(15, 21, 17, 1)),),
                    value: User().isNewDriver,
                    onChanged:(bool? value) {
                      User().isNewDriver = value!;
                    },
                    checkColor:  Color.fromRGBO(15, 21, 17, 1),
                    activeColor: Colors.transparent,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)
                    ),
                    side: BorderSide(color:Color.fromRGBO(15, 21, 17, 1),width: 1.5,),
                  ),
                ),
                Container(
                  height: 48.h,
                  width: 250.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()) {
                          User().firstName=_licenseId.text;
                          User().licenseDegree=_degree.text;
                          User().licenseIssDate=iss;
                          User().licenseExpDate=exp;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SucssesRegistrationForm()));
                        }
                      },
                      child: const Text('הבא',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
