import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';

class ConfirmButtonWidget extends StatelessWidget {
  final String confirmText;
  final GestureTapCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  ConfirmButtonWidget(
      {this.onPressed, this.confirmText, this.buttonColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: buttonColor ?? White.white,
      elevation: 0,
      textColor: textColor ?? Purple.barneyPurple,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed:  ()  {
        Navigator.pop(context);
        onPressed();
      },
      child: Text(confirmText ?? 'Continue'),
    );
  }
}
