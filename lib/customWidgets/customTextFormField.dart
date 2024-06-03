import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color cursorColor;
  final InputDecoration decoration;
  final TextStyle style;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.cursorColor,
    required this.decoration,
    required this.style,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    double scaleFactor = orientation == Orientation.landscape ? 1.7 : 1.0;
    TextStyle scaledStyle = style.copyWith(fontSize: style.fontSize != null ? style.fontSize! * scaleFactor : null);
    InputDecoration scaledDecoration = getScaledDecoration(context, decoration);
    // TextStyle scaledStyle = style.copyWith(
    //     fontSize:
    //         style.fontSize != null ? style.fontSize! * scaleFactor : null);
    // InputDecoration scaledDecoration = decoration.copyWith(
    //   labelStyle: decoration.labelStyle != null
    //       ? decoration.labelStyle!.copyWith(
    //           fontSize: decoration.labelStyle!.fontSize != null
    //               ? decoration.labelStyle!.fontSize! * scaleFactor
    //               : null)
    //       : null,
    //   hintStyle: decoration.hintStyle != null
    //       ? decoration.hintStyle!.copyWith(
    //           fontSize: decoration.hintStyle!.fontSize != null
    //               ? decoration.hintStyle!.fontSize! * scaleFactor
    //               : null)
    //       : null);


    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      decoration: scaledDecoration,
      style: scaledStyle,
      validator: validator,
      focusNode: focusNode ?? FocusNode(),
    );
  }

  InputDecoration getScaledDecoration(BuildContext context, InputDecoration decoration) {
    var orientation = MediaQuery.of(context).orientation;
    double scaleFactor = orientation == Orientation.landscape ? 1.7 : 1.0;

    return decoration.copyWith(
      labelStyle: decoration.labelStyle != null
          ? decoration.labelStyle!.copyWith(
          fontSize: decoration.labelStyle!.fontSize != null
              ? decoration.labelStyle!.fontSize! * scaleFactor
              : null)
          : null,
      hintStyle: decoration.hintStyle?.copyWith(
          fontSize: decoration.hintStyle!.fontSize != null
              ? decoration.hintStyle!.fontSize! * scaleFactor
              : null),
      constraints: orientation == Orientation.landscape ? null : decoration.constraints,
    );
  }
}
