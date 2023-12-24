import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:bblease/Flow/terms_and_conditions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/class_user.dart';
import '../../services/api_service.dart';
import '../Rental/map.dart';


class TelToRegistrationForm extends StatefulWidget {
  const TelToRegistrationForm({Key? key}) : super(key: key);

  @override
  State<TelToRegistrationForm> createState() => _TelToRegistrationFormState();
}

class _TelToRegistrationFormState extends State<TelToRegistrationForm>{
  bool checkboxValue1 = false;
  TextEditingController _phone=TextEditingController();
  TextEditingController _code=TextEditingController();
  bool sent=false;
  int step=0;


  @override
  void initState(){
    super.initState();
  }
  late int status;
  //late int vcode;


  getVerificationCode()  async{
    //TODO: צריך שיחזור סטטוס ומשתנה אופציונאלי קוד אימות.
    //TODO: אחר כך לבצע קריאה נוספת לאימות קוד שהמשתמש הכניס.
    //TODO: אחרי שהשלב עבר בהצלחה, והקוד שנכנת תקין, לעשות: mySharedPreferences.updateLastUsage();

   await ApiService().getVerificationCode('0533117988', (value){
     status=value['status'];
     if(value['customer']!=null){
      //TODO: save the data to User()
       User.fromJson(value['customer']);
      //value[1].map<User>((entry) => (User.fromJson(entry))).toList();
     }
     step=1;
     setState(() {});
   });
  }

  verifyCode() async{
    await ApiService().CodeVerification('0583214497', '1234', (carJson) {

    });
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
              Text("הזן מספר טלפון להרשמה",style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600,color:colors.blackColorApp,),),
              SizedBox(height: 50.h,),
              TextFormField(
                controller: _phone,
                cursorColor: colors.blackColorApp,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "מס' נייד",
                  labelStyle:  TextStyle(fontSize: 22.sp,
                    fontWeight: FontWeight.w300,
                    color:  colors.blackColorApp,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                    color: colors.blackColorApp,
                  ),
                  ),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                    color: colors.blackColorApp,
                  ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0,),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 20.w,left: 14.w),
                    child:  Icon(Icons.phone,size: 23.sp,color: colors.pinkColorApp)//Image.asset('assets/images/Phone.png', width: 24.w,),
                  ),
                  prefixIconConstraints: BoxConstraints(maxHeight: 26,),
                  prefixIconColor: colors.pinkColorApp,
                ),
                style:  TextStyle(fontSize: 22.sp,
                  fontWeight: FontWeight.w300,
                  color:  colors.blackColorApp),
                validator: (value) {
                  if(value==null || value.length<10)
                    return 'מספר הטלפון חייב להיות בן 10 ספרות';
                },
              ),
              SizedBox(height: 15.h,),
              Visibility(
                visible: sent&&checkboxValue1,
                child: TextFormField(
                  controller: _code,
                  cursorColor: colors.blackColorApp,
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "הזן סיסמא שהתקבלה",
                    labelStyle:  TextStyle(fontSize: 22.sp,
                      fontWeight: FontWeight.w300,
                      color:  colors.blackColorApp,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: colors.blackColorApp,
                    ),
                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0,), borderSide: BorderSide(
                      color: colors.blackColorApp,
                    ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0,),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(right: 20.w,left: 14.w),
                      child: Icon(Icons.password,size: 23.sp,color: colors.pinkColorApp,) //Image.asset('assets/images/Phone.png', width: 24.w,),
                    ),
                    prefixIconConstraints: BoxConstraints(maxHeight: 26,),
                    prefixIconColor: colors.pinkColorApp,
                  ),
                  style:  TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w300,color:  colors.blackColorApp),
                  validator: (value) {
                    if(value==null || value.length<4)
                      return 'קוד שגוי';
                  },
              ),
                ),
              Visibility(
                visible: !sent,
                child: ListTileTheme(
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
                    checkColor:  colors.blackColorApp,
                    activeColor: Colors.transparent,
                    // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    controlAffinity: ListTileControlAffinity.leading,
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    side: BorderSide(color:colors.blackColorApp,width: 1.5,),
                  ),
                ),
              ),
              Spacer(),
              Visibility(
                visible: sent,
                child: Column(
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
              ),
              Padding(
                padding:  EdgeInsets.only(bottom: 40.h),
                child: Container(
                  height: 48.h,
                  width: 332.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colors.turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: (){
                        if(step==0&&checkboxValue1==true) {
                          sent = true;
                          setState(() {});
                          getVerificationCode();
                        }
                        if(step==1&&sent==true)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => RentalWidget(),));
                        }

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






