
import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/additions.dart';
import '../../models/car.dart';
import '../../models/class_user.dart';
import '../../services/api_service.dart';
import 'additions_dialog.dart';

Future carDetailsDialog(context,Car car,bool isAvailabe){
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
                           'פרטי רכב',
                           style: TextStyle(
                               fontSize: 18.sp,
                               fontWeight: FontWeight.w700,
                               color: Colors.black),
                         ),
                        SizedBox(height: 25.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.drive_eta_outlined, color: pinkColorApp,),
                            Text('  ${car.postTitle}  ',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,),),
                            SizedBox(width: 50.w,),
                            ImageIcon(AssetImage("assets/icons/Filter.png"),size: 20.w,color: pinkColorApp,),
                            Text('  ${car.type}  ',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,),),
                          ],
                        ),
                        SizedBox(height: 13.h),
                        Row(
                          children: [
                            Icon(Icons.fmd_good_outlined, color: pinkColorApp,),
                            Text('  ${car.address}  ',style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500,),),
                          ],
                        ),
                        SizedBox(height: 16.h),

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
                              onPressed: () {
                                //rentalTerm(context);
                              },
                              child: Text('אני רוצה להשכיר את הרכב הזה',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500))),
                        ),
                        SizedBox(height: 20.h),
                      ]
                    ),
                  ),
                ],
              )
            );
      }
  );
}

Future openingCodeDialog(context,String code){
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
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'קוד לפתיחה  ',
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          Icon(Icons.password, color: pinkColorApp,),
                        ],
                      ),
                      SizedBox(height: 47.h),
                      Text(' הקוד לפתיחה הינו ',style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600,),),
                      SizedBox(height: 40.w,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.copy, color: turquoiseColorApp,),
                          Text('  $code  ',style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.w700,),),
                        ],
                      ),
                      SizedBox(height: 30.h),
                    ]
                ),
              ],
            )
        );
      }
  );
}


Future rentalTerm1(context, Car car) {
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  double? diff;
  /*if (s != null && e != null) {
    start.text = intl.DateFormat('dd.MM.yyyy').format(s);
    end.text = intl.DateFormat('dd.MM.yyyy').format(e);

    startDate = s;
    endDate = e;
  }*/

  int? selectedValue;
  int? selectedPart;

  Map<String, double> map = {'חצי יום': 0.5, 'יום': 1, 'שבוע': 7, 'חודש': 30};

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          _setEndDateBasedOnSelection() {
            if (startDate != null && diff != null) {
              DateTime calculatedEndDate =
              startDate!.add(Duration(days: diff!.toInt() - 1));
              calculatedEndDate = calculatedEndDate.add(Duration(days: 1));
              end.text =
                  intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
              endDate = calculatedEndDate;

              rent.startDate = startDate!;
              rent.endDate = endDate!;

              //setState((){});
            }
          }

          RadioListTile _buildRadioTile(String title, int v) {
            return RadioListTile(
              value: v,
              dense: true,
              title: Text(title, style: TextStyle(fontSize: 20.sp)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: (value) {
                setState(() {
                  selectedValue = value;
                  diff = map[title];
                  selectedPart = -1;
                });
                if (startDate != null) _setEndDateBasedOnSelection();
              },
              groupValue: selectedValue,
            );
          }

          RadioListTile _buildRadioTile2(String title, int v) {
            return RadioListTile(
              value: v,
              dense: true,
              title: Text(title, style: TextStyle(fontSize: 20.sp)),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              onChanged: (value) {
                setState(() {
                  selectedPart = value;
                });
              },
              groupValue: selectedPart,
            );
          }

          return Container(
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 250,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Directionality(
              textDirection: TextDirection.rtl,
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
                          children: [
                            Text(
                              'בחר טווח השכרה',
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            ImageIcon(AssetImage("assets/icons/Calendar.png"),size: 20.w,color: pinkColorApp,),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 190.h),
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              _buildRadioTile('חצי יום', 1),
                              _buildRadioTile('יום', 2),
                              _buildRadioTile('שבוע', 3),
                              _buildRadioTile('חודש', 4),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Visibility(
                            visible: selectedValue == 1,
                            child: Container(
                              //color: Colors.yellow,
                              height: 100.h,
                              width: 300.w,
                              child: Column(
                                children: [
                                  Text('בחר טווח שעות',style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                                  _buildRadioTile2('8:00-17:00 בוקר ', 1),
                                  _buildRadioTile2('17:00-8:00 לילה', 2),
                                ],
                              ),
                            )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('ממתי ?',
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ],
                        ),
                        TextFormField(
                          readOnly: true,
                          cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(15, 17, 21, 1),
                              fontFamily: 'PLONI',
                            ),
                            floatingLabelBehavior:
                            FloatingLabelBehavior.auto,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 17, 21, 1),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 17, 21, 1),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.w, horizontal: 20.h),
                            suffixIcon:                             ImageIcon(AssetImage("assets/icons/Calendar.png"),size: 20.w,color: pinkColorApp,),
),
                          //style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                          controller: start,
                          style: TextStyle(fontSize: 22.sp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'זהו שדה חובה';
                            }
                          },
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                                textDirection: TextDirection.rtl,
                                locale: const Locale("he", "HE"),
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              start.text = intl.DateFormat('dd.MM.yyyy')
                                  .format(date);
                              print('start: ${start.text}');
                              startDate = date;
                              _setEndDateBasedOnSelection();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Visibility(
                          visible: selectedValue != 1,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('עד -',
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ],
                              ),
                              TextFormField(
                                readOnly: true,
                                cursorColor:
                                const Color.fromRGBO(15, 17, 21, 1),
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelStyle: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w300,
                                    color: const Color.fromRGBO(
                                        15, 17, 21, 1),
                                    fontFamily: 'PLONI',
                                  ),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.auto,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color:
                                      Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    borderSide: const BorderSide(
                                      color:
                                      Color.fromRGBO(15, 17, 21, 1),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.w, horizontal: 20.h),
                                  suffixIcon:ImageIcon(AssetImage("assets/icons/Calendar.png"),size: 20.w,color: pinkColorApp,),),
                                style: TextStyle(fontSize: 22.sp),
                                controller: end,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'זהו שדה חובה';
                                  }
                                },
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
                                      locale: const Locale("he", "HE"),
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    end.text = intl.DateFormat('dd.MM.yyyy')
                                        .format(date);
                                  }
                                  endDate = date;
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 24.h,
                        ),
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
                                Navigator.pop(context);
                                additionsDialog(context,car,startDate,endDate);
                              },
                              child: const Text(
                                'המשך',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 25.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
      barrierColor: Colors.black12.withOpacity(0.1),
      //isDismissible: false,
      elevation: 2,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))));
}


Future additionsDialog(context, car,startDate,endDate)async {
  List<Addition> additions=[];
  await ApiService().getAdditions(car.id,startDate,endDate, (orderJson) {
    Navigator.pop(context);

    additions = orderJson.map<Addition>((entry) => (Addition.fromJson(entry))).toList();
    for(Addition item in additions){
      if(item.name=='new_driver'||item.name=='young_driver'){
        item.isEnabled=false;
        if(item.name=='new_driver'&&User().isNewDriver||
            item.name=='young_driver'&&User().isYoungDriver){
          item.isChecked=true;
        }
      }
    }
  });

  return  showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: false,
    barrierColor: Colors.black12.withOpacity(0.1),
    backgroundColor: Colors.white,
    //isDismissible: false,
    elevation: 2,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
    context: context,
    builder: (_) => AdditionsDialog(rent: rent, car: car, additionsList: additions),
  );
}