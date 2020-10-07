import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:flutter/material.dart';

class TextFieldDuit extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool isPassword;
  final dynamic suffixIcon;
  final dynamic prefixIcon;
  final FocusNode focusNode;
  final bool autoValidate;
  final Function validator;
  final Function onChange;
  final bool enabled;
  final InputDecoration decoration;
  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;

  const TextFieldDuit({
    Key key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.isPassword,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.autoValidate,
    this.validator,
    this.onChange,
    this.enabled,
    this.decoration,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextFormField(
        enabled: enabled ?? true,
        decoration: decoration ??
            InputDecoration(
              hintText: hintText,
              labelText: labelText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              labelStyle: PxText.contentText.copyWith(
                  color: enabled ?? false ? Black.black : Grey.ashGrey),
              filled: true,
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? Grey.ashGrey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor ?? Grey.ashGrey),
              ),
              hintStyle: TextStyle(color: Grey.greyedText),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: focusedBorderColor ?? Grey.ashGrey),
              ),
              fillColor: fillColor ??
                  (enabled == true || enabled == null
                      ? Colors.white
                      : Grey.brightGrey),
              alignLabelWithHint: true,
            ),
        focusNode: focusNode,
        autovalidate: autoValidate ?? true,
        obscureText: obscureText ?? false,
        controller: controller,
        validator: validator,
        onChanged: onChange,
      ),
    );
  }
}
