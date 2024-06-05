
import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';

class LandSpaceWidget extends StatelessWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;
  final bool showAppBar;

  const LandSpaceWidget({super.key, required this.mainWidget, required this.imageProperties,this.showAppBar=false});

  // late final Map<Type, ImageProperties> _widgetImageMap = {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
       if(showAppBar)   const Directionality(
              textDirection: TextDirection.ltr, child: AppBarBibilease()),
          Expanded(
            child: Row(
              children: [
                Expanded(child: mainWidget),
                Expanded(
                  child: Container(

                    child: Center(
                        child: Image.asset(
                     'assets/images/${imageProperties.imagePath}',
                      width: imageProperties.imageWidth,
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageProperties {
  late String imagePath;

  ImageProperties(this.imagePath, this.imageWidth);

  late double imageWidth;
}
