import 'package:bblease/registration/registration_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'registration/face_scanning.dart';
import 'registration/license_details.dart';
import 'registration/license_front.dart';
import 'registration/personal_details_form.dart';
import 'registration/sucsses_registration.dart';
import 'registration/tel_to_registration.dart';
import 'registration/welcome.dart';
import 'screen/search_car.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'PLONI',
        scaffoldBackgroundColor: Colors.white,
       // primarySwatch: Color.fromARGB(15, 21, 17, 1),
      ),
      home: const WelcomeForm(),
    );
      });
  }
}

