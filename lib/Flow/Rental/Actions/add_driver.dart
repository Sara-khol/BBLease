import 'package:bblease/Flow/registration/license_front.dart';
import 'package:bblease/models/additional_driver.dart';
import 'package:bblease/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../customWidgets/appBarB.dart';
import '../../../utils/my_colors.dart';
import '../dialogs.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     resizeToAvoidBottomInset: true,
        body: Directionality(
        textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Directionality(textDirection: TextDirection.ltr,child: AppBarBibilease()),
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
                readOnly: true,
                cursorColor: blackColorApp,
                decoration: getInputDecoration('תוקף',332,
                    suffixIcon: Icon(Icons.check_circle_outline,color: pinkColorApp,)/*Image.asset(
                      'assets/icons/с.png',
                      width: 18.w,
                    )*/),
                style:
                TextStyle(color: blackColorApp, fontSize: 20.sp),
                controller: _controller,

              ),
              Spacer(),
              Container(
                height: 48.h,
                width: 250.w,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: turquoiseColorApp,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: ()  {
                      ApiService().getAdditionalDriver(_controller.text, (res) {
                        res==-1?
                        addDriver(true)
                        :addDriver(false,res);
                      });
                    },
                    child: Text('הוסף',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.normal,
                            height: 2.3))),
              ),
              SizedBox(height: 30.h,)

            ],
          ),
        )
    );
  }

  Future addDriver(bool isNew,[json]){
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
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 45.h),
                      Text(
                        'הוספת נהג',
                        style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                            color: pinkColorApp),
                      ),
                      SizedBox(height: 36.h),
                      Text(isNew?'נהג זה אינו מוכר במערכת\nעליך לסרוק את רישיון הנהיגה שלו: על שמו ובתוקף'
                          :'נהג זה מופיע כמשתמש מוכר במערכת\nניתן לצרפו בקלות ובמהירות בלחיצת כפתור',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,)
                        ,textDirection: TextDirection.rtl,),
                      SizedBox(height: 20.h),
                      Container(
                        height: 48.h,
                        width: 332.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: turquoiseColorApp,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            onPressed: () =>isNew?Navigator.push(context, MaterialPageRoute(builder:(context) => LicenseFront(index: 2))):(){
                              rent.additionalDriver=AdditionalDriver.fromJson(json);
                            },
                            child: Text('הוספת נהג',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    height: 2.3))),
                      ),
                      SizedBox(height: 22.h),
                    ]
                ),
              )
          );
        }
    );
  }
}
