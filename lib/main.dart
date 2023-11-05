
import 'package:bblease/Flow/Rental/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Flow/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  MaterialStateProperty<Color?> _customColor() {
    return MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF00DEDE);  // Return this color when the date is selected
        }
        return Color(0xFF00DEDE);  // Otherwise, return this color
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (BuildContext context, Widget? child){
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
       fontFamily: 'PLONI',
       datePickerTheme: DatePickerThemeData(
           backgroundColor: Colors.white,
           elevation: 2,
           headerBackgroundColor: Colors.white,
         todayBackgroundColor: _customColor(),
         rangeSelectionBackgroundColor: Colors.cyan[100],

       )
       // primarySwatch: Color.fromARGB(15, 21, 17, 1),
      ),
      home: const WelcomeForm(),
    );
      });
  }
}

