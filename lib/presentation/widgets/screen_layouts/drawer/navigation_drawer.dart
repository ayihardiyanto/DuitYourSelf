import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/navigation_bar/navigation_profile.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationProfile(),
        ],
      ),
    );
  }
}