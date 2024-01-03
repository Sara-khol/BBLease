



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

                            for(Addition a in widget.rent.additions)
                              {
                                debugPrint('title: ${a.title} name: ${a.name} ${a.isChecked}');
                              }

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





