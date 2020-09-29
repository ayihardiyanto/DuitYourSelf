import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';

class CloseButtonWidget extends StatelessWidget {
  final GestureTapCallback onPressed;

  CloseButtonWidget({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      color: Grey.brownGrey,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
