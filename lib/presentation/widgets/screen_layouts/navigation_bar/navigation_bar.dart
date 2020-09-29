  
import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_bar_mobile.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_bar_tablet_dekstop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key,this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavigationBarMobile(scaffoldKey: scaffoldKey,),
      desktop: NavigationBarTabletDesktop(),
    );
  }
}