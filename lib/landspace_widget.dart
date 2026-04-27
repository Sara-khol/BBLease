import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LandSpaceWidget extends StatelessWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;
  final bool showAppBar;
  // final bool showAppBarNotLand;
  // final bool addScrollNotLand;
  // final bool addSpaceNotLand;

  const LandSpaceWidget({
    super.key,
    required this.mainWidget,
    required this.imageProperties,
    this.showAppBar = true,/*  this.showAppBarNotLand=false,
    this.addSpaceNotLand=false,
    this.addScrollNotLand=false*/
  });

  bool _isRealLandscape(BuildContext context) {
    final view = View.of(context);
    final physicalSize = view.physicalSize;
    return physicalSize.width > physicalSize.height;
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = _isRealLandscape(context);

    if (!isLandscape) {
      return mainWidget;
    }

    // if (!isLandscape && showAppBarNotLand) {
    //   Widget mainContent= Column(children: [
    //     const Directionality(
    //       textDirection: TextDirection.ltr,
    //       child: AppBarBibilease(),
    //     ),
    //     if(showAppBarNotLand && addSpaceNotLand)
    //       SizedBox(height: 40.h),
    //     mainWidget
    //   ]);
    //   return addScrollNotLand? SingleChildScrollView(
    //     child: mainContent
    //   ):mainContent;
    //}

    return /*Scaffold(
      body:*/ Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 380.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'B click',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFEFFFFE),
                      fontSize: 300.sp,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                showAppBar ?
                  const Directionality(
                    textDirection: TextDirection.ltr,
                    child: AppBarBibilease(),
                  ): Container(),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 130.w),
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 393.w,
                              child: mainWidget,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/images/${imageProperties.imagePath}',
                              width: 600.w,
                              semanticLabel: imageProperties.label,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
     // ),
    );
  }
}

/*class LandSpaceWidget extends StatelessWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;
  bool showAppBar;


  LandSpaceWidget({super.key, required this.mainWidget, required this.imageProperties, this.showAppBar=true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(height: 380.h,
                //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                      // 'Bibilease',
                      'B click',
                      style: TextStyle(
                        color: const Color(0xFFEFFFFE),
                        fontSize: 300.sp,
                        fontWeight: FontWeight.w800,
                        height: 1.1.h,
                      ),textAlign: TextAlign.center,

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
                        Container(width: 130.w),
                        Expanded(
                          child: Center(
                            child: Container(
                              alignment: Alignment.topRight,
                              //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                              width: 393.w,
                                //height: MediaQuery.of(context).size.height*0.9.h,
                                child: mainWidget),
                          ),
                        ),
                        *//*Container( width: 3,
                          height: 800.h,
                          color: Colors.green,),*//*
                        Expanded(
                          child: Center(
                            child: Image.asset(
                              'assets/images/${imageProperties.imagePath}',
                              width: 600.w,//imageProperties.imageWidth,
                              semanticLabel: imageProperties.label,
                            ),
                          ),
                        ),
                        Container(width: 100.w),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}*/

class ImageProperties {
  late String imagePath;
  late String label;
  late double imageWidth;
  ImageProperties(this.imagePath, this.imageWidth,this.label);


}


