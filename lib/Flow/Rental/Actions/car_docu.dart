import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


class CarDocu extends StatefulWidget {
  const CarDocu({Key? key}) : super(key: key);

  @override
  State<CarDocu> createState() => _CarDocuState();
}

class _CarDocuState extends State<CarDocu> {

  late List<XFile?> images;
  bool allLoaded=false;
  @override
  void initState() {
    // TODO: implement initState
    images = List<XFile?>.generate(4, (index) => null);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
        padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,/*left: 30.w,right: 30.w*/),
            child: Column(
                children: [
                  SizedBox(height: 35.h,),
                  Align(alignment: Alignment.centerRight,
                      child: IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
                  SizedBox(height: 62.h,),
                  Text('תיעוד רכב',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  SizedBox(height: 36.h,),
                  Text('\nמומלץ תמיד לתעד את הרכב\nבתחילת הנסיעה!!\n', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,),),
                  Text('אם ישנם נזקים , נדע לא לחייב אתכם עליהם', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400,),),
                  Text(' \n\nנסיעה בטוחה :)', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,),),
                  SizedBox(height: 57.h,),
                  ImageIcon(AssetImage("assets/icons/heart.png"),size: 26.w,color: turquoiseColorApp,),
                  SizedBox(height: 8.h,),
                  Text('צלמו תמונה חדה וברורה!',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  SizedBox(height: 25.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:70.w),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                            children: [
                              Padding(
                                padding:  const EdgeInsets.all(12),
                                child: Container(
                                  height: 95.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: const Color(0xFFF7F7F7),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 10,
                                          blurRadius: 15,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 50.w,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20.h,),
                                            images[0]==null
                                                ? Icon(Icons.camera_alt_outlined,size: 24.sp,)
                                                :ImageIcon(AssetImage("assets/icons/done.png"),size: 24.w,color: turquoiseColorApp,),
                                            SizedBox(height: 10.h,),
                                            Text('צד קדמי', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      ),
                                      onTap: ()=>images[0]==null?pickImage(0):editImage('צד קדמי', 0),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(12),
                                child: Container(
                                  height: 95.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF7F7F7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 50.w,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20.h,),
                                            images[1]==null
                                                ? Icon(Icons.camera_alt_outlined,size: 24.sp,)
                                                :ImageIcon(AssetImage("assets/icons/done.png"),size: 24.w,color: turquoiseColorApp,),
                                            SizedBox(height: 10.h,),
                                            Text('צד ימין', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      ),
                                      onTap: ()=>images[1]==null?pickImage(1):editImage('צד ימין', 1),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                        TableRow(
                            children: [
                              Padding(
                                padding:  const EdgeInsets.all(12),
                                child: Container(
                                  height: 95.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF7F7F7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 60.w,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20.h,),
                                            images[2]==null
                                                ? Icon(Icons.camera_alt_outlined,size: 24.sp,)
                                                :ImageIcon(AssetImage("assets/icons/done.png"),size: 24.w,color: turquoiseColorApp,),
                                            SizedBox(height: 10.h,),
                                            Text('צד אחורי', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      ),
                                      onTap: ()=>images[2]==null?pickImage(2):editImage('צד אחורי', 2),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(12),
                                child: Container(
                                  height: 95.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xFFF7F7F7),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      child: SizedBox(
                                        width: 60.w,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 20.h,),
                                            images[3]==null
                                                ? Icon(Icons.camera_alt_outlined,size: 24.sp,)
                                                :ImageIcon(AssetImage("assets/icons/done.png"),size: 24.w,color: turquoiseColorApp,),
                                            SizedBox(height: 10.h,),
                                            Text('צד שמאל', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                          ],
                                        ),
                                      ),
                                      onTap: ()=>images[3]==null?pickImage(3):editImage('צד שמאל', 3),
                                    ),
                                  ),
                                ),
                              ),

                            ]
                        )
                      ],

                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 48.h,
                    width: 332.w,
                    margin: EdgeInsets.only(bottom: 35.h,),
                    //padding: EdgeInsets.symmetric(horizontal: 30),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: allLoaded?turquoiseColorApp:Color(0xFFD9D9D9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0.0,
                        ),
                        onPressed: (){
                          int i;
                          for(i=0; i<images.length;i++){
                            if(images[i]==null)
                              break;
                          }
                          if (i==4) {
                            setState(() {
                              allLoaded = true;
                            });

                          }

                          if(!allLoaded) missingImage();

                          
                        },
                        child:  Text('שלח תמונות',style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500,color:Colors.white),)),
                  ),


                ]

            )
      )
    )
    );
  }

  Future pickImage(index) async{
    final _image = await ImagePicker().pickImage(source: ImageSource.camera);
    images[index]=_image!;
    int i;
    for(i=0; i<images.length;i++){

      if(images[i]==null)
        break;
    }
    print(i);
    if (i==4) allLoaded=true;
    setState(() {});
  }

  Future missingImage(){
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: Colors.black12.withOpacity(0.1),
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                children: [
                  Container(
                    height: 28.h,
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'חסרות תמונות',
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w600,
                                color: pinkColorApp),
                          ),
                          SizedBox(height: 40.h),
                          Text('כדי לבצע שליחה עליך לצלם\nתמונות ל-4 הכיוונים ',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,),
                            textDirection: TextDirection.rtl,
                          textAlign: TextAlign.center,),
                          SizedBox(height: 27.h),
                          Container(
                            height: 48.h,
                            width: 332.w,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: turquoiseColorApp,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () =>Navigator.pop(context),
                                child: Text('חזור לצלם',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))),
                          ),
                          SizedBox(height: 22.h),
                        ]
                    ),
                  ),
                ],
              )
          );
        }
    );
  }

  Future editImage(String side,int index){
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: Colors.black12.withOpacity(0.1),
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: context,
        builder: (context) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Wrap(
                children: [
                  Container(
                    height: 28.h,
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'עריכת תמונה',
                            style: TextStyle(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.w600,
                                color: pinkColorApp),
                          ),
                          SizedBox(height: 40.h),
                          Text('מה ברצונך לעשות עם תמונה "$side”',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400,),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,),
                          SizedBox(height: 27.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 48.h,
                                width: 160.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: turquoiseColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () =>pickImage(index),
                                    child: Text('צלם שוב',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500))),
                              ),
                              SizedBox(width: 13.w,),
                              Container(
                                height: 48.h,
                                width: 160.w,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: turquoiseColorApp,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        images[index]=null;
                                        allLoaded=false;
                                      });
                                      Navigator.pop(context);
                                      delete();
                                    },
                                    child: Text('מחק',
                                        style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500))),
                              ),
                            ],
                          ),
                          SizedBox(height: 22.h),
                        ]
                    ),
                  ),
                ],
              )
          );
        }
    );
  }

  Future delete( ){
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              width: 292.w,
              decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 250,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Wrap(
                  children: [
                    Container(
                      //height: 38.h,
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 8.h),
                            ImageIcon(AssetImage("assets/icons/trash.png"),size: 24.w,color: pinkColorApp,),
                            SizedBox(height: 27.h),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' התמונה נמחקה בהצלחה\n',
                                    style: TextStyle(
                                      color: Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' נסו לצלם תמונה חדשה:)',
                                    style: TextStyle(
                                      color: Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            /*Text('התמונה נמחקה בהצלחה',
                              style: TextStyle(fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                  color: blackColorApp,
                                decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,),
                            Text(' נסו לצלם תמונה חדשה:)  ',
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w400,
                                  color: blackColorApp,
                                decoration: TextDecoration.none
                              ),
                              textAlign: TextAlign.center,),*/
                            SizedBox(height: 31.h),
                          ]
                      ),
                    ),
                  ],
                )
            )
            ),
          );
        },);
  }
}
