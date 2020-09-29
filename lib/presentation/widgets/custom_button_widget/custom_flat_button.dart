import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:duit_yourself/common/constants/common_constants.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class CustomFlatButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonTitle;
  final Color titleColor;
  final Color buttonColor;
  final double height;
  final double width;
  final CustomButtonStyle buttonStyle;
  final dynamic leadingIcon;
  final double iconSize;

  CustomFlatButton({
    Key key,
    @required this.onPressed,
    this.buttonTitle,
    this.titleColor,
    this.buttonColor,
    this.height,
    this.width,
    this.buttonStyle,
    this.leadingIcon, this.iconSize,
  }) : super(key: key);

  List<Color> buttonStyleBuilder(BuildContext context) {
    final buttonColor = Theme.of(context).buttonColor;
    Color defaultBaseColor;
    Color defaultTitleColor;

    switch (buttonStyle) {
      case CustomButtonStyle.STYLE_ONE:
        defaultBaseColor = buttonColor;
        defaultTitleColor = White.white;
        return [defaultBaseColor, defaultTitleColor];
      case CustomButtonStyle.STYLE_TWO:
        defaultBaseColor = Grey.brightGrey;
        defaultTitleColor = buttonColor;
        return [defaultBaseColor, defaultTitleColor];
      case CustomButtonStyle.STYLE_THREE:
        defaultBaseColor = White.white;
        defaultTitleColor = Theme.of(context).primaryColor;
        return [defaultBaseColor, defaultTitleColor];
      default:
        defaultBaseColor = buttonColor;
        defaultTitleColor = White.white;
        return [defaultBaseColor, defaultTitleColor];
    }
  }

  @override
  Widget build(BuildContext context) {
    Color defaultBaseColor = buttonStyleBuilder(context)[0];
    Color defaultTitleColor = titleColor ?? buttonStyleBuilder(context)[1];

    return ButtonTheme(
      minWidth: width ?? 315,
      height: height ?? 35,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: buttonStyle == CustomButtonStyle.STYLE_THREE
            ? BorderSide(color: defaultTitleColor)
            : BorderSide(color: Colors.transparent),
      ),
      child: FlatButton(
        disabledColor: Grey.brightGrey,
        disabledTextColor: Grey.greyedText,
        color: buttonColor ?? defaultBaseColor,
        onPressed: onPressed,
        textColor: titleColor ?? defaultTitleColor,
        child: 
        leadingIcon != null
            ? Container(
              width: width ?? 315,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    leadingIcon.runtimeType == IconData ? Icon(
                      leadingIcon,
                      color: defaultTitleColor,
                      size: iconSize ?? 20,
                    ) : leadingIcon,
                    Padding(
                      padding: EdgeInsets.only(top: 4, left: 7),
                      child: Text(
                        buttonTitle ?? CommonConstants.continueButton,
                        style: PxText.buttonText
                            .copyWith(color: defaultTitleColor ?? Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            :
         Text(
                buttonTitle ?? CommonConstants.continueButton,
                style: PxText.buttonText.copyWith(
                  color: defaultTitleColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}

enum CustomButtonStyle { STYLE_ONE, STYLE_TWO, STYLE_THREE }
