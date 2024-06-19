import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {

   Map<String, dynamic> priceList={/*"": {"": {"": "",},"": {"":"",}},"": {"":"",},"": { "": "",}*/};

  Map<int, String> indexMap={
    1:'price_list',
    2:'extras',
    3:'additional_charges'
  };

   bool initData = false;

  /*Map<String, Map<String, String>> prices=
  {
    'מחירון':{
      'איחור בהחזרה':100,
      'איחור':100,
      'איחור בהח':100,
      'ר בהחזרה':100,
    },
    'תוספות':{
      'איחור בהחזרה':100,
      'איחור':100,
      'איחור בהח':100,
      'ר בהחזרה':100,
    },
    'חיובים נוספים':{
      'איחור בהחזרה':100,
      'איחור':100,
      'איחור בהח':100,
      'ר בהחזרה':100,
    },
  };*/

  getData(){
    ApiService().getPriceList((res) {
      priceList = res;
      initData=true;
      setState(() {});
    });
  }

  String iconPath='';

  @override
  void initState() {
    getData();
    //priceList=prices;
    super.initState();
  }


   String truncateString(String str) {
     if (str.length > 25) {
       //int partLength = (25 - 3) ~/ 2;
       String firstPart = str.substring(0, 7);
       String secondPart = str.substring(13, str.length);
       return firstPart + '.' + secondPart;
       //return str.substring(0, 21) + '...';
     } else {
       return str;
     }
   }

  int i=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding:  const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5.h,),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
                ),
                SizedBox(height: 30.h,),
                Text('מחירון', textAlign: TextAlign.center, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,)),
                SizedBox(height: 30.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: i==1?blackColorApp:Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () =>setState(() => i=1),
                        child: Text('מחירון',style: TextStyle(color: i==1?Colors.white:blackColorApp,fontSize: 18.sp,height: 1))
                      ),
                    ),

                    Container(
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: i==2?blackColorApp:Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () =>setState(() => i=2),
                          child: Text('תוספות',style: TextStyle(color: i==2?Colors.white:blackColorApp,fontSize: 18.sp,height: 1))
                      ),
                    ),

                    Container(
                      height: 35.h,
                      decoration: ShapeDecoration(
                        color: i==3?blackColorApp:Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () =>setState(() => i=3),
                          child: Text('חיובים נוספים',style: TextStyle(color: i==3?Colors.white:blackColorApp,fontSize: 18.sp,height: 1))
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h,),
                initData?
                  i==1?
                      Column(
                        children: [
                          Image.network('https://bibilease.quicksolutions.co.il/wp-content/uploads/2023/12/Kia-Picanto.png',height: 95.h,),
                          SizedBox(height: 10.h,),
                          Text(' קטן | 5 מקומות ',textAlign: TextAlign.right,),
                          Divider(height: 10.h,color: Color(0xFF04AEB9),),
                          MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: priceList['price_list']['A'].length,
                              itemBuilder: (context, index) {
                                iconPath = 'assets/images/ticket.png';
                                var currentItem = priceList['price_list']['A'];
                                if (currentItem!.values.elementAt(index) != '') {
                                  String str=truncateString(currentItem.keys.elementAt(index));
                                  return SizedBox(
                                    height: 40.h,
                                    width: 328.w,
                                    //decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9),width: 1))),
                                    child: Row(
                                      children: [
                                        Image.asset(iconPath, width: 24.w,),
                                        SizedBox(width: 9.w,),
                                        Text(str, style: TextStyle(fontSize: 20.sp)),
                                        Spacer(),
                                        Text('  | ', style: TextStyle(color: Color(0xFF03AEB9), fontSize: 24.sp, fontWeight: FontWeight.w300)),

                                        Text(currentItem.values.elementAt(index), style: TextStyle(fontSize: 20.sp), textDirection: TextDirection.rtl),
                                      ],
                                    ),
                                  );
                                }
                                else
                                  return SizedBox();
                              }
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Image.network('https://bibilease.quicksolutions.co.il/wp-content/uploads/2023/12/Opel-Combo.png',height: 95.h,),
                          SizedBox(height: 10.h,),
                          Text(' משפחתי | 5 מקומות ',textAlign: TextAlign.right,),
                          Divider(height: 10.h,color: Color(0xFF04AEB9),),
                          MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: priceList['price_list']['B'].length,
                                itemBuilder: (context, index) {
                                  iconPath = 'assets/images/ticket.png';
                                  var currentItem = priceList['price_list']['B'];
                                  if (currentItem!.values.elementAt(index) != '') {
                                    String str=truncateString(currentItem.keys.elementAt(index));
                                    return SizedBox(
                                      height: 40.h,
                                      width: 328.w,
                                      //decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9),width: 1))),
                                      child: Row(
                                        children: [
                                          Image.asset(iconPath, width: 24.w,),
                                          SizedBox(width: 9.w,),
                                          Text(str, style: TextStyle(fontSize: 20.sp)),
                                          Text('  | ', style: TextStyle(color: Color(0xFF03AEB9), fontSize: 24.sp, fontWeight: FontWeight.w300)),
                                          Text(currentItem.values.elementAt(index), style: TextStyle(fontSize: 20.sp), textDirection: TextDirection.rtl),
                                        ],
                                      ),
                                    );
                                  }
                                  else
                                    return SizedBox();
                                }
                            ),
                          ),
                          SizedBox(height: 20.h,),
                        ]
                      )
                  :MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                   child: ListView.builder(
                     shrinkWrap: true,
                      itemCount: priceList[indexMap[i]]?.length,
                      itemBuilder: (context, index) {
                        if(i==2) {
                          iconPath='assets/images/bag.png';
                        }
                        if(i==3) {
                          iconPath='assets/images/more.png';
                        }
                        var currentItem=priceList[indexMap[i]];
                        return Container(
                          height: 50.h,
                          width: 328.w,
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9),width: 1))),
                          child: Row(
                            children: [
                              Image.asset(iconPath,width: 24.w,),
                              SizedBox(width: 16.w,),
                              Text(currentItem!.keys.elementAt(index),style: TextStyle(fontSize: 24.sp)),
                              Spacer(),
                              Text('|',style:TextStyle(color: Color(0xFF03AEB9),fontSize: 24.sp,fontWeight: FontWeight.w300)),
                              Text('  ${currentItem!.values.elementAt(index)} ₪', style: TextStyle(fontSize: 24.sp),textDirection: TextDirection.rtl
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                )
                :Center(
                  child: CircularProgressIndicator(
                    color: pinkColorApp,
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
