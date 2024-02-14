import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future cancelOrderDialog(context){
  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              children: [
                Container(
                  height: 28.h,
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'ביטול הזמנה',
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w600,
                              color: pinkColorApp),
                        ),
                        SizedBox(height: 51.h),
                        Text('האם הינך בטוח שברצונך לבטל הזמנה זו? ',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,),textDirection: TextDirection.rtl,),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Container(
                              height: 48.h,
                              width: 160.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: turquoiseColorApp,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () {
                                    //rentalTerm(context);
                                  },
                                  child: Text('לא, חזור להזמנות',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500))),
                            ),
                            SizedBox(width: 13.w),

                            Container(
                              height: 48.h,
                              width: 160.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: turquoiseColorApp,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: () {
                                    //rentalTerm(context);
                                  },
                                  child: Text('כן, המשך',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ],
                        ),
                        SizedBox(height: 22.h),
                      ]
                  ),
                ),
              ],
            )
        );
      }
  );
}
