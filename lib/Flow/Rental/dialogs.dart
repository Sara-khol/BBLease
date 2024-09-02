import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:bblease/Flow/Dialogs/buttom_dialogs.dart';
import 'package:bblease/Flow/Rental/search_car.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;

import '../../models/class_rent.dart';
import '../UserInformation/contact_us.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';



double? latitude;
double? longitude;
late String location;
//late DateTime startDate,endDate;
Rental rent = Rental();

Future departurePoint(context, address, nav, { Function? onClose,double longitude1=0,double latitude1=0,sdate, edate}) {
  print('dialog address: $address');

  location=address??'';
  latitude= latitude1;
  longitude= longitude1;

  TextEditingController controller = TextEditingController(text: address);
  List<AutocompletePrediction>? _predictions;
  late final FlutterGooglePlacesSdk _places;
  Place? place;
  final List<PlaceField> _placeFields = [
    PlaceField.Address,
    PlaceField.AddressComponents,
    PlaceField.BusinessStatus,
    PlaceField.Id,
    PlaceField.Location,
    PlaceField.Name,
  ];
  Timer? debounce;
 // DetailsResult? searchedPlace;

  //GooglePlace googlePlace = GooglePlace('AIzaSyDrD1omOKsD-QCghL7Oaq1LmU6mgxvqaLs',headers: header);

 // List<AutocompletePrediction> predictions = [];


  _places = FlutterGooglePlacesSdk('AIzaSyDrD1omOKsD-QCghL7Oaq1LmU6mgxvqaLs',
      locale:  const Locale('he', 'IL'));
  _places.isInitialized().then((value) {
    debugPrint('Places Initialized: $value');
  });

   autoCompleteSearch(String value) async {
      final result = await _places.findAutocompletePredictions(
        controller.text,
        // countries: _countriesEnabled ? _countries : null,
        // placeTypesFilter: _placeTypesFilter,
        // newSessionToken: false,
        // origin: LatLng(lat: 43.12, lng: 95.20),
        // locationBias: _locationBiasEnabled ? _locationBias : null,
        // locationRestriction:
        // _locationRestrictionEnabled ? _locationRestriction : null,
      );
      _predictions = result.predictions;
      print('Result: $_predictions');


    // var result = await googlePlace.autocomplete.get(value,language: 'iw');
    // if (result != null && result.predictions != null) {
    //   //setState((){});
    //   predictions = result.predictions!;
    //   print(predictions);
    // }
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
        return PointerInterceptor(
          child: StatefulBuilder(builder: (context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'מאיפה תרצה לצאת?',
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.bold,
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
                                fontWeight: FontWeight.normal,
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

                          onChanged: (value) async {
                           // done = controller.text.isNotEmpty;
                            print('change $value');

                            if (debounce?.isActive ?? false) debounce?.cancel();
                            debounce = Timer(const Duration(milliseconds: 300), () async{
                              if (value.isNotEmpty && value.length>1) {
                                await autoCompleteSearch(value);
                              } else {
                                debugPrint('emptyyy!');
                                _predictions = [];
                                place=null;
                                location='';
                              }
                              setState((){});
                            });




                            //if (debounce?.isActive ?? false) debounce!.cancel();
                            //debounce =
                            // Timer(const Duration(milliseconds: 300), () {

                          },
                          //=> isTyping=true,
                          onEditingComplete: () {
                            debugPrint('onEditingComplete');
                            //todo setstate??
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        _predictions != null && _predictions!.isNotEmpty
                            ? Expanded(
                          child: /*ListView.builder(
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
                              })*/
                              ListView.builder(
                              shrinkWrap: true,
                              itemCount: _predictions!.length,
                              itemBuilder: (context, index) {
                                AutocompletePrediction prediction = _predictions![index];
                                return ListTile(
                                  title: Text(
                                    prediction.fullText.toString(),
                                    style: TextStyle(fontSize: 20.sp),
                                  ),
                                  onTap: () async {
                                    debugPrint(
                                        'selected address: ${prediction.fullText.toString()}');
                                    // controller.text =
                                    //     prediction.fullText.toString();
                                    //done = true;
                                    final placeId = prediction.placeId;
                                    debugPrint('placeId $placeId');
                                    final result = await _places.fetchPlace(placeId,fields: _placeFields);
                                    setState(() {
                                      place = result.place;
                                      //  _fetchingPlace = false;
                                    });
                                    if (place != null ) {
                                      debugPrint('details $place');
                                      controller.text = place!.address.toString();
                                      location = place!.name.toString(); //details.result!.name!;
                                      latitude = place!.latLng?.lat;
                                      longitude = place!.latLng?.lng;
                                      debugPrint('location $latitude . $longitude');
                                      debugPrint('selected text: ${controller.text}');
                                    }
                                    _predictions = [];
                                  },
                                );
                              }
                          ),
                        )
                            :  Container(),
                        location.isNotEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 32.h,
                                  ),
                                  Container(
                                    width: 332.w,
                                    height: 48.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                      color: turquoiseColorApp,
                                    ),
                                    child: TextButton(
                                      child: Text(
                                        nav==0?'לבחירת תאריך':'אישור',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onPressed: () {
                                        debugPrint("location $location longitude $longitude latitude $latitude");
                                        if(/*kIsWeb||*/controller.text.isNotEmpty && location.isNotEmpty) {
                                          //Navigator.pop(context);
                                          nav == 0
                                              ? rentalTerm(context,0)
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchCar(
                                                          index: 1,
                                                            location: location,
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
          ),
        );}

  ).then((_) {
    debugPrint('onClose');
    debounce?.cancel();
    if(onClose!=null) {
      onClose();
    }
    });
}

Future rentalTerm(context,nav, [DateTime? s,DateTime? e]) {
  TextEditingController startd = TextEditingController();
  TextEditingController endd = TextEditingController();

  TextEditingController starth = TextEditingController();
  TextEditingController endh = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  double? diff;
  if (s != null && e != null) {
    /*if(kIsWeb){
      startd.text = intl.DateFormat('yyyy.MM.dd').format(s);
      endd.text = intl.DateFormat('yyyy.MM.dd').format(e);

      starth.text = intl.DateFormat('mm:HH').format(s);
      endh.text = intl.DateFormat('mm:HH').format(e);
    }
    else {*/
      startd.text = intl.DateFormat('dd.MM.yyyy').format(s);
      endd.text = intl.DateFormat('dd.MM.yyyy').format(e);

      starth.text = intl.DateFormat('HH:mm').format(s);
      endh.text = intl.DateFormat('HH:mm').format(e);
    //}
    startDate = s;
    endDate = e;
  }

  int? selectedValue;

  Map<String, double> map = {'6 שעות': 0.25, 'יום': 1, 'שבוע': 7, 'חודש': 30};

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) {
        return PointerInterceptor(
          child: StatefulBuilder(builder: (context, StateSetter setState) {

            setEndDateBasedOnSelection() {
              print('setEndDateBasedOnSelection()  $diff', );

              if (startDate != null && diff != null) {
                DateTime calculatedEndDate;
                diff!<1
                    ? calculatedEndDate = startDate!.add(Duration(hours: 6))
                    : calculatedEndDate = startDate!.add(Duration(days: diff!.toInt()));
                  //calculatedEndDate = calculatedEndDate.add(Duration(days: 1));
                /*if(kIsWeb){
                  endd.text = intl.DateFormat('yyyy.MM.dd').format(calculatedEndDate);
                  endh.text = intl.DateFormat('mm:HH').format(calculatedEndDate);
                }
                else{*/
                  endd.text = intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
                  endh.text = intl.DateFormat('HH:mm').format(calculatedEndDate);
                //}
                  endDate = calculatedEndDate;
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
                mouseCursor: MouseCursor.uncontrolled,
                dense: true,
                autofocus: true,
                contentPadding: EdgeInsets.zero,
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
                  });
                  if (startDate != null) setEndDateBasedOnSelection();
                },
                groupValue: selectedValue,
              );
            }

            DateTime roundToNextQuarter(DateTime dateTime) {
              final nextHour = (dateTime.hour + 6 - dateTime.hour % 6) % 24;
              final remainderMinutes = dateTime.minute > 0 ? 60 - dateTime.minute : 0;
              return dateTime.add(Duration(hours: nextHour, minutes: remainderMinutes));
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
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'בחר טווח השכרה',
                                style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 9.w,
                              ),
                              ImageIcon(AssetImage("assets/icons/Calendar.png"),color: pinkColorApp,),

                            ],
                          ),
                          SizedBox(height: 15.h,),
                         // ConstrainedBox(
                         //   constraints: BoxConstraints(maxHeight: 190.h),
                         //   child:
                            Column(
                              children: <Widget>[
                                _buildRadioTile('6 שעות', 1),
                                _buildRadioTile('יום', 2),
                                _buildRadioTile('שבוע', 3),
                                _buildRadioTile('חודש', 4),
                              ],
                            ),
                          //),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('ממתי ?',
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                readOnly: true,
                                cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                decoration: getInputDecoration(
                                    '',
                                    192,
                                    suffixIcon: ImageIcon(AssetImage("assets/icons/CalendarBig.png"),color: pinkColorApp,),
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
                                    /*if(kIsWeb){
                                      startd.text = intl.DateFormat('yyyy.MM.dd').format(date);
                                    }
                                    else*/ startd.text = intl.DateFormat('dd.MM.yyyy').format(date);
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
                                  final now = DateTime.now();
                                   TimeOfDay? starttime = await showTimePicker(
                                    context: context,
                                    initialTime: startDate==now?TimeOfDay.now():TimeOfDay(hour: 00, minute: 00),
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
                                  if (starttime != null) {
                                    final pickedDateTime = DateTime(startDate!.year, startDate!.month, startDate!.day, starttime.hour, starttime.minute);
                                    if (pickedDateTime.isBefore(now)) {
                                      displayMessage(context,message: 'שעת תחילת ההשכרה חלפה כבר\nאנא שנה את בחירתך');
                                      setState(()=>starttime=null);
                                    }
                                  }
                                  if (startDate != null &&starttime != null) {
                                    startDate = DateTime(startDate!.year, startDate!.month, startDate!.day, starttime!.hour, starttime!.minute);
                                    /*kIsWeb
                                        ? starth.text = '${startDate!.minute.toString().padLeft(2,'0')}:${startDate!.hour.toString().padLeft(2,'0')}'
                                        :*/ starth.text = '${startDate!.hour.toString().padLeft(2,'0')}:${startDate!.minute.toString().padLeft(2,'0')}';
                                    print('start: $startDate');
                                    print('start: ${starth.text}');
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
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                readOnly: true,
                                cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                decoration: getInputDecoration('', 192, suffixIcon: ImageIcon(AssetImage("assets/icons/CalendarBig.png"),color: pinkColorApp,),),
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
                                    endd.text = /*kIsWeb?intl.DateFormat('yyyy.MM.dd').format(date):*/intl.DateFormat('dd.MM.yyyy').format(date);
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
                                    // kIsWeb
                                    //     ?  endh.text = '${endDate!.minute.toString().padLeft(2,'0')}:${endDate!.hour.toString().padLeft(2,'0')}'
                                    //     :  endh.text = '${endDate!.hour.toString().padLeft(2,'0')}:${endDate!.minute.toString().padLeft(2,'0')}';
                                    if (startDate != null) {
                                      endDate = DateTime(endDate!.year, endDate!.month, endDate!.day, endtime.hour, endtime.minute);
                                      final duration=findDuration(diff);
                                      checkPickedRange(context,startDate!,endDate!,duration);
                                      roundToNextQuarter(endDate!);
                                    }
                                    print('end: $endDate');
                                    print('end: ${endh.text}');
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h,),
                          TextButton(onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => ContactUs(),)),
                              child: Text('השאר פרטים לנציג',style: TextStyle(fontSize: 16.sp),textAlign: TextAlign.center,)),
                          SizedBox(height: 12.h,),
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
                                  print(" location $location");
                                  if(startd.text.isNotEmpty && selectedValue!=null) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            maintainState: false,
                                            builder: (context) =>
                                                SearchCar(
                                                   index: 1,
                                                  location: location,
                                                  latitude: latitude,
                                                  longitude: longitude,
                                                  startDate: rent.startDate,
                                                  endDate: rent.endDate,
                                                )
                                        ));
                                  }
                                  else displayMessage(context,message: 'נא מלא את כל הפרטים');

                                },
                                child: const Text(
                                  'מצא לי רכב זמין',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
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
          }),
        );
      },
      barrierColor: Colors.black12.withOpacity(0.1),
      //isDismissible: false,
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))));
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
    constraints: BoxConstraints(maxWidth: width.w),
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
    barrierDismissible: true,
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
  if(start.difference(end)!=diff){
    displayMessage(context, message: 'שים לב!\nניתן לבצע השכרה לטווח של 6 שעות עגולות בלבד',
      onClose: () {
        Navigator.pop(context);
        /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>SearchCar(location: location,
              latitude: latitude,
              longitude: longitude,
              startDate: start,
              endDate: end,),
        )

      );*/
    }
    );
  }
 /* if(start.difference(end)<diff){
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

  }*/


}
