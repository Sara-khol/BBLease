import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'license_back.dart';
import 'license_front.dart';
import 'registration_main.dart';

class TelToRegistrationForm extends StatefulWidget {
  const TelToRegistrationForm({Key? key}) : super(key: key);


  @override
  State<TelToRegistrationForm> createState() => _TelToRegistrationFormState();
}

class _TelToRegistrationFormState extends State<TelToRegistrationForm>{
  bool checkboxValue1 = false;

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
              Text("הזן מספר טלפון להרשמה",style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600,fontFamily: 'PLONI',color:Color.fromRGBO(15, 21, 17, 1),),),
              SizedBox(height: 50.h,),
              Form(child: TextFormField(
                cursorColor: Color.fromRGBO(15, 17, 21, 1),
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "מס' נייד",
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0,),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 20,left: 14),
                    child:  Image.asset('assets/images/Phone.png', width: 24.w,),
                  ),
                  prefixIconConstraints: BoxConstraints(maxHeight: 26,),
                  prefixIconColor: Color.fromRGBO(251, 37, 118, 1),
                ),
                style: const TextStyle(fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color:  Color.fromRGBO(15, 17, 21, 1),
                  fontFamily: 'PLONI', ),

               // controller: _phone,
                validator: (value) {
                  if(value==null || value.length<10)
                    return 'מספר לא תקין';
                },
               // onEditingComplete: () => User().phoneNumber=_phone.text,

              ),
                
              ),
              ListTileTheme(
                horizontalTitleGap: 1.0,
                child: CheckboxListTile(
                  //contentPadding: EdgeInsets.zero,
                  value: checkboxValue1,
                  onChanged:(bool? value) {
                    setState(() {
                      checkboxValue1 = value!;
                    });
                  },
                  title: RichText(
                    text: TextSpan(
                      style: TextStyle( fontSize: 18.sp, fontWeight: FontWeight.w300,fontFamily: 'PLONI',color:Color.fromRGBO(15, 21, 17, 1),),
                      children: <TextSpan>[
                        TextSpan(text: 'אני מאשר/ת את '),
                        TextSpan(
                            text: 'תנאי השימוש',
                            style: TextStyle( decoration: TextDecoration.underline,  ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Terms of Service"');
                              }),

                      ],
                    ),
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

              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child:   Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      height: 42.h,
                      width: 332.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: (){

                          },
                          child: const Text('אישור',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
                    ),
                  ),

                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}






