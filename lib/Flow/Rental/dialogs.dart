import 'dart:async';

import 'package:bblease/Flow/Rental/car_details.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/Flow/Rental/search_car.dart';
import 'package:bblease/models/class_user.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
import 'package:bblease/utils/my_colors.dart' as colors;
import 'package:intl/intl.dart' as intl;

import '../../models/class_rent.dart';


double? latitude;
double? longitude;
String location='';
//late DateTime startDate,endDate;
Rental rent=Rental();


Future departurePoint(context ,address, nav, [sdate,edate]) {
  print('dialog address: $address');


  TextEditingController controller=TextEditingController(/*text: address*/);
  DetailsResult? searchedPlace;

  late GooglePlace googlePlace=GooglePlace('AIzaSyBfvApaTLzPlCzL3LakX6DBbj2l7NMBRV4');
  bool done=false;

  List<AutocompletePrediction> predictions=[];

  Timer? debounce;

  void autoCompleteSearch(String value) async {
    var result= await googlePlace.autocomplete.get(value);
    if(result!=null && result.predictions!=null){
      predictions=result.predictions!;
    }
  }

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context)=>
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
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
                    // Container(
                    //   alignment: Alignment.topRight,
                    //   child: IconButton(
                    //     icon: const Icon(Icons.close),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),

                 child:   Padding(
                      padding:  EdgeInsets.only(left: 30.w,right: 30.w,top:20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('מאיפה תרצה לצאת?', style: TextStyle(fontSize: 26.sp,fontWeight: FontWeight.w700,color: Colors.black),),
                              SizedBox(width: 9.w,),
                              Icon(Icons.fmd_good_outlined,color: colors.pinkColorApp,size: 28.sp,),
                            ],
                          ),
                          SizedBox(height: 45.h,),
                          TextField(
                            autofocus: true,
                            cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "",
                              labelStyle:  TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400, color:  const Color.fromRGBO(15, 17, 21, 1), fontFamily: 'PLONI',),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0,),
                                borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 17, 21, 1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0,),
                                borderSide: const BorderSide(
                                color: Color.fromRGBO(15, 17, 21, 1),
                                ),
                              ),
                              suffixIcon: Icon(Icons.search,color: colors.turquoiseColorApp,size: 24.sp,)
                            ),
                            style: TextStyle(color: Color.fromRGBO(15, 17, 21, 1),fontSize: 20.sp),
                            controller: controller,
                            onChanged: (value) {
                              if(debounce?.isActive??false) debounce!.cancel();
                              debounce=Timer(const Duration(milliseconds: 300),(){
                                if(value.isNotEmpty){
                                  autoCompleteSearch(value);
                                }
                                else predictions=[];
                              });
                            },//=> isTyping=true,
                            onEditingComplete: () {
                              done=true;
                              FocusScope.of(context).unfocus();
                            },

                          ),
                          predictions.isNotEmpty?
                          Expanded(
                            child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: predictions.length,
                                itemBuilder: (context, index) {
                                  AutocompletePrediction prediction=predictions[index];
                                  return ListTile(

                                    title: Text(prediction.description.toString(),style: TextStyle(fontSize: 20.sp),),
                                    onTap: () async {
                                      debugPrint(prediction.description);
                                      done = true;
                                      final placeId =prediction.placeId!;
                                      debugPrint('placeId $placeId');
                                      final details =await googlePlace.details.get(placeId);
                                      if(details!=null && details.result != null){
                                        debugPrint('details ${details.result}');

                                        searchedPlace=details.result;
                                        controller.text=details.result!.name!;
                                        location=controller.text;
                                        latitude = searchedPlace!.geometry!.location!.lat;
                                        longitude = searchedPlace!.geometry!.location!.lng;
                                        print('$latitude . $longitude');
                                        done=true;
                                      }
                                      predictions=[];
                                    },
                                  );
                                }
                            ),
                          ):Spacer(),
                          done?Column(
                            children: [
                              SizedBox(height: 32.h,),
                              Container(
                                width: 332.w,
                                height: 48.h,
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  color: colors.turquoiseColorApp,
                                ),
                                child: TextButton(
                                  child: Text('אישור',style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.w500),),
                                  onPressed: () {
                                    //Navigator.pop(context);
                                    nav==0?rentalTerm(context):
                                        Navigator.push(context,
                                          //  MaterialPageRoute(builder: (context) => SearchCar(location: location, latitude: latitude, longitude: longitude,startDate: sdate,endDate: edate),))
                                            MaterialPageRoute(builder: (context) => SearchCar(location: 'ירושלים', latitude: 31.803110, longitude: 35.216148,startDate: sdate,endDate: edate),))
                                    ;
                                  },
                                ),
                              ),
                              SizedBox(height: 25.h,)
                            ],
                          ):Container(),
                        ],
                      ),

                ),
              ),
            ),
          ),
      barrierColor: Colors.black12.withOpacity(0.1),
      //isDismissible: false,
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)

  );
}


