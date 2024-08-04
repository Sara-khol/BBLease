
import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/Actions/add_driver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/additions.dart';
import '../../models/car.dart';
import '../../models/class_rent.dart';
import '../../utils/my_colors.dart';
import 'car_details.dart';

class AdditionsDialog extends StatefulWidget {
  const AdditionsDialog({Key? key, required this.rent, required this.car, required this.additionsList}) : super(key: key);
  final Rental rent;
  final Car car;
  final List<Addition> additionsList;

  @override
  State<AdditionsDialog> createState() => _AdditionsDialogState();
}

class _AdditionsDialogState extends State<AdditionsDialog> {

  createCheckBox(int index){
    return CheckboxListTile(
      title: Text(widget.additionsList[index].title),
      value: widget.additionsList[index].isChecked,
      enabled: widget.additionsList[index].isEnabled,
      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.transparent;
        }
        return null;
      }),
      checkColor: turquoiseColorApp,

      onChanged: (value) {

        widget.additionsList[index].isChecked=value!;
        setState(() { });
        //rent.waze=value!;
      },
    );
  }

  Future addDriverDialog(){
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
          return SizedBox(
            height: 400.h,
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 35.h),
                        Text(
                          'הי,שים לב!',
                          style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 51.h),
                        Text('בחרת בהוספת נהג נוסף,\nתרצה למלא את הפרטים?',style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,),),
                        SizedBox(height: 26.h),
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
                                  onPressed: ()  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(index: 2, ), ));
                                  },
                                  child: Text('עכשיו',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal))),
                            ),
                            SizedBox(width: 13.h),
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
            Navigator.pop(context);
                                  },
                                  child: Text('בתחילת הנסיעה',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal))),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                      ]
                  ),
                )
            ),
          );
        }
    );
  }

  ScrollController _controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          //constraints: BoxConstraints(maxHeight: 600.h),/
         // height: 450.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25),),
          ),
          child: Wrap(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('תוספות מומלצות', style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),),
                        SizedBox(width: 11.w,),
                        Image.asset("assets/icons/Additions.png"),
                      ],
                    ),
                    SizedBox(height: 15.h,),

                    ListView.builder(
                      controller: _controller,
                      itemCount: widget.additionsList.length,
                       shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50.h,
                          child: createCheckBox(index),
                        );
                      },
                    ),
                    SizedBox(height: 20.h,),
                    SizedBox(
                      height: 48.h,
                      width: 332.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: turquoiseColorApp,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),),
                          onPressed: () async {
                            widget.rent.additions=widget.additionsList;
                            widget.rent.car=widget.car;
                            bool containsAdditionalDriver = widget.rent.additions!.any((addition) => addition.name == 'additional_driver');
                            if(containsAdditionalDriver){
                             await displayQuestion1(context,header:'הי,שים לב!',
                               message: 'בחרת בהוספת נהג נוסף,\nתרצה למלא את הפרטים?',
                               noText: 'בתחילת הנסיעה',yesText: 'עכשיו',onYes: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => AddDriver(index: 2, ), ));
                               } );

                            }

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    maintainState:false,
                                    builder: (context) => CarDetails(rent: widget.rent,)));
                          },
                          child:  Text('סיום', style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.normal,color: Colors.white),)),
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







