
import 'package:flutter/material.dart';

class LandSpaceWidget extends StatefulWidget {
  final Widget mainWidget;
  final ImageProperties imageProperties;

  const LandSpaceWidget({super.key, required this.mainWidget, required this.imageProperties});

  @override
  State<LandSpaceWidget> createState() => _LandSpaceWidgetState();
}

class _LandSpaceWidgetState extends State<LandSpaceWidget> {
  // late final Map<Type, ImageProperties> _widgetImageMap = {
  //    TelToRegistrationForm: ImageProperties('l_image.png', 580.w),
  //    PersonalDetailsForm: ImageProperties('l_register1.png', 618.w),
  // };
 // late ImageProperties _imageProperties;

  // @override
  // void initState() {
  //   _imageProperties = _widgetImageMap[widget.mainWidget.runtimeType] ??
  //       ImageProperties('l_image.png', 580.w);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: widget.mainWidget),
          Expanded(
            child: Container(

              child: Center(
                  child: Image.asset(
               'assets/images/${widget.imageProperties.imagePath}',
                width: widget.imageProperties.imageWidth,
              )),
            ),
          )
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
