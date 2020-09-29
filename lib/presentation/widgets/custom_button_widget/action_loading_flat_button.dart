import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:duit_yourself/common/constants/common_constants.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class ActionLoadingFlatButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String buttonTitle;
  final Color titleColor;
  final Color buttonColor;
  final double height;
  final double width;
  final CustomButtonStyle buttonStyle;
  final double iconSize;
  final String loadingText;

  ActionLoadingFlatButton({
    Key key,
    @required this.onPressed,
    this.buttonTitle,
    this.titleColor,
    this.buttonColor,
    this.height,
    this.width,
    this.buttonStyle, this.iconSize, this.loadingText,
  }) : super(key: key);

  @override
  _ActionLoadingFlatButtonState createState() => _ActionLoadingFlatButtonState();
}

class _ActionLoadingFlatButtonState extends State<ActionLoadingFlatButton> {
  List<Color> buttonStyleBuilder(BuildContext context) {
    final buttonColor = Theme.of(context).buttonColor;
    Color defaultBaseColor;
    Color defaultTitleColor;

    switch (widget.buttonStyle) {
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
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    Color defaultBaseColor = buttonStyleBuilder(context)[0];
    Color defaultTitleColor = buttonStyleBuilder(context)[1];

    return ButtonTheme(
      minWidth: widget.width ?? 315,
      height: widget.height ?? 35,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: widget.buttonStyle == CustomButtonStyle.STYLE_THREE
            ? BorderSide(color: defaultTitleColor)
            : BorderSide(color: Colors.transparent),
      ),
      child: FlatButton(
        disabledColor: Grey.brightGrey,
        disabledTextColor: Grey.greyedText,
        color: widget.buttonColor ?? defaultBaseColor,
        onPressed: widget.onPressed == null || isClicked ? null : (){
          setState(() {
            isClicked = true;
          });
          widget.onPressed();
        },
        textColor: widget.titleColor ?? defaultTitleColor,
        child:
        isClicked ?  Wrap(
          children: [
            Text(widget.loadingText ?? 'Saving'),
            FadingText('...'),
          ],
        )
            :
        Text(
          widget.buttonTitle ?? CommonConstants.continueButton,
          style: PxText.buttonText.copyWith(
            color: defaultTitleColor ?? Colors.white,
          ),
        ),

      ),
    );
  }
}

enum CustomButtonStyle { STYLE_ONE, STYLE_TWO, STYLE_THREE }
