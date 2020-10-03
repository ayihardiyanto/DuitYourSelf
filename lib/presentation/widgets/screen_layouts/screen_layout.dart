import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/back_button.dart';
// import 'package:duit_yourself/presentation/widgets/custom_button_widget/action_loading_flat_button.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final String actionButtonText;
  final IconData actionButtonIcon;
  final bool enableBackButton;
  final bool enableContinueButton;
  final bool enableActionButton;
  final String buttonText;
  final double paddingTop;
  final double paddingLeft;
  final double paddingRight;
  final double paddingBottom;
  final Color backgroundColor;
  final Color buttonColor;
  final GestureTapCallback onPressed;
  final GestureTapCallback actionButtonOnPressed;
  final String loadingText;

  const ScreenLayout({
    Key key,
    this.backgroundColor,
    @required this.child,
    @required this.title,
    this.enableBackButton = true,
    this.enableContinueButton = true,
    this.enableActionButton = false,
    this.buttonText,
    this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingBottom,
    this.onPressed,
    this.buttonColor,
    this.actionButtonOnPressed,
    this.actionButtonText,
    this.actionButtonIcon,
    this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(bottom: 10),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (enableBackButton) BackButtonWidget(),
                Padding(
                  padding: EdgeInsets.only(left: !enableBackButton ? 20.0 : 0),
                  child: Text(
                    title,
                    style: PxText.titleBar.copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
            if (enableActionButton)
              Padding(
                padding: EdgeInsets.only(right: 20.0, bottom: 3, top: 3),
                child: RaisedButton(
                  // padding: EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Purple.barneyPurple,
                  onPressed: actionButtonOnPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        actionButtonIcon ?? Icons.add_circle_outline,
                        color: White.white,
                      ),
                      SizedBox(
                        width: 5,
                        height: 5,
                      ),
                      Text(
                        actionButtonText ?? 'Action Button',
                        style: PxText.body14.copyWith(color: White.white),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
      // Expanded(
      Container(
        width: mediaQuery.width,
        height: mediaQuery.height,
        decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(top: 50),
        padding: customPadding(),
        child: child,
      ),
      // ),
      if (enableContinueButton)
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: mediaQuery.width,
            height: 50,
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
            //     child: ActionLoadingFlatButton(
            //   loadingText: loadingText,
            //   buttonTitle: buttonText ?? CommonConstants.continueButton,
            //   buttonColor: buttonColor ?? Purple.barneyPurple,
            //   onPressed: onPressed,
            // )
            ),
          ),
        )
    ]);
  }

  EdgeInsets customPadding() {
    return EdgeInsets.only(
      top: paddingTop ?? 0,
      bottom:
          // ignore: prefer_if_null_operators
          paddingBottom != null ? paddingBottom : enableContinueButton ? 50 : 0,
      right: paddingRight ?? 20,
      left: paddingLeft ?? 20,
    );
  }
}
