import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/car.dart';
import '../services/api_service.dart';
import 'license_back.dart';
import 'license_front.dart';
import 'registration_main.dart';

class WelcomeForm extends StatefulWidget {
  const WelcomeForm({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _WelcomeFormState();
  }

class _WelcomeFormState extends State<WelcomeForm>{
  @override
  /*void initState() {
    ApiService().getAllCars((car){
      List<Car> listCars= json.decode(car
          .map((data) => Car.fromJson(data))
          .toList();
    });

    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           // SizedBox(height: 56.h),
            Text("Welcome to Bibilease",style: TextStyle(color: Color.fromRGBO(251, 37, 118, 1),fontWeight: FontWeight.w700,fontSize: 26.sp,fontFamily: 'PLONI',),),
            SizedBox(height: 40.h),
            Image.asset('assets/images/BB.png',width: 393.w, height: 519.h,fit: BoxFit.cover, ),
            SizedBox(height: 60.h),
            Container(
              height: 42.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),
                  onPressed: (){

                  },
                  child: const Text('צפו בסרטון ההדרכה שלנו',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 42.h,
              width: 332.w,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(251, 37, 118, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0.0,
                  ),

                  onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LicenseFront()));
                  },
                  child: const Text('הבא',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,fontFamily: 'PLONI'),)),
            ),
          ],
        ),
      ),

   );
  }
}



