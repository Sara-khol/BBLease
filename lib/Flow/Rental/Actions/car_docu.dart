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

  List<XFile> images=[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
        padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,left: 30.w,right: 30.w),
            child: Column(
                children: [
                  SizedBox(height: 35.h,),
                  Align(alignment: Alignment.centerRight,
                      child: IconButton(onPressed: () =>Navigator.pop(context), icon: Icon(Icons.arrow_back_ios))),
                  SizedBox(height: 62.h,),
                  Text('תיעוד רכב',style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                  SizedBox(height: 36.h,),
                  Text('בתחילת הנסיעה',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  Text('מומלץ לתעד את הרכב\n נסיעה בטוחה :)',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                  SizedBox(height: 72.h,),
                  ImageIcon(AssetImage("assets/icons/heart.png"),size: 26.w,color: turquoiseColorApp,),
                  SizedBox(height: 14.h,),
                  Text('וודאו שהתמונה המתקבלת\nחדה וברורה מספיק!',
                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                  SizedBox(height: 36.h,),
                  Table(
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
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
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
                                          Icon(Icons.camera_alt_outlined,size: 24.sp,),
                                          SizedBox(height: 10.h,),
                                          Text('צד קדמי', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                    onTap: ()=>pickImage(0),
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
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
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
                                          Icon(Icons.camera_alt_outlined,size: 24.sp,),
                                          SizedBox(height: 10.h,),
                                          Text('צד ימין', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                    onTap: ()=>pickImage(1),
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
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
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
                                          Icon(Icons.camera_alt_outlined,size: 24.sp,),
                                          SizedBox(height: 10.h,),
                                          Text('צד אחורי', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                    onTap: ()=>pickImage(2),
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
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
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
                                          Icon(Icons.camera_alt_outlined,size: 24.sp,),
                                          SizedBox(height: 10.h,),
                                          Text('צד שמאל', style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w500,height: 1),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                    onTap: ()=>pickImage(3),
                                  ),
                                ),
                              ),
                            ),

                          ]
                      )
                    ],

                  ),
                  SizedBox(height: 103.h,),
                  Container(
                    height: 48.h,
                    width: 332.w,
                    margin: EdgeInsets.only(bottom: 35.h),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: pinkColorApp,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          elevation: 0.0,
                        ),
                        onPressed: (){
                          
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
    setState(() {
      images[index]=_image!;
    });
  }
}
