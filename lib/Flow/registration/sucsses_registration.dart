import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/class_user.dart';
import 'registration_main.dart';
import 'welcome.dart';

class SucssesRegistrationForm extends StatefulWidget {
  const SucssesRegistrationForm({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _SucssesRegistrationForm();
}

class _SucssesRegistrationForm extends State<SucssesRegistrationForm>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
         // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 160.h),
            Image.asset('assets/images/sucreg.png'),
            Text("היי ${User().firstName}!",style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700,fontFamily: 'PLONI',color:Color.fromRGBO(15, 21, 17, 1),),),
            Text("הרשמתך בוצעה בהצלחה",style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700,fontFamily: 'PLONI',color:Color.fromRGBO(15, 21, 17, 1),),),
            Text("כעת ניתן להזמין רכב על שמך!",style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700,fontFamily: 'PLONI',color:Color.fromRGBO(15, 21, 17, 1),),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
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
                        child: const Text('לעבור לביצוע הזמנה',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
                  ),

            SizedBox(height: 12.h),

                  SizedBox(
                    width: 332.w,
                    height: 42.h,
                    child: FloatingActionButton.extended(
                      label: Text('צא מהאפליקציה',style: TextStyle(letterSpacing: 0.1,fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),),
                      heroTag: "btn2",
                      backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                      icon: Icon(
                        Icons.exit_to_app_outlined,
                        fill: 0,
                        color: Colors.white,
                      ), onPressed: () {  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WelcomeForm())); },
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}



