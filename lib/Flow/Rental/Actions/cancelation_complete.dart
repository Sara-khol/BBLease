
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/sideMenu.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../landspace_widget.dart';
import '../../../utils/my_colors.dart';

class CancelationComplete extends StatelessWidget {
   CancelationComplete({super.key});
  late Orientation realOrientation;



  @override
  Widget build(BuildContext context) {
    realOrientation = View.of(context).physicalSize.width >
        View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
      body: LandSpaceWidget(mainWidget: buildContent(context,realOrientation),
        imageProperties:ImageProperties('image5.png', 1000.w,'תמונת פעולות')
      ),
    );
  }

  buildContent(context,Orientation o) {
    return Column(
      children: [
        if(o==Orientation.portrait) const AppBarBibilease(),
        if(o==Orientation.portrait)SizedBox(height: 40.h,),
        Text('ההזמנה בוטלה',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
        SizedBox(height: 33.h,),
        Text('מידע נוסף מחכה לך באזור האישי',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
          textAlign: TextAlign.center,),
        SizedBox(height: 60.h,),
        Image.asset('assets/images/image1.png',semanticLabel: 'תמונה תוצאות חיפוש',),
        SizedBox(height: 70.h,),
        Text('מקווים לראותך שוב בקרוב!',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,),
        //SizedBox(height: 138.h,),
        Spacer(),
        SizedBox(
          height: 48.h,
          width: 332.w,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoiseColorApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () {
                sideMenu(context);
              },
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('לאזור האישי',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.normal)
                    ),
                    SizedBox(width: 136.w,),
                     Icon(Icons.account_circle_outlined, color: Colors.white
               ,size: 28.sp.clamp(24.0, 34.0))

                  ],
                ),
              )
          ),
        ),
        SizedBox(height: 12.h,),
        SizedBox(
          height: 48.h,
          width: 332.w,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: turquoiseColorApp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              onPressed: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => const RentalWidget(),)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('למסך ראשי',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          //height: 2.3
                        )
                    ),
                    SizedBox(width: 136.w,),
                     Icon(Icons.logout ,size: 28.sp.clamp(24.0, 34.0),color: Colors.white),
                  ],
                ),
              )
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}
