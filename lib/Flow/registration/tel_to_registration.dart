import 'package:bblease/Flow/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TelToRegistrationForm extends StatefulWidget {
  const TelToRegistrationForm({Key? key}) : super(key: key);

  @override
  State<TelToRegistrationForm> createState() => _TelToRegistrationFormState();
}

class _TelToRegistrationFormState extends State<TelToRegistrationForm>{
  bool checkboxValue1 = false;
  TextEditingController _phone=TextEditingController();
  TextEditingController _code=TextEditingController();
  bool flag=false;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(right: 30.w,left: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 121.h,),
              Text("הזן מספר טלפון להרשמה",style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600,color:Color.fromRGBO(15, 21, 17, 1),),),
              SizedBox(height: 50.h,),
              Form(
                child: TextFormField(
                  controller: _phone,
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "מס' נייד",
                    labelStyle:  TextStyle(fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(15, 17, 21, 1),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0,),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 20.w,left: 14.w),
                      child:  Icon(Icons.phone,size: 23.sp,color: Color(0xFFFF2D81))//Image.asset('assets/images/Phone.png', width: 24.w,),
                    ),
                    prefixIconConstraints: BoxConstraints(maxHeight: 26,),
                    prefixIconColor: Color.fromRGBO(251, 37, 118, 1),
                  ),
                  style:  TextStyle(fontSize: 22.sp,
                    fontWeight: FontWeight.w300,
                    color:  Color.fromRGBO(15, 17, 21, 1)),
                  validator: (value) {
                    if(value==null || value.length<10)
                      return 'מספר הטלפון חייב להיות בן 10 ספרות';
                  },
                ),
              ),
              SizedBox(height: 15.h,),
              if(flag&&checkboxValue1)Form(
                child: TextFormField(
                  controller: _code,
                  cursorColor: Color.fromRGBO(15, 17, 21, 1),
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "הזן סיסמא שהתקבלה",
                    labelStyle:  TextStyle(fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(15, 17, 21, 1),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: Color.fromRGBO(15, 17, 21, 1),
                    ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0,),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 20.w,left: 14.w),
                      child: Icon(Icons.password,size: 23.sp,color: Color(0xFFFF2D81),) //Image.asset('assets/images/Phone.png', width: 24.w,),
                    ),
                    prefixIconConstraints: BoxConstraints(maxHeight: 26,),
                    prefixIconColor: Color.fromRGBO(251, 37, 118, 1),
                  ),
                  style:  TextStyle(fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color:  Color.fromRGBO(15, 17, 21, 1)),
                  validator: (value) {
                    if(value==null || value.length<10)
                      return 'קוד שגוי';
                  },
                ),
              ),
              if(!flag)ListTileTheme(
                horizontalTitleGap: 1.0,
                child: CheckboxListTile(
                  value: checkboxValue1,
                  onChanged:(bool? value) {
                    setState(() {
                      checkboxValue1 = value!;
                    });
                  },
                  title:
                  Row(
                    children: [
                      Text( 'אני מאשר/ת את '),
                      GestureDetector(
                        onTap:() =>  Navigator.push(context, MaterialPageRoute(builder: (context) => const Terms())),
                        child: Text ('תנאי השימוש',style: TextStyle( decoration: TextDecoration.underline),)
                      ),
                    ],
                  ),
                  checkColor:  Color.fromRGBO(15, 21, 17, 1),
                  activeColor: Colors.transparent,
                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  side: BorderSide(color:Color.fromRGBO(15, 21, 17, 1),width: 1.5,),
                ),
              ),
              Spacer(),
              if(flag)Column(
                children: [
                  TextButton(
                    onPressed: () {
                    },
                      child: Text('שלח שוב SMS',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22.sp,decoration: TextDecoration.underline,color: Colors.black),)
                  ),
                  TextButton(
                      onPressed: () {
                      },
                      child: Text('שלח שוב שיחה קולית',style: TextStyle(fontWeight: FontWeight.w300,fontSize: 22.sp,decoration: TextDecoration.underline,color: Colors.black),)
                  ),
                  SizedBox(height: 100.h,),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: 40.h),
                child: Container(
                  height: 48.h,
                  width: 332.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: (){
                        if(checkboxValue1==true)
                        flag=true;
                        setState(() { });
                        //TODO: send verification code from server.
                        },
                      child: Text('אישור',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






