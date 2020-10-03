import 'package:flutter/material.dart';

class PillGesture extends StatelessWidget {
  final GestureDragStartCallback onVerticalDragStart;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Color pillColor;

  PillGesture({
    @required this.onVerticalDragStart,
    @required this.onVerticalDragUpdate,
    @required this.onVerticalDragEnd,
    @required this.pillColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onVerticalDragEnd: onVerticalDragEnd,
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: 10.0),
            Container(
              height: 2.0,
              width: 30.0,
              decoration: BoxDecoration(
                color: pillColor ?? Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            SizedBox(height: 5.0),
            Container(
              height: 2.0,
              width: 40.0,
              decoration: BoxDecoration(
                color: pillColor ?? Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
