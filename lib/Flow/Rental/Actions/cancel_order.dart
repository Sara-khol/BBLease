import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../landspace_widget.dart';
import '../../../models/class_rent.dart';
import '../../../utils/my_colors.dart';
import 'cancel_order_dialogs.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({super.key, required this.rent});
  final Rental rent;


  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {

  late int difference;
  @override
  void initState() {
    difference=DateTime.now().difference(widget.rent.creationTime).inMinutes;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(orientation),
              imageProperties:ImageProperties('image5.png', 1000.w,'תמונת פעולות'),
             );
        }
        return buildContent(orientation);
      }),
    );
  }

  buildContent(Orientation o) {
    return Column(
      children: [
        if(o==Orientation.portrait) const AppBarBibilease(),
        SizedBox(height: 40.h,),
        Text('ביטול הזמנה',
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
        SizedBox(height: 33.h,),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Text(difference <= 15
              ? 'לא יגבה ממך תשלום עבור שירות זה'
              : 'ביטול הזמנה בשלב זה יגבה ממך תשלום בשווי ההזמנה מפני שעברו יותר מ-15 דקות',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,),
        ),
        SizedBox(height: 33.h,),
        const Spacer(),
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
                signCancelOrderDialog(
                    context, 'טופס ביטול הזמנה', 'אישור וחתימה לביטול הזמנה',widget.rent.orderNum);
              },
              child: Text('לחתימה',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    //height: 2.3
                  )
              )
          ),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}
