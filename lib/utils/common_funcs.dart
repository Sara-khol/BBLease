import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class CommonFuncs
{
  void showMyToast(String message, { int duration = 3}) {
    Widget widget = /*Container(
        margin: EdgeInsets.only(bottom: 80.h),
        padding: EdgeInsets.only(right: 30.w, left: 30.w),
        child:*/ ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: EdgeInsets.all(10.w),
        color:colors.blackColorApp,
        child: Text(
          message,
          style: const TextStyle(color: Colors.white/*, fontSize: 18.sp*/),
          textAlign: TextAlign.center,
        ),
      ),
      // )
    );

    showToastWidget(
      widget,
      duration: Duration(seconds: duration),
      onDismiss: () {},

      position: ToastPosition.bottom,
    );
  }

  Widget getBackButton(BuildContext context)
  {

      final size = 24.sp.clamp(20.0, 28.0);

      return Align(
        alignment: Alignment.topRight,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 36,
              minHeight: 36,
            ),
            iconSize: size,
            icon: Icon(
              Icons.arrow_back_ios,
              size: size,
              color: colors.blackColorApp,
            ),
          ),
        ),
      );
    }
}