import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  const CustomText(
      this.data, {
        super.key,
        this.style,
        this.textAlign,
        this.textDirection,
        this.locale,
        this.softWrap,
        this.overflow,
        this.textScaleFactor,
        this.maxLines,
        this.semanticsLabel,
      });

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double scaleFactor = orientation == Orientation.landscape ? 1.0 : 1.0;

    TextStyle? scaledStyle = style?.copyWith(fontSize: style!.fontSize != null ? style!.fontSize! * scaleFactor : null);

    return Text(
      data,
      style: scaledStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}