import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../themes/color_theme.dart';

class CardWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const CardWidget({Key key, this.height, this.width, this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 160,
      width: width ?? 201,
      padding: padding,
      decoration: BoxDecoration(
          color: White.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Grey.ashGrey,
                offset: Offset(0.0, 1.0),
                spreadRadius: 0.0,
                blurRadius: 1.0)
          ]),
      child: Container(
        child: child,
      ),
    );
  }
}
