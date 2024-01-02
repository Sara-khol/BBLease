



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
        setState(() {

        });
        //rent.waze=value!;

      },
    );

  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 600.h),
          child: Column(
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
                      children: [
                        Text('התאם תנאי השכרה', style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),),
                        SizedBox(width: 9.w,),
                        Icon(
                          Icons.extension_outlined, color: pinkColorApp, size: 24.sp,),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    ListView.builder(
                      itemCount: widget.additionsList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return createCheckBox(index);
                      },),
                    /*Column(
                                children: [
                                  CheckboxListTile(
                                    title: Text('  נהג חדש - 40 ש"ח  '),
                                    value: val[0],
                                    enabled: false,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    fillColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.transparent;
                                      }
                                      return null;
                                    }),
                                    checkColor: colors.turquoiseColorApp,
                                    onChanged: (value) {  },
                                  ),
                                  CheckboxListTile(
                                    title: Text('  נהג צעיר - 49 ש"ח  '),
                                    value: val[1],
                                    enabled: false,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    checkColor: colors.turquoiseColorApp,
                                    fillColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.transparent;
                                      }
                                      return null;
                                    }),
                                    onChanged: (value) {  },
                                  ),
                                  CheckboxListTile(
                                    title: Text('  ביטול השתתפות עצמית - 52 ש"ח  '),
                                    value: val[2],
                                    //enabled: true,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    checkColor: colors.turquoiseColorApp,
                                    fillColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.transparent;
                                      }
                                      return null;
                                    }),
                                    onChanged: (value) {
                                      rent.deductible=value!;
                                      setState((){val[2]=value;});
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text('  נהג נוסף - 20 ש"ח  '),
                                    value: val[3],
                                    enabled: false,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    checkColor: colors.turquoiseColorApp,
                                    onChanged: (value) {

                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text('  בוסטר/כיסא תינוק - 20 ש"ח  '),
                                    value: val[4],
                                    enabled: true,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    checkColor: colors.turquoiseColorApp,
                                    fillColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.transparent;
                                      }
                                      return null;
                                    }),
                                    onChanged: (value) {
                                      rent.car.safetyChair=value!;
                                      setState((){val[4]=value;});
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text('  מכשיר וויז -10 ש"ח  '),
                                    value: val[5],
                                    enabled: true,
                                    checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    fillColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.transparent;
                                      }
                                      return null;
                                    }),
                                    checkColor: colors.turquoiseColorApp,
                                    onChanged: (value) {
                                      rent.waze=value!;
                                      setState((){val[5]=value;});
                                    },
                                  ),
                                ],
                              ),*/

                    /*ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 190.h),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[

                                  ],
                                ),
                              ),*/
                    SizedBox(height: 20.h,),

                    SizedBox(
                      height: 48.h,
                      width: 332.w,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: turquoiseColorApp,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                          ),
                          onPressed: () {
                            widget.rent.additions=widget.additionsList;
                            widget.rent.car=widget.car;

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    maintainState:false,
                                    builder: (context) => CarDetails(rent: widget.rent,)));
                          },
                          child: const Text('סיום', style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500),)),
                    ),
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





