import 'package:flutter/material.dart';

class NavigationTitle extends StatelessWidget {
  const NavigationTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 30, right: 30),
      child: Text(
        'PX Portal',
        style:
            TextStyle(fontFamily: 'Poppins', fontSize: 22, color: Colors.black),
      ),
    );
  }
}
