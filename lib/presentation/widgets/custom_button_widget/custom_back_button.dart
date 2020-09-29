import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';

class BackButtonWidget extends StatelessWidget {

  final Function callBack;
  BackButtonWidget({this.callBack});
  @override
  Widget build(BuildContext context) {
    // final Color primaryColor = Theme.of(context).primaryColor;
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        color: Purple.barneyPurple,
        onPressed: () {
          if(callBack!=null) callBack();
          Navigator.pop(context);
        },
      ),
    );
  }
}
