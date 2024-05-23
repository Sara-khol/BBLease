import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UseInstructions extends StatelessWidget {
  const UseInstructions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 30,
            top: 770,
            child: Container(
              width: 332,
              height: 42,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 332,
                      height: 42,
                      decoration: ShapeDecoration(
                        color: turquoiseColorApp,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 121,
                    top: 12,
                    child: Text(
                      'שמור שינויים',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.normal,
                        height: 0.06,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 136,
            top: 121,
            child: Text(
              'סרטון הדרכה',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackColorApp,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
                height: 0.05,
              ),
            ),
          ),
          Positioned(
            left: 149,
            top: 184,
            child: Text(
              'איך זה עובד?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackColorApp,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                height: 0.07,
              ),
            ),
          ),
          Positioned(
            left: 103,
            top: 458,
            child: Text(
              'יותר פשוט ממה שחשבתם',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blackColorApp,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                height: 0.07,
              ),
            ),
          ),
          Positioned(
            left: 219,
            top: 511,
            child: Container(
              width: 107,
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    left: 83,
                    top: 0,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: turquoiseColorApp,
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 18,
                    child: Text(
                      'בודקים את הרכב\nלפני החזרה',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 59,
            top: 511,
            child: Container(
              width: 106,
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    left: 76,
                    top: 0,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: turquoiseColorApp,
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 18,
                    child: Text(
                      'מחזירים לנקודת\nהמוצא',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 236,
            top: 597,
            child: Container(
              width: 93,
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    left: 63,
                    top: 0,
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: turquoiseColorApp,
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 18,
                    child: Text(
                      'בלה בלה בלה\nבלה בלה בלה',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 71,
            top: 597,
            child: Container(
              width: 94,
              height: 66,
              child: Stack(
                children: [
                  Positioned(
                    left: 63,
                    top: 0,
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: turquoiseColorApp,
                        fontSize: 60.sp,
                        fontWeight: FontWeight.bold,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 18,
                    child: Text(
                      'בלה בלה בלה\nבלה בלה בלה',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: blackColorApp,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.normal,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: 215,
            child: Container(
              width: 331,
              height: 188,
              decoration: ShapeDecoration(
                color: Color(0xFFF6F6F6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                shadows: [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: 370,
            top: 59,
            child: Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-3.14),
              child: BackButton(
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

        ],
      ),
    );
  }
}
