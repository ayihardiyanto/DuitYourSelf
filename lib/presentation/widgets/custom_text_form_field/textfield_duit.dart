import 'package:flutter/material.dart';

class TextFieldDuit extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool isPassword;
  final IconButton suffixIcon;
  final Icon prefixIcon;
  final FocusNode focusNode;
  final AutovalidateMode autoValidate;

  const TextFieldDuit({Key key, this.controller, this.hintText, this.labelText, this.obscureText, this.isPassword, this.suffixIcon, this.prefixIcon, this.focusNode, this.autoValidate})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        focusNode: focusNode,
        autovalidateMode: autoValidate ?? AutovalidateMode.disabled,
        obscureText: obscureText ?? false,
        controller: controller,
      ),
    );
  }
}
