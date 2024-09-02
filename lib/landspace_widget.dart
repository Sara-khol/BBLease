import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandSpaceWidget extends StatelessWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;
  bool showAppBar;


  LandSpaceWidget({super.key, required this.mainWidget, required this.imageProperties, this.showAppBar=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:EdgeInsets.only(bottom: 50.h),
              child: Text(
                'Bibilease',
                style: TextStyle(
                  color: Color(0xFFEFFFFE),
                  fontSize: 300.sp,
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(showAppBar)const Directionality(textDirection: TextDirection.ltr, child: AppBarBibilease()),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 150.w,),
                      Expanded(
                        child: Center(
                          child: Container(
                            alignment: Alignment.centerRight,
                            //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                            width: 393.w,
                              //height: MediaQuery.of(context).size.height*0.9.h,
                              child: mainWidget),
                        ),
                      ),
                      /*Container( width: 3,
                        height: 800.h,
                        color: Colors.green,),*/
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/${imageProperties.imagePath}',
                            width: imageProperties.imageWidth,
                            semanticLabel: imageProperties.label,
                          ),
                        ),
                      ),
                      SizedBox(width: 100.w,),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class ImageProperties {
  late String imagePath;
  late String label;
  late double imageWidth;
  ImageProperties(this.imagePath, this.imageWidth,this.label);


}
