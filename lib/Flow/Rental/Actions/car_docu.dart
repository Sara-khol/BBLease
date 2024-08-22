import 'package:bblease/Flow/Rental/dialogs.dart';
import 'package:bblease/services/api_service.dart';
import 'package:bblease/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../landspace_widget.dart';
import '../../Dialogs/buttom_dialogs.dart';
import '../map.dart';


class CarDocu extends StatefulWidget {
  const CarDocu({Key? key, required this.rentNum}) : super(key: key);

  final int rentNum;

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

  sendImages(){
    showLoading(context);
    ApiService().carDocumentation(widget.rentNum,images, (res) {
      Navigator.pop(context);
      displayMessage(context,
          message: 'ההודעה התקבלה בהצלחה',
          onClose: () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
    },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.landscape)
          return LandSpaceWidget(mainWidget: buildContent(),imageProperties:ImageProperties('l_image.png', 580.w));
        return buildContent();
      }),
    );
  }

  buildContent() {
    return  SingleChildScrollView(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,/*left: 30.w,right: 30.w*/),
              child: Column(
                  children: [
                    SizedBox(height: 35.h,),
                    Align(alignment: Alignment.centerRight, child: IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
                    SizedBox(height: 52.h,),
                    Text('תיעוד רכב',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    SizedBox(height: 30.h,),
                    Text('\nמומלץ תמיד לתעד את הרכב\nבתחילת הנסיעה!!\n', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal,),textDirection:TextDirection.rtl,textAlign: TextAlign.center,),
                    Text('אם ישנם נזקים , נדע לא לחייב אתכם עליהם', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal,),),
                    Text(' \nנסיעה בטוחה :)', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10.h,),
                    Image.asset("assets/icons/heart.png"),
                    SizedBox(height: 40.h,),
                    Text('צלמו תמונה חדה וברורה!', style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                    SizedBox(height: 25.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:70.w),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.symmetric(vertical: 12.h,horizontal: 12.w),
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
                                                  :Image.asset("assets/icons/done.png"),
                                              SizedBox(height: 10.h,),
                                              Text('צד קדמי', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                                  :Image.asset("assets/icons/done.png"),
                                              SizedBox(height: 10.h,),
                                              Text('צד ימין', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                                  :Image.asset("assets/icons/done.png"),
                                              SizedBox(height: 10.h,),
                                              Text('צד אחורי', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                                                  :Image.asset("assets/icons/done.png"),
                                              SizedBox(height: 10.h,),
                                              Text('צד שמאל', style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,height: 1),textAlign: TextAlign.center,)
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
                    SizedBox(height: 35.h,),
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
                              sendImages();
                            }
                            if(!allLoaded) missingImage();
                          },
                          child:  Text('שלח תמונות',
                            style: TextStyle(fontSize: 22.sp,
                              fontWeight: FontWeight.normal,
                              color:Colors.white,),)),
                    ),
                    SizedBox(height: 20.h,)


                  ]

              )
          )
      ),
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
    Widget widget=    Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'חסרות תמונות',
              style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: pinkColorApp),
            ),
            SizedBox(height: 40.h),
            Text('כדי לבצע שליחה עליך לצלם\nתמונות ל-4 הכיוונים ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal,),
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
                        fontWeight: FontWeight.normal,
                      ))),
            ),
            SizedBox(height: 22.h),
          ]
      ),
    );
    return showBottomDialog(widget);
  }

  Future editImage(String side,int index){
    Widget widget=  Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'עריכת תמונה',
              style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.bold,
                  color: pinkColorApp),
            ),
            SizedBox(height: 40.h),
            Text('מה ברצונך לעשות עם תמונה\n "$side"',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.normal,),
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
                      onPressed: () {
                        pickImage(index);
                        Navigator.pop(context);

                      },
                      child: Text('צלם שוב',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,))),
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
                        deleteImage(index);
                      },
                      child: Text('מחק',
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight:FontWeight.w600))),
                ),
              ],
            ),
            SizedBox(height: 22.h),
          ]
      ),
    );
    return showBottomDialog(widget);
  }

  Future deleteImage(int index){
    Widget widget=  Padding(
      padding: EdgeInsets.only(left: 30.w, right: 30.w, ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'התמונה נמחקה',
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: pinkColorApp),
            ),
            SizedBox(height: 40.h),
            Text('צלמו תמונה חדשה וברורה',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal,),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,),
            SizedBox(height: 52.h),
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
                      onPressed: () {
                        pickImage(index);
                        Navigator.pop(context);
                      },
                      child: Text('צלם שוב',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,))),
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
                     Navigator.pop(context);
                      },
                      child: Text('הבנתי',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600))),
                ),
              ],
            ),
            SizedBox(height: 22.h),
          ]
      ),
    );
    return showBottomDialog(widget);
  }

 Future showBottomDialog(Widget content)
  {
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        barrierColor: Colors.black12.withOpacity(0.1),
        backgroundColor: Colors.white,
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
                    padding: EdgeInsets.only(right: 20.w,top: 18.h),
                   // height: 28.h,
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                 content
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8.h),
                            ImageIcon(AssetImage("assets/icons/trash.png"),color: pinkColorApp,),
                            SizedBox(height: 27.h),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' התמונה נמחקה בהצלחה\n',
                                    style: TextStyle(
                                      fontFamily:'PLONI' ,
                                      color: Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' נסו לצלם תמונה חדשה:)',
                                    style: TextStyle(
                                      color: Color(0xFF0F1511),
                                      fontSize: 20.sp,
                                      fontFamily:'PLONI' ,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
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