Future rentalTerm( context, [s,e]){

  TextEditingController start=TextEditingController();
  TextEditingController end=TextEditingController();

   DateTime? startDate;
   DateTime? endDate;
   double? diff;
   if(s!=null&&e!=null){
     start.text=intl.DateFormat('dd.MM.yyyy').format(s);
     end.text=intl.DateFormat('dd.MM.yyyy').format(e);

     startDate=s;
     endDate=e;
   }

  int? selectedValue;
  int? selectedPart;

  Map<String,double> map={'חצי יום':0.5,'יום':1,'שבוע':7,'חודש':30};

  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: ( context) {
        return StatefulBuilder(
            builder: ( context, StateSetter setState) {

              _setEndDateBasedOnSelection() {
                if (startDate != null && diff != null) {
                  DateTime calculatedEndDate = startDate!.add(Duration(days: diff!.toInt()-1));
                  calculatedEndDate=calculatedEndDate.add(Duration(days: 1));
                  end.text = intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
                  endDate = calculatedEndDate;

                  rent.startDate=startDate!;
                  rent.endDate=endDate!;

                  //setState((){});
                }
              }

              RadioListTile _buildRadioTile(String title, int v) {
                return RadioListTile(
                  value: v,
                  dense: true,
                  title: Text(title,style: TextStyle(fontSize: 20.sp)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      diff = map[title];
                      selectedPart=-1;
                    });
                    if (startDate != null)
                      _setEndDateBasedOnSelection();
                  },
                  groupValue: selectedValue,
                );
              }


              RadioListTile _buildRadioTile2(String title, int v) {
                return RadioListTile(
                  value: v,
                  dense: true,
                  title: Text(title,style: TextStyle(fontSize: 20.sp)),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
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
                child: SingleChildScrollView(
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
                                    Text('בחר טווח השכרה', style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),),
                                    SizedBox(width: 9.w,),
                                    Icon(
                                      Icons.calendar_today_outlined, color: colors.pinkColorApp, size: 24.sp,),
                                  ],
                                ),
                                SizedBox(height: 15.h,),
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
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('ממתי ?',
                                        style: TextStyle(fontSize: 22.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black)),
                                  ],
                                ),
                                TextFormField(
                                  readOnly: true,
                                  cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                  decoration: InputDecoration(
                                      isDense: true,
                                      labelStyle: TextStyle(fontSize: 22.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromRGBO(15, 17, 21, 1),
                                        fontFamily: 'PLONI',),
                                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0,),
                                        borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0,),
                                        borderSide: const BorderSide(color: Color.fromRGBO(15, 17, 21, 1),),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 20.h),
                                      suffixIcon: Icon(
                                        Icons.calendar_today_outlined,
                                        color: colors.pinkColorApp,
                                        size: 22.sp,)
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
                                      start.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                      print('start: ${start.text}');
                                      startDate = date;
                                      _setEndDateBasedOnSelection();
                                    }
                                  },

                                ),
                                SizedBox(height: 20.h,),
                                Visibility(
                                  visible: selectedValue!=1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('עד -', style: TextStyle(fontSize: 22.sp,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black)),
                                        ],
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                        decoration: InputDecoration(
                                            isDense: true,
                                            labelStyle: TextStyle(fontSize: 22.sp,
                                              fontWeight: FontWeight.w300,
                                              color: const Color.fromRGBO(15, 17, 21, 1),
                                              fontFamily: 'PLONI',),
                                            floatingLabelBehavior: FloatingLabelBehavior
                                                .auto,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                10.0,),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(15, 17, 21, 1),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                10.0,),
                                              borderSide: const BorderSide(
                                                color: Color.fromRGBO(15, 17, 21, 1),
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(
                                                vertical: 12.w, horizontal: 20.h),
                                            suffixIcon: Icon(
                                              Icons.calendar_today_outlined,
                                              color: colors.pinkColorApp,
                                              size: 22.sp,)

                                        ),
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
                                            end.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                          }
                                          endDate = date;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: selectedValue==1,
                                child: Container(
                                  //color: Colors.yellow,
                                  height: 100.h,
                                  width: 300.w,
                                  child: Column(
                                    children: [
                                      _buildRadioTile2('8:00-17:00 בוקר ',1),
                                      _buildRadioTile2('17:00-8:00 לילה',2),
                                    ],
                                  ),
                                )
                                ),
                                SizedBox(height: 24.h,),
                                SizedBox(
                                  height: 48.h,
                                  width: 332.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colors.turquoiseColorApp,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                maintainState:false,
                                                builder: (context) => SearchCar(location: location,
                                                  latitude: latitude,
                                                  longitude:longitude,
                                                  startDate: startDate,
                                                  endDate: endDate,
                                                  part: selectedPart??-1,
                                                )
                                            /*  (location: 'ירושלים',
                                                  latitude: 31.803110,
                                                  longitude: 35.216148,
                                                startDate: startDate,
                                                endDate: endDate,
                                                  part: selectedPart??-1,
                                           )*/
                                            ));
                                      },
                                      child: const Text('אישור', style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,color:Colors.white),)),
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
        );
      },

      barrierColor: Colors.black12.withOpacity(0.1),
      //isDismissible: false,
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)))
  );
}




Future showLoading(BuildContext context) {
 return showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor:  Colors.black12.withOpacity(0.2),
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: pinkColorApp,
        ),
      );
    },
  );
}

