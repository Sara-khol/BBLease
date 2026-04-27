import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/customWidgets/customText.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';


class StartRegistration extends StatefulWidget {
  const StartRegistration({super.key});

  @override
  State<StartRegistration> createState() => _StartRegistrationState();
}

class _StartRegistrationState extends State<StartRegistration> {
  late Orientation realOrientation;

  @override
  Widget build(BuildContext context) {
    realOrientation = View.of(context).physicalSize.width >
        View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
      body: LandSpaceWidget(mainWidget: buildContent(realOrientation),imageProperties:ImageProperties('l_image.png', 580.w,'תמונת פתיחת נעילה'),showAppBar: false,)
    ,
    );
  }

  buildContent(Orientation o) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 80.h),
              CustomText("תהליך הרשמה",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 23.sp,),),
              SizedBox(height: 32.h),
              CustomText("לתהליך הרישום, עליך להכין רשיון נהיגה \nוכרטיס אשראי על שמך בלבד!",
                  style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20.sp,)
                  ,textDirection: TextDirection.rtl,textAlign: TextAlign.center),
              SizedBox(height: 28.h),
              if(o == Orientation.portrait)Image.asset('assets/images/image4.png' ,semanticLabel: 'תמונה לפתוח רכב',width: 300.w,/*, fit: BoxFit.cover,*/),
              const Spacer(),
              SizedBox(
                height: 48.h,
                width: 332.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      elevation: 0.0,
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LicenseFront(index: 1,)));
                    },
                    child:  CustomText('אני מוכן!',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.normal,
                        color: Colors.white),textDirection: TextDirection.rtl)),
              ),
              SizedBox(height: 40.h,)
            ],
          ),
        );
  }
}
