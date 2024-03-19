import 'dart:async';

import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/search_car.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/class_rent.dart';


double? latitude;
double? longitude;
String location = '';
//late DateTime startDate,endDate;
Rental rent = Rental();

Future departurePoint(context, address, nav,{double longitude1=0,double latitude1=0,sdate, edate}/*, [sdate, edate]*/) {
  print('dialog address: $address');

  location=address??'';
  latitude= latitude1;
  longitude= longitude1;

  TextEditingController controller = TextEditingController(text: address);
  DetailsResult? searchedPlace;


  late GooglePlace googlePlace =
      GooglePlace('AIzaSyBfvApaTLzPlCzL3LakX6DBbj2l7NMBRV4');
  bool done = false;

  List<AutocompletePrediction> predictions = [];

  Timer? debounce;

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value,language: 'iw');
    if (result != null && result.predictions != null) {
      //setState((){});
      predictions = result.predictions!;
      print(predictions);
    }
  }

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      barrierColor: Colors.black12.withOpacity(0.1),
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
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
                constraints: BoxConstraints(maxHeight: 500.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'מאיפה תרצה לצאת?',
                            style: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Icon(
                            Icons.fmd_good_outlined,
                            color: pinkColorApp,
                            size: 28.sp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45.h,
                      ),
                      TextField(
                        autofocus: true,
                        cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                        decoration: InputDecoration(
                            isDense: true,
                            labelText: "",
                            labelStyle: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromRGBO(15, 17, 21, 1),
                              fontFamily: 'PLONI',
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                            suffixIcon: Icon(
                              Icons.search,
                              color: turquoiseColorApp,
                              size: 24.sp,
                            )),
                        style: TextStyle(
                            color: Color.fromRGBO(15, 17, 21, 1),
                            fontSize: 20.sp),
                        controller: controller,

                        onChanged: (value) {
                          print('change');
                          //if (debounce?.isActive ?? false) debounce!.cancel();
                          //debounce =
                          // Timer(const Duration(milliseconds: 300), () {
                          if (value.isNotEmpty) {
                            autoCompleteSearch(value);
                          } else
                            predictions = [];
                          // });
                          setState((){});
                        },
                        //=> isTyping=true,
                        onEditingComplete: () {
                          debugPrint('onEditingComplete');
                          if(controller.text.isNotEmpty)
                          done = true;
                          else
                            done=false;
                          //todo setstate??

                          FocusScope.of(context).unfocus();
                        },
                      ),
                      predictions.isNotEmpty
                          ? Expanded(
                        child: ListView.builder(
                            //reverse: true,
                            shrinkWrap: true,
                            itemCount: predictions.length,
                            itemBuilder: (context, index) {
                              AutocompletePrediction prediction = predictions[index];
                              return ListTile(
                                title: Text(
                                  prediction.description.toString(),
                                  style: TextStyle(fontSize: 20.sp),
                                ),
                                onTap: () async {
                                  print('selected address: ${prediction.description.toString()}');
                                  controller.text=prediction.description.toString();
                                  debugPrint(prediction.description);
                                  //done = true;
                                  final placeId = prediction.placeId!;
                                  debugPrint('placeId $placeId');
                                  final details = await googlePlace.details.get(placeId);
                                  if (details != null && details.result != null) {
                                    debugPrint('details ${details.result}');
                                    searchedPlace = details.result;
                                    controller.text = prediction.description.toString();
                                    location = prediction.description.toString();//details.result!.name!;
                                    latitude = searchedPlace!.geometry!.location!.lat;
                                    longitude = searchedPlace!.geometry!.location!.lng;
                                    print('$latitude . $longitude');
                                    done = true;
                                    print('selected text: ${controller.text}');

                                  }
                                  predictions = [];
                                },
                              );
                            }),
                      )
                          : Spacer(),
                      done ? Column(
                              children: [
                                SizedBox(
                                  height: 32.h,
                                ),
                                Container(
                                  width: 332.w,
                                  height: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: turquoiseColorApp,
                                  ),
                                  child: TextButton(
                                    child: Text(
                                      'אישור',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      debugPrint("location $location longitude $longitude latitude $latitude");
                                      print('address: $address');
                                      if(controller.text.isNotEmpty && location.isNotEmpty) {
                                        //Navigator.pop(context);
                                        nav == 0
                                            ? rentalTerm(context)
                                            : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SearchCar(location: location,
                                                      latitude: latitude,
                                                      longitude: longitude,
                                                      startDate: sdate,
                                                      endDate: edate),));
                                        // MaterialPageRoute(
                                        //   builder: (context) => SearchCar(
                                        //       location: 'ירושלים',
                                        //       latitude: 31.803110,
                                        //       longitude: 35.216148,
                                        //       startDate: sdate,
                                        //       endDate: edate),
                                        // ));
                                      }
                                      else
                                        {
                                          displayMessage(context,message: 'נא הזן כתובת');
                                        }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 25.h,
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
                  );
          }
        );}

  );
}

