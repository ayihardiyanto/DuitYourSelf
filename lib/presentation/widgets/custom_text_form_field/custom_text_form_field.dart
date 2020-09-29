import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FocusNode node;
  final double height;
  final double width;
  final double marginLeft;
  final double marginRight;
  final double marginBottom;
  final double marginTop;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final double paddingBottom;
  final Color fillColor;
  final bool enabled;
  final bool autovalidate;
  final bool errorCondition;
  final bool readOnly;
  final bool showCursor;
  final Widget suffixIcon;
  final GestureTapCallback onTap;
  final Function onChange;
  final Function validator;
  final String helperText;
  final String hintText;
  final TextInputType textInputType;
  final List<TextInputFormatter> textInputFormatter;
  final int maxLines;
  final String counterText;
  final int maxLength;
  final TextStyle textStyle;
  final EdgeInsets contentPadding;
  final double borderRadius;

  CustomTextField({
    Key key,
    this.labelText,
    this.controller,
    this.node,
    this.marginLeft,
    this.marginRight,
    this.marginBottom,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.paddingTop,
    this.height,
    this.width,
    this.marginTop,
    this.fillColor,
    this.enabled,
    this.suffixIcon,
    this.readOnly,
    this.showCursor,
    this.onTap,
    this.validator,
    this.errorCondition,
    this.onChange,
    this.autovalidate,
    this.helperText,
    this.hintText,
    this.textInputType,
    this.textInputFormatter,
    this.maxLines,
    this.counterText,
    this.textStyle,
    this.maxLength,
    this.contentPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Center(
      child: Container(
        height: height,
        width: width ?? ScreenUtil().setWidth(315),
        padding: customPadding(),
        margin: customMargin(),
        child: TextFormField(
          inputFormatters: textInputFormatter ?? [],
          onChanged: onChange,
          autovalidateMode: AutovalidateMode.always,
          controller: controller,
          keyboardType: textInputType,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 10),
              ),
              contentPadding: contentPadding ?? EdgeInsets.all(10),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Grey.brownGrey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColor),
              ),
              filled: true,
              fillColor: enabled == true || enabled == null
                  ? Colors.white
                  : Grey.brightGrey,
              isDense: true,
              labelText: labelText,
              labelStyle: PxText.lableStyle12.copyWith(
                  color: node.hasFocus
                      ? (errorCondition == false || errorCondition == null
                          ? primaryColor
                          : Red.errorColor)
                      : Grey.greyedText),
              suffixIcon: suffixIcon,
              hintText: hintText,
              counterText: counterText ?? ''),
          enabled: enabled ?? true,
          focusNode: node,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          onTap: onTap,
          readOnly: readOnly ?? false,
          showCursor: showCursor ?? true,
          style: textStyle ??
              PxText.body14.copyWith(color: Grey.brownGrey, fontSize: 12),
          validator: validator,
          // keyboardType: textInputType,
        ),
      ),
    );
  }

  EdgeInsets customPadding() {
    return EdgeInsets.only(
      top: paddingTop ?? 0,
      bottom: paddingBottom ?? 0,
      right: paddingRight ?? 0,
      left: paddingLeft ?? 0,
    );
  }

  EdgeInsets customMargin() {
    return EdgeInsets.only(
      top: marginTop ?? 0,
      bottom: marginBottom ?? 0,
      right: marginRight ?? 0,
      left: marginLeft ?? 0,
    );
  }
}
