import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/models/additional_driver.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../customWidgets/appBarB.dart';
import '../../../landspace_widget.dart';
import '../../../utils/my_colors.dart';
import '../dialogs.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({super.key, required this.index, this.orderId});
  final int index;
  final int? orderId;

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: true,
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return LandSpaceWidget(
                mainWidget: buildContent(orientation),
                imageProperties:ImageProperties('image5.png', 1000.w,'תמונת פעולות'),
            );
          }
          return buildContent(orientation);
        }),
    );
  }

  buildContent(Orientation o) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          if(o==Orientation.portrait)
            const Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
          SizedBox(height: 54.h,),
          Text('הוספת נהג',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 38.h,),
          Text('הכנס ת.ז של הנהג שברצונך להוסיף',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 20.h,),
          TextField(
            cursorColor: blackColorApp,
            decoration: getInputDecoration('תעודת זהות', 332),
            style: TextStyle(color: blackColorApp, fontSize: 20.sp),
            controller: _controller,
          ),

          const Spacer(),
          SizedBox(
            height: 48.h,
            width: 250.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: turquoiseColorApp,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {
                  ApiService().getAdditionalDriver(_controller.text, (res) {
                    res == -1 ?
                    addDriver(true)
                        : addDriver(false, res);
                  });
                },
                child: Text('הוסף',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.normal,
                      //height: 2.3
                    ))),
          ),
          SizedBox(height: 30.h,)

        ],
      ),
    );
  }

  Future addDriver(bool isNew,[json]){
    print(isNew);
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        barrierColor: Colors.black12.withOpacity(0.1),
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: [
                      Container(height: 45.h),
                      Text(
                        'הוספת נהג',
                        style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: pinkColorApp),
                      ),
                      Container(height: 36.h),
                      Text(isNew?'נהג זה אינו מוכר במערכת\nעליך לסרוק את רישיון הנהיגה שלו: על שמו ובתוקף'
                          :'נהג זה מופיע כמשתמש מוכר במערכת\nניתן לצרפו בקלות ובמהירות בלחיצת כפתור',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,),
                        textAlign: TextAlign.center
                        ,textDirection: TextDirection.rtl,),
                      Container(height: 30.h),
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
                              User().additionalDriver.id=_controller.text;
                              isNew
                                ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LicenseFront(index: widget.index)))
                                : User().additionalDriver=AdditionalDriver.fromJson(json);
                              },
                            child: Text(isNew?'סרוק רישיון נהיגה':'הוספת נהג',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    //fontWeight: FontWeight.w600,
                                    //height: 2.3
                                )
                            )

                        ),
                      ),
                      Container(height: 22.h),
                    ]
                ),
              )
          );
        }
    );
  }
}
