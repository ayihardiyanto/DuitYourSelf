import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_title.dart';

class NavigationBarMobile extends StatelessWidget {
  NavigationBarMobile({Key key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 70,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.only(left:20),
            icon: Icon(Icons.menu),
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
          ),
          NavigationTitle()
        ],
      ),
    );
  }
}
