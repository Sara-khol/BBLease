import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/models/car.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:intl/intl.dart' as intel;
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:bblease/screen/car_details.dart';

import '../Flow/Rental/Dialogs.dart';
import '../services/api_service.dart';

class SearchCar extends StatefulWidget {
  const SearchCar({super.key});

  @override
  State<SearchCar> createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {
  List<Car> cars=[];
  final _controller = ScrollController();
  double _currentSliderValue = 3.0;

@override
  void initState() {
  ApiService().getAllCars((car){
    cars = car.map<Car>((entry) => (Car.fromJson(entry))).toList();
    setState(() {
    });
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

  return Scaffold(

    body: Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          SizedBox(height:32.h),
          Directionality(textDirection: TextDirection.ltr,child: AppBarBibilease()),
        SizedBox(height:60.h),
        Text('הי, מצאנו באזורך ${cars.length} רכבים',
          style: TextStyle(
            color: Color(0xFF0F1511),
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),),
        Text('ירמיהו, ירושלים ${intel.DateFormat('dd.MM.yy').format(DateTime.now())} ',
          style: TextStyle(
            color: const Color(0xFF0F1511),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.15,
          ),),
        SizedBox(height: 16.h),//26
        topButtons(context),
        SizedBox(height: 13.h),//23
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cars.length,
          itemBuilder: (context, index) {
            Car car= cars[index];
            final car_id = cars[index].id;
             return GestureDetector(
               onTap: ()=>{Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => CarDetails(car_id))),
                 },
               child: Container(
                 //color: Colors.green,
                 width: 347.w,
                 height: 152.h,
                margin:  EdgeInsets.only(right: 23.w,left: 23.w,bottom: 12.h,),
                 child: Stack(
                   children: [
                     Card(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                       //elevation: 0,
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
                                   Text(car.postName.length > 12 ? '${car.postName.substring(0, 12)}...' : '${car.postName}',style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w700,height: 1,),),
                                  // SizedBox(height: 4.h),
                                   Text('או רכב זהה',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,height: 1.15,),),
                                   //SizedBox(height: 3.h),
                                   Text('נמצא במרחק 0.5ק"מ',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                   Expanded(child: SizedBox(height: 29.h)),

                                   Text('214.90 ₪  |  ליום',style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,height: 1.15,),),
                                   //SizedBox(height: 6.h),
                                   Text('640 ₪  |  סה"כ',style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.w400,height: 1.15,),),
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
      ),),],),

    ),
  );

  }

  topButtons(BuildContext context,)
  {
    return Container(
      //color: Colors.yellow,
      width: 393.w,
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SizedBox(width:48.w,)),
          TextButton(
            onPressed: () => {filterCarType(context,_controller),},
              child: Row(children: [
                Text(
                'סנן',
                style: TextStyle(
                  color: Color(0xFF0F1511),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,

                ),

              ),
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: ImageIcon(AssetImage("assets/images/Filter.png",),color: Color(0xffFB2576),),
              ),
             ], ),),
          //Spacer(),
          //SizedBox(width:33.w,),
          TextButton(  onPressed: () => {rentalTerm(context),},
            child: Row(children: [
              Text(
                ' שנה תאריך ',
                style: TextStyle(
                  color: const Color(0xFF0F1511),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,

                ),
              ),
            SizedBox(
                width: 20.w,
                height:20.h,

                child: ImageIcon(AssetImage("assets/images/Calendar.png"),color: Color(0xffFB2576),)),
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
                  fontSize: 14.sp,
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
  filterCarType(BuildContext context, _controller,){
    return showModalBottomSheet(
      //isScrollControlled: true,
        context: context,
        builder: (BuildContext context)=>
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
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 30.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'סנן לפי סוג הרכב',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF0F1511),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8.w,),
                                ImageIcon(AssetImage("assets/images/Filter.png"),color: Color(0xffFB2576),size: 20.w,),
                              ],
                            ),
                            SizedBox(height: 35.h,),

                          //  SizedBox(height: 30.h,),
                            ],
                          ),
                    Container(
                      //color: Colors.white,
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
                                      ],),),
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
                                      carSearchItem("מיני וואן/VIP"),
                                      carSearchItem("משפחתי+"),
                                    ],),),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  carSearchItem(String name,)  {
    return  Container(
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
              child: Text(
                name,
                style: TextStyle(
                  color: Color(0xFF0F1511),
                  fontSize: 16.sp,
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
    );
  }

  expansionSearch(BuildContext context, _controller,sliderValue){
    return showModalBottomSheet(
      //isScrollControlled: true,

      context: context,
      builder: (BuildContext context)=>
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
              height: 340.h,
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
                              fontSize: 18.sp,
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
                        child: Container(
                          child:Column(
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
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        height: 1,
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        minimumSize: Size(80, 20),
                                        padding: EdgeInsets.all(0)),
                                      onPressed: ()=>{departurePoint(context,),},
                                      child: Text(
                                      'שנה כתובת ',
                                      style: TextStyle(
                                        color: Color(0xFFFB2576),
                                        fontSize: 16.sp,
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
                                'ירמיהו, ירושלים',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF0F1511),
                                  fontSize: 20.sp,
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
                                  fontSize: 16.sp,
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
                                              fontSize: 14,
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
                                  'הוסף 3 ק”מ לטווח החיפוש הנוכחי',
                                  style: TextStyle(
                                    color: Color(0xFF0F1511),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
                                  ),
                                ),
                              ),
                              SizedBox(height: 21.h,),
                              Container(
                                height: 42.h,
                                width: 332.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 222, 222, 1.0),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: (){print('call API');
                                      /*Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const PersonalDetailsForm()));*/
                                    },
                                    child: Text('הצג תוצאות נוספות',
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),)),
                              ),
                            ],
                          ),
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


}