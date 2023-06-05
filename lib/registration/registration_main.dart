import 'package:bblease/registration/face_scanning.dart';
import 'package:bblease/registration/license_back.dart';
import 'package:bblease/registration/license_front.dart';
import 'package:bblease/registration/personal_details_form.dart';
import 'package:bblease/registration/text_recognition.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

List<Widget> regProgress=[LicenseFront(),];

class Registration extends StatefulWidget {
  const Registration({super.key});

  static RegistrationState? of(BuildContext context) =>
      context.findAncestorStateOfType<RegistrationState>();

  @override
  State<Registration> createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {

  XFile? front;
  XFile? back;
  XFile? face;
  List<XFile?> regImages = List<XFile?>.filled(3, null);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 260.h),
            Image.asset('assets/icons/Vector.png',width: 159.w,),
            SizedBox(height: 50.h,),
            Container(
              width: 225.w,
              child: Text(
                'לתהליך הרישום,עליך להכין רשיון וכרטיס אשראי על שמך בלבד!',
                style: TextStyle(color: Colors.blueAccent,fontSize: 20.sp),
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 240.h,),
            Container(
              height: 56.h,
              width: 332.w,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                child: Text('הבא', style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w700)),
                onPressed: () {
                  print('pressed');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PersonalDetailsForm()),
                  );
                },
              ),
            ),
            //SizedBox(height: 43),
          ],
        ),
      ),
    );
  }
}

/*
class Control extends StatefulWidget {
  const Control(List<Widget> regProgress, {Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}


class _ControlState extends State<Control>
    with TickerProviderStateMixin {

  static _ControlState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ControlState>();

  late TabController tabController;

  @override
  void initState() {
    tabController=TabController(
        length: regProgress.length,
        vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          TabBarView(
            controller: tabController,
              children: regProgress),
          Positioned(
            bottom: 20,
            child: TabPageSelector(
              controller: tabController,
              color: Color(0xFFD4E7FF),
              selectedColor: Colors.blueAccent,
              indicatorSize: 10,

            ),
          ),
        ],
      )

    );
  }
}
*/


