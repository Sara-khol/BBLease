import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class BenefitsAndPromotions extends StatefulWidget {
  const BenefitsAndPromotions({Key? key}) : super(key: key);

  @override
  State<BenefitsAndPromotions> createState() => _BenefitsAndPromotionsState();


}

class _BenefitsAndPromotionsState extends State<BenefitsAndPromotions> {


   var/*List<Map<String, String>>*/ promotions=[/*{'':''}*/];
   bool initData = false;

  getPromotions(){
    ApiService().getPromotions((res) {
      promotions = res;
      initData=true;
      setState(() {});
    });
  }

  @override
  void initState() {
    getPromotions();
    super.initState();
  }


  @override
  Widget build(BuildContext context,) {
    return Scaffold(
       body: Directionality(
         textDirection: ui.TextDirection.rtl,
         child: Column(
           //mainAxisSize: MainAxisSize.max,
           children: [
             SizedBox(height: 24.h,),
             Padding(
               padding:  EdgeInsets.only(right: 23.w),
               child: Align(
                   alignment: Alignment.topRight,
                   child: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
             ),
             SizedBox(height: 42.h,),
             Column(
              // mainAxisSize: MainAxisSize.max,
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text('הטבות ומבצעים', style: TextStyle(color: Color(0xFF0F1511), fontSize: 22.sp, fontWeight: FontWeight.bold,),),
                 SizedBox(height: 50.h,),
                 initData
                   ? promotions.isNotEmpty
                   ? MediaQuery.removePadding(
                     removeTop: true,
                     context: context,
                     child:
                       ListView.builder(
                        shrinkWrap: true,
                        itemCount: promotions.length,
                        //padding: EdgeInsets.only(bottom: 8.h),
                        itemBuilder: (context, index) {
                          //Rental rent = ordersHistory[index];
                          return Column(
                              children: [
                                Container(
                                    width: 332.w,
                                    height: 68,
                                    margin: EdgeInsets.only(left: 14.w,right: 14.w),
                                    decoration: ShapeDecoration(
                                        color: Color(0xFFF6F6F6),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x993ED4D4),
                                          blurRadius: 10,
                                          offset: Offset(0, 0),
                                          spreadRadius: 2,
                                        )
                                      ],),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text('בתוקף עד: ${promotions[index]['end-promo']}',
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black
                                               ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              ImageIcon(const AssetImage('assets/icons/gift.png'),color: turquoiseColorApp,),
                                              //SizedBox(width: 13.w,),
                                              VerticalDivider(thickness: 2,width: 13,color: turquoiseColorApp, endIndent: 16.h,),
                                              Text(
                                                promotions[index]['name-promo']!,
                                                style: TextStyle(
                                                    fontSize: 24.sp,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 20.h,)
                              ],
                            );
                        },
                                              )
                 )
                 : Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     Image.asset("assets/images/date_bad.png"),
                     SizedBox(height: 12.h,),
                     Text('אופס...\nכרגע אין הטבות\nומבצעים פעילים',style: TextStyle(color: Color(0xFFAAABAA), fontSize: 20.sp, fontWeight: FontWeight.normal,),),
                   ],
                 )
                 : Center(
                   child: CircularProgressIndicator(
                     color: pinkColorApp,
                   ),
                 ),

                 // Text('השארו מעודכנים וגלו מה חדש',style: TextStyle(color: Color(0xFF0F1511), fontSize: 18.sp, fontWeight: FontWeight.normal,),),
               ],
             ),
           ],
         ),
       ),
    );
  }
}
