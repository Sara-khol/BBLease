import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart' as intl;



Future departurePoint(BuildContext context){
  TextEditingController controller=TextEditingController();
  DetailsResult? searchedPlace;

  late GooglePlace googlePlace=GooglePlace('AIzaSyBfvApaTLzPlCzL3LakX6DBbj2l7NMBRV4');
  bool done=false;


  List<AutocompletePrediction> predictions=[];

  Timer? debounce;

  void autoCompleteSearch(String value) async{
    var result= await googlePlace.autocomplete.get(value);
    if(result!=null && result.predictions!=null){
      predictions=result.predictions!;
    }
  }



  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context)=>
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 450.h),
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
                      padding:  EdgeInsets.only(left: 30.w,right: 30.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('מאיפה תרצה לצאת?', style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w700,color: Colors.black),),
                              SizedBox(width: 9.w,),
                              Icon(Icons.fmd_good_outlined,color: Color(0xFFFB2576),size: 28.sp,),
                            ],
                          ),
                          SizedBox(height: 45.h,),
                          TextField(
                            autofocus: true,
                            cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: "",
                              labelStyle:  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w300, color:  const Color.fromRGBO(15, 17, 21, 1), fontFamily: 'PLONI',),
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
                              suffixIcon: Icon(Icons.search,color: Color(0xFF04AEB9),size: 24.sp,)
                            ),
                            style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                            controller: controller,
                            onChanged: (value) {
                              if(debounce?.isActive??false) debounce!.cancel();
                              debounce=Timer(const Duration(seconds: 1),(){
                                if(value.isNotEmpty){
                                  autoCompleteSearch(value);
                                }
                                else{
                                  predictions=[];
                                }
                              });
                            },//=> isTyping=true,
                            onEditingComplete: () {
                              done=true;
                              FocusScope.of(context).unfocus();
                            },

                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 280.h),
                            child: ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              itemCount: predictions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(predictions[index].description.toString()),
                                  onTap: () async {
                                    done = true;
                                    final placeId =predictions[index].placeId!;
                                    final details =await googlePlace.details.get(placeId);
                                    if(details!=null && details.result != null){
                                      searchedPlace=details.result;
                                      controller.text=details.result!.name!;
                                      done=true;
                                    }
                                    predictions=[];
                                  },
                                );
                              }
                            ),
                          ),
                          done?Column(
                            children: [
                              SizedBox(height: 38.h,),
                              Container(
                                width: 332.w,
                                height: 42.h,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25)),
                                  color: Color(0xFF00DEDE),
                                ),
                                child: TextButton(
                                  child: Text('אישור',style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w500),),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    rentalTerm(context);
                                  },
                                ),
                              ),
                              SizedBox(height: 25.h,)
                            ],
                          ):Container(),
                        ],
                      ),
                    ),
                  ],
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



Future rentalTerm(BuildContext context){
  TextEditingController start=TextEditingController();
  TextEditingController end=TextEditingController();

  late DateTime? startDate;
  late DateTime? endDate;
  late double? diff;

  int? selectedValue;

  String searchedPlace='';
  Map<String,double> map={'חצי יום':0.5,'יום':1,'3 ימים':3,'שבוע':7,'חודש':30};
  String? selectedItem;



  return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {

              void _setEndDateBasedOnSelection() {
                if (startDate != null && diff != null) {
                  DateTime calculatedEndDate = startDate!.add(Duration(days: diff!.toInt()));
                  end.text = intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
                  endDate = calculatedEndDate;
                  //setState((){});
                }
              }


              RadioListTile _buildRadioTile(String title, int v) {
                return RadioListTile(
                  value: v,
                  dense: true,
                  title: Text(title,style: TextStyle(fontSize: 18.sp)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(
                    horizontal: VisualDensity.minimumDensity,
                    vertical: VisualDensity.minimumDensity,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      diff = map[title];

                    });
                    if (startDate!=null)
                      _setEndDateBasedOnSelection();
                  },
                  groupValue: selectedValue,
                );
              }


              return Padding(
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
                                  Text('בחר טווח השכרה', style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),),
                                  SizedBox(width: 9.w,),
                                  Icon(
                                    Icons.calendar_today_outlined, color: const Color(0xFFFB2576), size: 24.sp,),
                                ],
                              ),
                              SizedBox(height: 25.h,),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 180.h),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    _buildRadioTile('חצי יום', 1),
                                    _buildRadioTile('יום', 2),
                                    _buildRadioTile('3 ימים', 3),
                                    _buildRadioTile('שבוע', 4),
                                    _buildRadioTile('חודש', 5),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('ממתי ?',
                                      style: TextStyle(fontSize: 20.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black)),
                                ],
                              ),
                              TextFormField(
                                readOnly: true,
                                cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: TextStyle(fontSize: 20.sp,
                                      fontWeight: FontWeight.w300,
                                      color: const Color.fromRGBO(15, 17, 21, 1),
                                      fontFamily: 'PLONI',),
                                    floatingLabelBehavior: FloatingLabelBehavior.auto,
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
                                      color: const Color.fromRGBO(251, 37, 118, 1),
                                      size: 22.sp,)

                                ),
                                //style: const TextStyle(color: Color.fromRGBO(15, 17, 21, 1),),
                                controller: start,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'זהו שדה חובה';
                                  }
                                },
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
                                    textDirection: TextDirection.rtl,
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2100));
                                  if (date != null) {
                                    start.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                    startDate = date;
                                    _setEndDateBasedOnSelection();
                                  }
                                },

                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('עד -', style: TextStyle(fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black)),
                                ],
                              ),
                              TextFormField(
                                readOnly: true,
                                cursorColor: const Color.fromRGBO(15, 17, 21, 1),
                                decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: TextStyle(fontSize: 20.sp,
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
                                      color: const Color.fromRGBO(251, 37, 118, 1),
                                      size: 22.sp,)

                                ),
                                style: const TextStyle(color: Color.fromRGBO(
                                    15, 17, 21, 1),),
                                controller: end,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'זהו שדה חובה';
                                  }
                                },
                                onTap: () async {
                                  DateTime? date = await showDatePicker(
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
                              SizedBox(height: 30.h,),
                              SizedBox(
                                height: 42.h,
                                width: 332.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromRGBO(0, 222, 222, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Container()));
                                    },
                                    child: const Text('אישור', style: TextStyle(
                                        fontSize: 18,
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
        );
      },

      barrierColor: Colors.black12.withOpacity(0.1),
      //isDismissible: false,
      elevation: 2,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)
  );
}

