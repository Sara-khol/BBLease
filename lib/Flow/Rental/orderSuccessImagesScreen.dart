import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';
import '../../utils/my_colors.dart';
import '../UserInformation/ordersHistory.dart';


class OrderSuccessImagesScreen extends StatelessWidget {
   OrderSuccessImagesScreen({super.key});

  late Orientation realOrientation;

  @override
  Widget build(BuildContext context) {
    realOrientation = View.of(context).physicalSize.width >
        View.of(context).physicalSize.height
        ? Orientation.landscape
        : Orientation.portrait;
    return Scaffold(
        body: LandSpaceWidget(mainWidget: buildContent(context),
            imageProperties: ImageProperties('image4.png', 1000.w,'תמונת פרטי רכב')));
  }

  buildContent(BuildContext context)
  {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:   Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // גלילה
            Expanded(
              child: LayoutBuilder(
        builder: (context, constraints) {
                  return SingleChildScrollView(
                   // padding:  EdgeInsets.only(bottom: 90.h),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/order_success_1.jpeg',
                          fit: BoxFit.fitWidth,
                        ),

                        Image.asset(
                          'assets/images/order_success_2.jpeg',
                          width: double.infinity,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            // כפתור קבוע למטה
           Container(
                height: 48.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  vertical: 35.h,
                  horizontal: 30.w
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: turquoiseColorApp,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () => _goToOrders(context),
                  child:  Text('סיום',  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.normal,
                    height: 1,
                    color: Colors.white,
                  )),
                ),
              ),

          ],
        ),
      ),
    ));
  }


  void _goToOrders(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const OrdersHistory(
          index: 2,
          goBack: false,
        ),
      ),
          (route) => false,
    );
  }
}