Future rentalTerm(context, [DateTime? s,DateTime? e]) {
  TextEditingController startd = TextEditingController();
  TextEditingController endd = TextEditingController();

  TextEditingController starth = TextEditingController();
  TextEditingController endh = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  double? diff;
  if (s != null && e != null) {
    startd.text = intl.DateFormat('dd.MM.yyyy').format(s);
    endd.text = intl.DateFormat('dd.MM.yyyy').format(e);

    starth.text = intl.DateFormat('HH:mm').format(s);
    endh.text = intl.DateFormat('HH:mm').format(e);
    startDate = s;
    endDate = e;
  }

  int? selectedValue;
  int? selectedPart;

  Map<String, double> map = {'6 שעות': 0.25, 'יום': 1, 'שבוע': 7, 'חודש': 30};

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {

          setEndDateBasedOnSelection() {
            print('setEndDateBasedOnSelection()  $diff', );

            if (startDate != null && diff != null) {
              DateTime calculatedEndDate;
              diff!<1
                  ? calculatedEndDate = startDate!.add(Duration(hours: 6))
                  : calculatedEndDate = startDate!.add(Duration(days: diff!.toInt()));
                //calculatedEndDate = calculatedEndDate.add(Duration(days: 1));
                endd.text = intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
                endh.text = intl.DateFormat('HH:mm').format(calculatedEndDate);
                endDate = calculatedEndDate;
                print('startDate $startDate');
                print('endDate $endDate');
                rent.startDate = startDate!;
                rent.endDate = endDate!;
                setState((){});
              //startDate=null;
            }
          }

          RadioListTile _buildRadioTile(String title, int v) {
            return RadioListTile(
              activeColor: blackColorApp ,
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
                  print('diff $diff');
                  selectedPart = -1;
                });
                if (startDate != null) setEndDateBasedOnSelection();
              },
              groupValue: selectedValue,
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
                        SizedBox(height: 15.h,),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 190.h),
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              _buildRadioTile('6 שעות', 1),
                              _buildRadioTile('יום', 2),
                              _buildRadioTile('שבוע', 3),
                              _buildRadioTile('חודש', 4),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
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
                        Row(
                          children: [
                            TextFormField(
                              readOnly: true,
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: getInputDecoration(
                                  '',
                                  192,
                                  suffixIcon: ImageIcon(AssetImage("assets/icons/Calendar.png"),size: 20.w,color: pinkColorApp,),
                            ),
                              controller: startd,
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
                                    lastDate: DateTime.now().add(const Duration(days: 14)));
                                if (date != null) {
                                  startd.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                  print('start: ${startd.text}');
                                  startDate = date;
                                  //setEndDateBasedOnSelection();
                                }
                              },
                            ),
                            SizedBox(width: 9.h,),
                            TextFormField(
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: getInputDecoration('', 131, suffixIcon: Icon(Icons.access_time,size: 20.w,color: pinkColorApp,),),
                              controller: starth,
                              style: TextStyle(fontSize: 22.sp),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'זהו שדה חובה';
                                }
                              },
                              onTap: () async {
                                final TimeOfDay? starttime = await showTimePicker(
                                  context: context,
                                  initialTime: /*startDate!=null?TimeOfDay(hour: startDate!.hour, minute: startDate!.minute):*/TimeOfDay(hour: 00, minute: 00),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  builder: (BuildContext context, Widget? child) => MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                    child: Localizations.override(
                                      context: context,
                                      locale: const Locale("he", "HE"),
                                      child: child!,
                                    ),
                                  ),
                                );
                                print('starttime $starttime');
                                print('startDate $startDate');

                                if (startDate != null &&starttime != null) {
                                  //final hour = starttime.hour.toString().padLeft(2,'0');
                                  //final minute = starttime.minute.toString().padLeft(2,'0');
                                 //startDate!.add(Duration(hours: starttime.hour, minutes: starttime.minute));
                                  //if (startDate != null) {
                                  startDate = DateTime(startDate!.year, startDate!.month, startDate!.day, starttime.hour, starttime.minute);
                                  //}
                                  starth.text = '${startDate!.hour.toString().padLeft(2,'0')}:${startDate!.minute.toString().padLeft(2,'0')}';
                                  print('start: $startDate');
                                  setEndDateBasedOnSelection();
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h,),
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
                        Row(
                          children: [
                            TextFormField(
                              readOnly: true,
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: getInputDecoration('', 192, suffixIcon: ImageIcon(AssetImage("assets/icons/Calendar.png"),size: 20.w,color: pinkColorApp,),),
                              style: TextStyle(fontSize: 22.sp),
                              controller: endd,
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
                                  endd.text = intl.DateFormat('dd.MM.yyyy')
                                      .format(date);
                                }
                                endDate = date;
                              },
                            ),
                            SizedBox(width: 9.h,),
                            TextFormField(
                              readOnly: true,
                              cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                              decoration: getInputDecoration('', 131, suffixIcon: Icon(Icons.access_time,size: 20.w,color: pinkColorApp,),),
                              controller: endh,
                              style: TextStyle(fontSize: 22.sp),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'זהו שדה חובה';
                                }
                              },
                              onTap: () async {
                                final TimeOfDay? endtime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 00, minute: 00),
                                  initialEntryMode: TimePickerEntryMode.dial,
                                  builder: (BuildContext context, Widget? child) => MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                    child: Localizations.override(
                                      context: context,
                                      locale: const Locale("he", "HE"),
                                      child: child!,
                                    ),
                                  ),
                                );

                                if (endtime != null) {

                                  //final hour = starttime.hour.toString().padLeft(2,'0');
                                  //final minute = starttime.minute.toString().padLeft(2,'0');
                                  //startDate!.add(Duration(hours: starttime.hour, minutes: starttime.minute));
                                  if (startDate != null) {
                                  endDate = DateTime(endDate!.year, endDate!.month, endDate!.day, endtime.hour, endtime.minute);
                                  final duration=findDuration(diff);
                                  checkPickedRange(context,startDate!,endDate!,duration);
                                  }
                                  endh.text = '${endDate!.hour.toString().padLeft(2,'0')}:${endDate!.minute.toString().padLeft(2,'0')}';
                                  print('end: $endDate');
                                  //setEndDateBasedOnSelection();
                                }
                              },
                            ),
                          ],
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
                                print('data: ');
                                print(startDate);
                                print(endDate);
                                if(startd.text.isNotEmpty && selectedValue!=null) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          maintainState: false,
                                          builder: (context) =>
                                              SearchCar(location: location,
                                                latitude: latitude,
                                                longitude: longitude,
                                                startDate: rent.startDate,
                                                endDate: rent.endDate,
                                              )
                                      ));
                                }
                                else
                                  {
                                    displayMessage(context,message: 'נא מלא את כל הפרטים');
                                  }
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

