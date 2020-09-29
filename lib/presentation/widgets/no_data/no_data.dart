import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class NoDataScreen extends StatelessWidget {
  final String text;

  const NoDataScreen({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-180,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Image.asset(
                'images/no_data_screen.png',
                scale: 2.7,
              )),
          Center(
              child: Text(
                text,
                style: PxText.body14.copyWith(
                    color: Grey.brownGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ))
        ],
      ),
    );
  }
}
