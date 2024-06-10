import 'package:bblease/customWidgets/appBarB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandSpaceWidget extends StatelessWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;
  final bool showAppBar;

  const LandSpaceWidget({super.key, required this.mainWidget, required this.imageProperties, this.showAppBar = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (showAppBar)
            const Directionality(
                textDirection: TextDirection.ltr, child: AppBarBibilease()),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 550.w,
                      ),
                      child: mainWidget,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      'assets/images/${imageProperties.imagePath}',
                      width: imageProperties.imageWidth,
                    ),
                  ),
                ),
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