Duration findDuration(double? diff) {
  Duration duration;
  if(diff==0.25) duration=Duration(hours: 6);
  if(diff==1) duration=Duration(days: 1);
  if(diff==7) duration=Duration(days: 7);
  else duration=Duration(days: 30);
  return duration;

}

getInputDecoration(String text,double width, {Widget? suffixIcon}) {
  return InputDecoration(
    constraints: BoxConstraints(maxWidth: width),
    isDense: true,
    labelText: text,
    labelStyle: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w300,
      color: blackColorApp,
      fontFamily: 'PLONI',
    ),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: blackColorApp,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: blackColorApp,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: blackColorApp,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.redAccent,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
    suffixIcon: suffixIcon,
  );
}

Future showLoading(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12.withOpacity(0.2),
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: pinkColorApp,
        ),
      );
    },
  );
}


checkPickedRange(context,DateTime start,DateTime end,Duration diff){
  print('checkPickedRange');
  print(start);
  print(end);
  if(start.difference(end)>diff){
    displayQuestion1(context, message: 'בחרת טווח השכרה קצר יותר ממה שציינת קודם', header: 'שים לב!',
        onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
            SearchCar(
                location: location,
                latitude: latitude,
                longitude: longitude,
              startDate: start,
              endDate: end,
            ),)),
    );

  }
  if(start.difference(end)<diff){
    displayQuestion1(context, message: 'בחרת טווח השכרה ארוך יותר ממה שציינת קודם', header: 'שים לב!',
      onYes: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
          SearchCar(
            location: location,
            latitude: latitude,
            longitude: longitude,
            startDate: start,
            endDate: end,
          ),)),
    );

  }


}
