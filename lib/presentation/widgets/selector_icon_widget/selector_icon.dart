import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class SelectorIcon extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final IconData icon;
  final double iconSize;
  final double baseHeight;
  final double baseWidth;
  final Color textColor;
  final Color baseColor;
  final Color iconColor;
  final bool isActive;
  final double textSize;

  SelectorIcon({
    Key key,
    this.baseColor,
    this.baseHeight,
    this.baseWidth,
    @required this.icon,
    this.iconColor,
    this.iconSize,
    @required this.isActive,
    this.onTap,
    this.text,
    this.textColor,
    this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final defaultIconColor = isActive ? White.white : Grey.brownGrey;
    final defaultBaseColor = isActive ? primaryColor : Grey.brightGrey;
    final defaultTextColor = isActive ? primaryColor : Grey.brownGrey;

    final activeIconColor = iconColor ?? defaultIconColor;
    final activeBaseColor = baseColor ?? defaultBaseColor;
    final activeTextColor = textColor ?? defaultTextColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            height: baseHeight ?? ScreenUtil().setHeight(50),
            width: baseWidth ?? ScreenUtil().setWidth(50),
            decoration: BoxDecoration(
              color: activeBaseColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize ?? ScreenUtil().setHeight(16),
                color: activeIconColor,
              ),
            ),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(10),
          ),
          child: text == null
              ? null
              : Text(
                  text,
                  style: PxText.body14.copyWith(
                    fontSize:textSize?? ScreenUtil().setSp(12),
                    color: activeTextColor,
                  ),
                ),
        ),
      ],
    );
  }
}
