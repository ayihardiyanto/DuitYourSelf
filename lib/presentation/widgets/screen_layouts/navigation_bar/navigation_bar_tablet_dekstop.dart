import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_profile.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_title.dart';
import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Grey.brownGrey))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Padding(
          padding:  EdgeInsets.only(left:70.0),
          child: NavigationTitle(),
        ), NavigationProfile()],
      ),
    );
  }
}
