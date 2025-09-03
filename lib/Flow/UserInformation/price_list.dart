import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../landspace_widget.dart';

class PriceList extends StatefulWidget {
  const PriceList({super.key});

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {

   Map<String, dynamic> priceList={};

  Map<int, String> indexMap={
    1:'price_list',
    2:'extras',
    3:'additional_charges'
  };

   bool initData = false;

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
    super.initState();
  }

   String truncateString(String str) {
     if (str.length > 24) {
       String firstPart = str.substring(0, 7);
       String secondPart = str.substring(13, str.length);
       return '$firstPart.$secondPart';
       //return '${str.substring(0, 22)}...';
     } else {
       return str;
     }
   }

   /*String addNewline(String input) {
     if (input.length > 24) {
       List<String> words = input.split(' ');
       if (words.length > 1) {
         String lastWord = words.removeLast();
         print('${words.join(' ')}\n$lastWord');
         return '${words.join(' ')}\n$lastWord';
       }
     }
     // If the string is 24 characters or shorter, return the original string
     return input;
   }*/

   /*String padStringToLengthFive(String input) {
     if (input.length < 5) {
       return input.padLeft(5,'_');
     } else {
       return input;
     }
   }*/

  int i=1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return LandSpaceWidget(mainWidget: buildContent(orientation),imageProperties:ImageProperties('image3.png', 1000.w,'תמונת מידע נוסף'));
        }
        return buildContent(orientation);
      }),
    );
  }

   buildContent(Orientation o) {
     return Directionality(
       textDirection: TextDirection.rtl,
       child: Padding(
         padding: const EdgeInsets.all(30),
         child: SingleChildScrollView(
           child: Column(
             children: [
               if(o==Orientation.portrait)SizedBox(height: 5.h,),
               Align(
                   alignment: Alignment.centerRight,
                   child: IconButton(onPressed: () => Navigator.pop(context),
                       icon: const Icon(Icons.arrow_back_ios))
               ),
               if(o==Orientation.portrait)SizedBox(height: 30.h,),
               Text('מחירון', textAlign: TextAlign.center,
                   style: TextStyle(
                     fontSize: 22.sp, fontWeight: FontWeight.bold,)),
               SizedBox(height: 30.h,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Container(
                     margin: EdgeInsets.zero,
                     height: 35.h,
                     decoration: ShapeDecoration(
                       color: i == 1 ? blackColorApp : Colors.transparent,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(100),
                       ),
                     ),
                     child: TextButton(
                         onPressed: () => setState(() => i = 1),
                         child: Text('מחירון', style: TextStyle(
                             color: i == 1 ? Colors.white : blackColorApp,
                             fontSize: 18.sp,
                             height: 1))
                     ),
                   ),

                   Container(
                     height: 35.h,
                     decoration: ShapeDecoration(
                       color: i == 2 ? blackColorApp : Colors.transparent,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(100),
                       ),
                     ),
                     child: TextButton(
                         onPressed: () => setState(() => i = 2),
                         child: Text('תוספות', style: TextStyle(
                             color: i == 2 ? Colors.white : blackColorApp,
                             fontSize: 18.sp,
                             height: 1))
                     ),
                   ),

                   Container(
                     height: 35.h,
                     decoration: ShapeDecoration(
                       color: i == 3 ? blackColorApp : Colors.transparent,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(100),
                       ),
                     ),
                     child: TextButton(
                         onPressed: () => setState(() => i = 3),
                         child: Text('חיובים נוספים', style: TextStyle(
                             color: i == 3 ? Colors.white : blackColorApp,
                             fontSize: 18.sp,
                             height: 1))
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 30.h,),
               initData ?
               i == 1 ?
               Column(
                   children: [
                     // Image.network(
                     //   'https://bibilease.co.il/wp-content/uploads/2023/12/Kia-Picanto.png',
                     //   height: 95.h,),
                     SizedBox(height: 10.h,),
                     const Text(' קטן | 5 מקומות ', textAlign: TextAlign.right,),
                     Divider(height: 10.h, color: const Color(0xFF04AEB9),),
                     MediaQuery.removePadding(
                       removeTop: true,
                       context: context,
                       child: ListView.builder(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: priceList['price_list']['A'].length,
                           itemBuilder: (context, index) {
                             iconPath = 'assets/icons/ticket.png';
                             var currentItem = priceList['price_list']['A'];
                             if (currentItem!.values.elementAt(index) != '') {
                               String str = truncateString(currentItem.keys.elementAt(index));
                               return SizedBox(
                                // height: 40.h,
                                 width: 328.w,
                                 //decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9),width: 1))),
                                 child: Row(
                                   children: [
                                     Image.asset(iconPath),
                                     SizedBox(width: 9.w,),
                                     Expanded(child: Text(currentItem.keys.elementAt(index), style: TextStyle(fontSize: 20.sp))),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       children: [
                                         Text(' |', style: TextStyle(
                                             color: const Color(0xFF03AEB9),
                                             fontSize: 24.sp,
                                             fontWeight: FontWeight.w300)),
                                         SizedBox(
                                           width: 50.w,
                                           child: Text(currentItem.values.elementAt(index) ?? '',
                                             style: TextStyle(fontSize: 20.sp),
                                             textDirection: TextDirection.rtl,textAlign: TextAlign.end,),

                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               );
                             }
                             else {
                               return const SizedBox();
                             }
                           }
                       ),
                     ),
                     SizedBox(height: 20.h,),
                     // Image.network('https://bibilease.co.il/wp-content/uploads/2023/12/Opel-Combo.png', height: 95.h,),
                     // SizedBox(height: 10.h,),
                     const Text(' משפחתי | 5 מקומות ', textAlign: TextAlign.right,),
                     Divider(height: 10.h, color: const Color(0xFF04AEB9),),
                     MediaQuery.removePadding(
                       removeTop: true,
                       context: context,
                       child: ListView.builder(
                           shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemCount: priceList['price_list']['B'].length,
                           itemBuilder: (context, index) {
                             iconPath = 'assets/icons/ticket.png';
                             var currentItem = priceList['price_list']['B'];
                             if (currentItem!.values.elementAt(index) != '') {
                               String str = truncateString(currentItem.keys.elementAt(index));
                               //String str = addNewline(currentItem.keys.elementAt(index));
                               //String str1 = padStringToLengthFive(currentItem.values.elementAt(index));
                               //print('$str1 ${str1.length}');
                               return SizedBox(
                                 // height: 40.h,
                                 width: 328.w,
                                 //decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9),width: 1))),
                                 child: Row(
                                   children: [
                                     Image.asset(iconPath),
                                     SizedBox(width: 9.w,),
                                     Expanded(child: Text(currentItem.keys.elementAt(index), style: TextStyle(fontSize: 20.sp))),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.end,
                                       children: [
                                         Text(' |', style: TextStyle(
                                             color: const Color(0xFF03AEB9),
                                             fontSize: 24.sp,
                                             fontWeight: FontWeight.w300)),
                                         SizedBox(
                                           width: 50.w,
                                           child: Text(currentItem.values.elementAt(index)??'',
                                               style: TextStyle(fontSize: 20.sp),
                                               textDirection: TextDirection.rtl,textAlign: TextAlign.end,),

                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               );
                             }
                             else {
                               return const SizedBox();
                             }
                           }
                       ),
                     ),
                     SizedBox(height: 20.h,),
                   ]
               )
               : MediaQuery.removePadding(
                 removeTop: true,
                 context: context,
                 child: ListView.builder(
                   shrinkWrap: true,
                   physics: NeverScrollableScrollPhysics(),
                   itemCount: priceList[indexMap[i]]?.length,
                   itemBuilder: (context, index) {
                     if (i == 2) iconPath = 'assets/icons/bag.png';
                     if (i == 3) iconPath = 'assets/icons/more_price.png';
                     var currentItem = priceList[indexMap[i]];
                     return Container(
                       //height: 50.h,
                       width: 328.w,
                       decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF03AEB9), width: 1))),
                       child: Center(
                         child: Row(
                           children: [
                             Image.asset(iconPath),
                             SizedBox(width: 16.w,),
                             Expanded(
                               child: Text(currentItem!.keys.elementAt(index), style: TextStyle(fontSize: 20.sp)),
                             ),
                             //Spacer(),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Text('|', style: TextStyle(
                                     color: const Color(0xFF03AEB9),
                                     fontSize: 24.sp,
                                     fontWeight: FontWeight.w300)),
                                 SizedBox(
                                   width: 70.w,
                                   child: Text(' ${currentItem!.values.elementAt(
                                       index)}₪',
                                       style: TextStyle(fontSize: 20.sp),
                                       textDirection: TextDirection.rtl
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     );
                   },
                 ),
               )
                   : Center(
                 child: CircularProgressIndicator(
                   color: pinkColorApp,
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }
}
