
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
  const AdditionsDialog({super.key, required this.rent, required this.car, required this.additionsList});
  final Rental rent;
  final Car car;
  final List<Addition> additionsList;

  @override
  State<AdditionsDialog> createState() => _AdditionsDialogState();
}

class _AdditionsDialogState extends State<AdditionsDialog> {

  List<Addition> selectedAdditionsList=[];

  createCheckBox(int index){
    return CheckboxListTile(
      title: Text('${widget.additionsList[index].title} - ${widget.additionsList[index].price}₪',
      style: TextStyle(fontSize: 14.sp),),
      value: widget.additionsList[index].isChecked,
      enabled: widget.additionsList[index].isEnabled,
      checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
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


  final ScrollController _controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      top: false,
      maintainBottomViewPadding: true,
      minimum: EdgeInsets.only(bottom: 20.h),
      child: Padding(
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
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return /*SizedBox(
                            height: 60.h,
                            child:*/ createCheckBox(index);
                        //);
                        },
                      ),
                      SizedBox(height: 20.h,),
                      SizedBox(
                        height: 48.h,
                        width: 332.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: turquoiseColorApp,
                              elevation: 0,
                              shadowColor: Colors.transparent,

                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),),
                            onPressed: () async {
                              for(Addition addition in widget.additionsList) {
                                  if(addition.isChecked) {
                                    print(addition.title);
                                    selectedAdditionsList.add(addition);
                                  }
                              }
                              print(selectedAdditionsList.length);

                              widget.rent.additions=selectedAdditionsList;
                              widget.rent.car=widget.car;
                              bool containsAdditionalDriver = selectedAdditionsList.any((addition) => addition.name == 'additional_driver');
                              if(containsAdditionalDriver){
                               await displayQuestion1(context,header:'הי,שים לב!',
                                 message: 'בחרת בהוספת נהג נוסף,\nתרצה למלא את הפרטים?',
                                 noText: 'בתחילת הנסיעה',yesText: 'עכשיו',onYes: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDriver(index: 2, ), ));
                                 } );

                              }

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      maintainState:false,
                                      builder: (context) => CarDetails(rent: widget.rent)));
                            },
                            child:  Text('סיום', style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.normal,color: Colors.white),)),
                      ),
                    Container(height: 20.h
                    ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







