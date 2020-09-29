import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_bar.dart';
import 'package:responsive_builder/responsive_builder.dart';

// created by : surya
// last modified : dedy

class LayoutTemplate extends StatelessWidget {
  LayoutTemplate({Key key, this.child}) : super(key: key);

  final Widget child;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      key: Key('ResponsiveBuilder'),
      builder: (context, sizingInformation) => Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Blue.darkBlue,
          actions: [
            Align(
              child: NavigationBar(
                scaffoldKey: _scaffoldKey,
              ),
              alignment: Alignment.topCenter,
            ),
            // SideBarMenu(),
            Row(
              children: [
                if (sizingInformation.deviceScreenType !=
                    DeviceScreenType.mobile)
                  // SideBarMenu(),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 50),
                        padding: EdgeInsets.only(
                            top: 20.0, right: 20, left: 20, bottom: 10),
                        child: child),
                  ),
              ],
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1920),
            child: Stack(
              children: <Widget>[],
            ),
          ),
        ),
      ),
    );
  }
}
