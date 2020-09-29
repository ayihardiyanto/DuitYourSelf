import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  final Function onPressed;
  BackButtonWidget({this.onPressed});
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: Icon(Icons.arrow_back_ios),
        color: primaryColor,
        onPressed: () {
          if (onPressed != null) onPressed();
          Navigator.maybePop(context);
        },
      ),
    );
  }
}
