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

   Map<String, Map<String, int>> priceList={};

  Map<int, String> indexMap={
    1:'מחירון',
    2:'תוספות',
    3:'חיובים נוספים'
  };

  Map<String, Map<String, int>> prices=
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
  };

  getData(){
    ApiService().getPriceList((res) => priceList=res);
  }

  String iconPath='';

  @override
  void initState() {
    //getData();
    priceList=prices;
    super.initState();
  }

  int i=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding:  const EdgeInsets.all(30),
          child: Column(
            children: [
              SizedBox(height: 5.h,),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))
              ),
              SizedBox(height: 42.h,),
              Text('מחירון', textAlign: TextAlign.center, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,)),
              SizedBox(height: 37.h,),
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
              SizedBox(height: 40.h,),
              MediaQuery.removePadding(
                removeTop: true,

                context: context,
                 child: ListView.builder(
                   shrinkWrap: true,
                    itemCount: priceList[indexMap[i]]?.length,
                    itemBuilder: (context, index) {
                      if(i==1) {
                        iconPath='assets/images/ticket.png';
                      }
                      if(i==2) {
                        iconPath='assets/images/bag.png';
                      }
                      if(i==3) {
                        iconPath='assets/images/more.png';
                      }
                      Map<String, int>? currentItem=priceList[indexMap[i]];
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
                            Text('  ${currentItem!.values.elementAt(index)} ₪',
                                style: TextStyle(fontSize: 24.sp),textDirection: TextDirection.rtl
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
