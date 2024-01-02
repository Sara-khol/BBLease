import 'dart:async';

import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/Flow/Rental/map.dart';
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart' as intl;
import 'package:bblease/Flow/Rental/car_details.dart';


import '../../../models/class_rent.dart';
import '../../../services/api_service.dart';
import '../../models/additions.dart';
import '../../models/class_user.dart';
import 'additions_dialog.dart';

class SearchCar extends StatefulWidget {
  SearchCar({super.key, required this.location, required this.latitude, required this.longitude, this.startDate, this.endDate
  });

  String location;
  double? latitude;
  double? longitude;
  DateTime? startDate;
  DateTime? endDate;


  @override
  State<SearchCar> createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {

  List<Car> cars=[];
  Map<String, List<Car>> filteredCarsMap = {};

  final _controller = ScrollController();
  bool showProgressIndicator = true;

   Rental rent=Rental();
  //bool isTapped=false;

  double _currentSliderValue = 3;
  String type='all';

  @override
  void initState()  {
    rent.startDate=widget.startDate!;
    rent.endDate=widget.endDate!;
    getCarsList();
    super.initState();
  }

  @override
  void dispose(){
  _controller.dispose();
    super.dispose();
  }

  getCarsList()  async{
    String start=intl.DateFormat('dd.MM.yyyy').format(widget.startDate!);
    String end=intl.DateFormat('dd.MM.yyyy').format(widget.endDate!);
     await ApiService().getCarsAround(start,end,widget.latitude!,widget.longitude!,_currentSliderValue.toInt()*10,(car){
      cars = car.map<Car>((entry) => (Car.fromJson(entry))).toList();
      setState(() {});
      createMap();
    });
  }
  createMap(){
    filteredCarsMap['all']=cars;
    for (var car in cars) {
      if (filteredCarsMap.containsKey(car.type)) {
        filteredCarsMap[car.type]!.add(car);
      } else {
        filteredCarsMap[car.type] = [car];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Directionality(
      textDirection: TextDirection.rtl,
      child:
      Stack(
        children: [
          Column(
            children: [
            SizedBox(height:32.h),
            Directionality(textDirection: TextDirection.ltr,child: AppBarBibilease()),
            SizedBox(height:60.h),
            Text('הי, מצאנו באזורך ${cars.length} רכבים',style: TextStyle(color: Color(0xFF0F1511), fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.2,),),
            Text('${widget.location}  ${intl.DateFormat('dd.MM.yy').format(widget.startDate!)} ',style: TextStyle(color: const Color(0xFF0F1511), fontSize: 18.sp, fontWeight: FontWeight.w400, height: 1.15,),),
            SizedBox(height: 16.h),//26
            topButtons(context),
            SizedBox(height: 13.h),//23
            cars.isNotEmpty?MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: type=='all'?
              ListView.builder(
                shrinkWrap: true,
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  Car car= cars[index];
                  return GestureDetector(
                    onTap: ()async{
                      /*setState((){
                        isTapped=true;
                      }),*/
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CarDetails(car,startDate: widget.startDate,endDate: widget.endDate,))
                      ),*/
                      await ApiService().getAdditions(car.id, (orderJson) {
                        List<Addition> additions=[];
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
                        setState(() {});
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
                          barrierColor: Colors.black12.withOpacity(0.1),
                          //isDismissible: false,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
                          context: context,
                          builder: (_) => AdditionsDialog(rent: rent, car: car, additionsList: additions),
                        );
                        //extras(context,car,widget.startDate,widget.endDate,additions);
                      });

                    },
                    child: Container(
                      width: 347.w,
                      height: 152.h,
                      margin:  EdgeInsets.only(right: 23.w,left: 23.w,bottom: 12.h,),
                      child: Stack(
                        children: [
                         Card(
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                           shadowColor: Colors.transparent,
                           margin: EdgeInsets.only(left:20.w),
                           color: /*isTapped?Color(0xffEFFFFE):*/Color(0xffF7F7F7),
                           child:Padding(
                             padding:  EdgeInsets.only(bottom: 10.h,top:10.h,right: 14.w,left:11.w),
                             child: IntrinsicHeight(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text(car.model.length > 12 ? '${car.model.substring(0, 12)}...' : '${car.model}',style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w700,height: 1,),),
                                       Text('או רכב זהה',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400,height: 1.15,),),
                                       Text('נמצא במרחק 0.5ק"מ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                       Expanded(child: SizedBox(height: 29.h)),
                                       Text('${car.pricePerDay} ₪  |  ליום',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                       Text('${car.pricePerDay*widget.endDate!.difference(widget.startDate!).inDays} ₪  |  סה"כ',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,height: 1.15,),),
                                     ],
                                   ),
                                   Expanded(child: Padding(
                                     padding:  EdgeInsets.only(top:2.h),
                                     child: Align( alignment: Alignment.topLeft,
                                         child: Icon(Icons.circle,color: Color(0xFF04AEB9),size: 8.w,)),
                                   ),),
                                 ],),
                             ),
                           ),
                          ),
                        IntrinsicHeight(
                           child: Align(
                            alignment: Alignment.bottomLeft,
                             child: Container(
                                 margin: EdgeInsets.only(bottom:10.h),
                                 child: Image.asset('assets/images/car-only.png', )),
                           )
                         ),
                        ],
                     ),
                   ),
                 );
                },
              )
              :filteredCarsMap[type]!=null?
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredCarsMap[type]!.length,
                itemBuilder: (context, index) {
                  Car car= filteredCarsMap[type]![index];
                  return GestureDetector(
                    onTap: ()async{
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CarDetails(car,startDate: widget.startDate,endDate: widget.endDate,))
                      ),*/
                      await ApiService().getAdditions(car.id, (orderJson) {
                        List<Addition> additions=[];
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
                        setState(() {});
                        showModalBottomSheet(
                          isScrollControlled: true,
                          isDismissible: false,
                          barrierColor: Colors.black12.withOpacity(0.1),
                          //isDismissible: false,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
                          context: context,
                          builder: (_) => AdditionsDialog(rent: rent, car: car, additionsList: additions),
                        );
                        //extras(context,car,widget.startDate,widget.endDate,additions,rent);
                      });
                    },
                    child: Container(
                      width: 347.w,
                      height: 152.h, margin:  EdgeInsets.only(right: 23.w,left: 23.w,bottom: 12.h,),
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            shadowColor: Colors.transparent,
                            margin: EdgeInsets.only(left:20.w),
                            color: Color(0xffF7F7F7),
                            child:Padding(
                              padding:  EdgeInsets.only(bottom: 10.h,top:10.h,right: 14.w,left:11.w),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(car.model.length > 12 ? '${car.model.substring(0, 12)}...' : '${car.model}',style: TextStyle(fontSize: 34.sp, fontWeight: FontWeight.w700,height: 1,),),
                                        Text('או רכב זהה',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400,height: 1.15,),),
                                        Text('נמצא במרחק 0.5ק"מ',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                        Expanded(child: SizedBox(height: 29.h)),
                                        Text('${car.pricePerDay} ₪  |  ליום',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                        Text('${car.pricePerDay*widget.endDate!.difference(widget.startDate!).inDays} ₪  |  סה"כ',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,height: 1.15,),),
                                      ],
                                    ),
                                    Expanded(child: Padding(
                                      padding:  EdgeInsets.only(top:2.h),
                                      child: Align( alignment: Alignment.topLeft,
                                          child: Icon(Icons.circle,color: Color(0xFF04AEB9),size: 8.w,)),
                                    ),),
                                  ],),
                              ),
                            ),
                          ),
                          IntrinsicHeight(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    margin: EdgeInsets.only(bottom:10.h),
                                    child: Image.asset('assets/images/car-only.png', )),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) :Text('לא נמצאו תוצאות עבור: ${type}')
              ,):
            Center(
              child: FutureBuilder(
                future: Future.delayed(Duration(seconds: 7)),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // If the Future is still running, show the progress indicator
                    return CircularProgressIndicator();
                  } else {
                    // If the Future is complete, update the UI accordingly
                    return Text('לא נמצאו רכבים באזורך');
                  }
                },
              ),
            ),
      ]
    ),
          Align(
            alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                color: Colors.white.withOpacity(0.6),))
        ],
      )
    ),
  );
  }

  topButtons(context) {
    return Container(
      //color: Colors.yellow,
      width: 393.w,
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width:25.w,),
          TextButton(
            onPressed: () => {filterCarType(context,_controller),},
              child: Row(children: [
                Text(
                'סנן ',
                style: TextStyle(
                  color: Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),

              ),
              Icon(Icons.filter_alt_outlined,color: Color(0xffFB2576),size: 20.sp,),
             ], ),),
          //Spacer(),
          //SizedBox(width:33.w,),
          TextButton(  onPressed: () => {rentalTerm(context, )},
            child: Row(children: [
              Text(
                ' שנה תאריך  ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,

                ),
              ),
            SizedBox(
                width: 20.w,
                height:20.h,
                child: Icon(Icons.edit_calendar_outlined,color: Color(0xffFB2576),size: 20.sp,)),
            ],
            ),),
          //Spacer(),
         // SizedBox(width:30.w,),
          TextButton(  onPressed: () => {expansionSearch(context,_controller,  _currentSliderValue ,),},
            child: Row(children: [
              Text(
                ' הגדל טווח חיפוש ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,

                ),
              ),
              SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: ImageIcon(AssetImage("assets/images/expansion.png"),color: Color(0xffFB2576),)),
            ],
            ),),
          Expanded(child: SizedBox(width:48.w,)),
      ],),
    );
  }

  filterCarType( context, _controller,){
    return showModalBottomSheet(
      //isScrollControlled: true,
        context: context,
        builder: ( context)=>
            Directionality(
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
                height: 312.h,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        // padding: EdgeInsets.zero,
                        // constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
                        iconSize: 20.w,
                        icon: const Icon( Icons.close,
                        ),
                        onPressed: ()=> {  Navigator.pop(context),},
                      ),
                    ),
                    Container(
                       padding: EdgeInsets.only(top:8.5.h,),
                      width:393.w,
                      //height: 195.h,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 65.w,right: 65.w),
                        child: Container(
                         // color:Colors.green,
                          width:263.w,
                          height: 312.h,
                          child: Scrollbar(
                            controller: _controller,
                            thumbVisibility: true,
                            radius: const Radius.circular(10),
                            scrollbarOrientation:ScrollbarOrientation.top ,
                            child: ListView(
                              controller: _controller,
                              //defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                              scrollDirection: Axis.horizontal,
                              // border: TableBorder.all(width:4.w,color: Colors.red),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left:25.w,bottom: 5.h),
                                  child: Container(
                                    height: 312.h,
                                    width: 119.w,
                                    //color:Colors.yellow,
                                    child:Column(
                                      children:[
                                        SizedBox(height:78.5.h,),
                                        carSearchItem("מיני"),
                                        carSearchItem("משפחתי"),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:25.w,bottom: 5.h),
                                  child: Container(
                                    height: 195.h,
                                    width: 119.w,
                                    child:Column(
                                      children:[
                                        SizedBox(height:78.5.h,),
                                        carSearchItem("ג'יפון"),
                                        carSearchItem("היברידי/חשמלי"),
                                      ],),),
                                ),
                                Container(
                                  height: 195.h,
                                  width: 119.w,
                                  child:Column(
                                    children:[
                                      SizedBox(height:78.5.h,),
                                      carSearchItem("VIP"),
                                      carSearchItem("משפחתי+"),
                                    ],),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 100.w,),
                            Text(
                              'סנן לפי סוג הרכב',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF0F1511),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w,),
                            Icon(Icons.filter_alt_outlined,color: Color(0xffFB2576),size: 24.w,),
                            Spacer(),
                            TextButton(
                              style: TextButton.styleFrom(
                                  minimumSize: Size(80, 20),
                                  padding: EdgeInsets.all(0)),
                              onPressed: ()=> {
                                setState(() => type = 'all'),
                                Navigator.pop(context),
                              },
                              child: Text(
                                'נקה סינון',
                                style: TextStyle(
                                  color: Color(0xFFFB2576),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  height: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 34.w,),
                          ],
                        ),
                        SizedBox(width: 34.w,),
                        //SizedBox(height: 10.h,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        barrierColor: Colors.white10.withOpacity(0.1),
        isDismissible: true,
        elevation: 2,
    );
  }

  carSearchItem(String name,)  {
    return  GestureDetector(
      onTap: () {
        setState(() {
          type=name;
          Navigator.pop(context);
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5.h,),
        width:119.w,
        height: 95.h,
         //color: Colors.blue,
         child: Padding(
           padding:  EdgeInsets.only(top:8.h,bottom: 6.h),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(left: 9.w,),
                child: Text(name,
                  style: TextStyle(
                    color: Color(0xFF0F1511),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            //  SizedBox(height: 13.h,),
              Padding(
                padding: EdgeInsets.only(left:4.w,),
                child: Image.asset('assets/images/car-only.png',width: 115.w,height: 50.h, ),
              ),
            //  SizedBox(height: 6.h,),
            ],
        ),
         ),
      ),
    );
  }

  expansionSearch( context, _controller,sliderValue){
    return showModalBottomSheet(
      //isScrollControlled: true,

      context: context,
      builder: ( context)=>
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: ShapeDecoration(
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
              height: 365.h,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      // padding: EdgeInsets.zero,
                      // constraints: const BoxConstraints(minWidth: 20, maxWidth: 20),
                      iconSize: 20.w,
                      icon: const Icon( Icons.close,),
                      onPressed: ()=> {  Navigator.pop(context),},
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'הגדל טווח חיפוש',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0F1511),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
                              //height: 1,
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          ImageIcon(AssetImage("assets/images/expansion.png"),color: Color(0xffFB2576),size: 20.w,),
                        ],
                      ),
                      SizedBox(height: 23.h,),
                      Padding(
                        padding:  EdgeInsets.only(right: 31.w,left:30.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //color: Colors.red,
                              height: 20.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                'אזור חיפוש נוכחי: ',
                                    style: TextStyle(
                                      color: Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(80, 20),
                                      padding: EdgeInsets.all(0)),
                                    onPressed: ()=>{departurePoint(context,widget.location,1,widget.startDate,widget.endDate),},
                                    child: Text(
                                    'שנה כתובת ',
                                    style: TextStyle(
                                      color: Color(0xFFFB2576),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      height: 1,

                                    ),
                                  ),),

                                ],
                              ),
                            ),
                            SizedBox(height: 8.h,),
                            Text(
                              widget.location,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF0F1511),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                height: 1,
                              ),
                            ),
                            SizedBox(height: 21.h,),
                            Text(
                              'הזז את הסמן למרחק הרצוי',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color(0xFF0F1511),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                             SizedBox(height: 30.h,),
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: StatefulBuilder(
                                builder: (context,state) {
                                  return SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        showValueIndicator: ShowValueIndicator.always,
                                        valueIndicatorColor: Color(0xFF00DEDE), // This is what you are asking for
                                        inactiveTrackColor: Color(0xFFF6F6F6), // Custom Gray Color
                                        activeTrackColor: Color(0xFF00DEDE),
                                        thumbColor: Color(0xFF00DEDE),
                                        trackHeight: 8.0,
                                        overlayColor: Color(0xFFF6F6F6),  // Custom Thumb overlay Color
                                        thumbShape:RoundSliderThumbShape(enabledThumbRadius: 10.0),
                                        overlayShape:
                                        RoundSliderOverlayShape(overlayRadius: 10.0),
                                          valueIndicatorTextStyle:TextStyle(
                                            color: Color(0xFF0F1511),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'PLONI',
                                          ),
                                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                                       // thumbShape: CustomSliderThumbCircle(thumbRadius: 20, min: 0, max: 100),
                                      ),
                                    child: Slider(
                                      value: _currentSliderValue,
                                      max: 10,
                                      //divisions: 10,
                                      label: _currentSliderValue.round().toString(),
                                      onChanged: (double value) {
                                        state(() {
                                          _currentSliderValue = value;
                                        });

                                      },
                                    ),
                                  );
                                }
                              ),
                            ),
                            SizedBox(height: 19.h,),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'הוסף $_currentSliderValue ק”מ לטווח החיפוש הנוכחי',
                                style: TextStyle(
                                  color: Color(0xFF0F1511),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1,
                                ),
                              ),
                            ),
                            SizedBox(height: 21.h,),
                            Container(
                              height: 48.h,
                              width: 332.w,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                  onPressed: (){
                                    //TODO: call API
                                    print('call API');
                                    Navigator.pop(context);
                                  },
                                  child: Text('הצג תוצאות נוספות',
                                    style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500),)),
                            ),
                          ],
                        ),
                        ),

                      //  SizedBox(height: 30.h,),
                    ],
                  ),
                ],
              ),
            ),
          ),
      barrierColor: Colors.white10.withOpacity(0.1),
      isDismissible: true,
      elevation: 5,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)

    );
  }

  rentalTerm( context){

    TextEditingController start=TextEditingController(text: intl.DateFormat('dd.MM.yyyy').format(widget.startDate!));
    TextEditingController end=TextEditingController(text: intl.DateFormat('dd.MM.yyyy').format(widget.endDate!));

    double? diff;

    int? selectedValue;

    String searchedPlace='';
    Map<String,double> map={'חצי יום':0.5,'יום':1,'3 ימים':3,'שבוע':7,'חודש':30};
    String? selectedItem;

    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: ( context) {
          return StatefulBuilder(
              builder: ( context, StateSetter setState) {

                void _setEndDateBasedOnSelection() {
                  if (widget.startDate != null && diff != null) {
                    DateTime calculatedEndDate = widget.startDate!.add(Duration(days: diff!.toInt()));
                    end.text = intl.DateFormat('dd.MM.yyyy').format(calculatedEndDate);
                    widget.endDate = calculatedEndDate;
                    rent.startDate=widget.startDate!;
                    rent.endDate=widget.endDate!;
                    setState((){});
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
                      });
                      if (widget.startDate != null)
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
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),),
                                    SizedBox(width: 9.w,),
                                    Icon(
                                      Icons.calendar_today_outlined, color: const Color(0xFFFB2576), size: 24.sp,),
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
                                        color: const Color.fromRGBO(251, 37, 118, 1),
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
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      start.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                      print('start: ${start.text}');
                                      widget.startDate = date;
                                      _setEndDateBasedOnSelection();
                                    }
                                  },

                                ),
                                SizedBox(height: 20.h,),
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
                                        color: const Color.fromRGBO(251, 37, 118, 1),
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
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100));
                                    if (date != null) {
                                      end.text = intl.DateFormat('dd.MM.yyyy').format(date);
                                    }
                                    widget.endDate = date!;
                                  },
                                ),
                                SizedBox(height: 24.h,),
                                SizedBox(
                                  height: 48.h,
                                  width: 332.w,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(0, 222, 222, 1),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),
                                      ),
                                      onPressed: () {
                                        //setState((){});
                                        Navigator.pop(context);

                                      },
                                      child: const Text('אישור', style: TextStyle(
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
          );
        },

        barrierColor: Colors.black12.withOpacity(0.1),
        //isDismissible: false,
        elevation: 2,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),)
    );
  }


}