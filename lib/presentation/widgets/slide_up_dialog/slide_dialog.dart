import 'package:flutter/material.dart';
// import 'package:px/common/config/screen_config.dart';

import './pill_gesture.dart';

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color pillColor;
  final bool dragToClose;
  final double paddingTop;
  final double width;

  SlideDialog({
    @required this.dragToClose,
    @required this.child,
    @required this.pillColor,
    @required this.backgroundColor,
    this.paddingTop,
    this.width
  });

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  var _initialPosition = 0.0;
  var _currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final deltaHeight = widget.paddingTop ?? deviceHeight * 0.075;

    return AnimatedPadding(
      padding:
          MediaQuery.of(context).viewInsets + EdgeInsets.only(top: deltaHeight),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Container(
            width: widget.width ?? deviceWidth,
            height: deviceHeight,
            child: Material(
              color: widget.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              elevation: 24.0,
              type: MaterialType.card,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    if (widget.dragToClose)
                      PillGesture(
                          onVerticalDragStart: (details) =>
                              _onVerticalDragStart(details),
                          onVerticalDragUpdate: (details) =>
                              _onVerticalDragUpdate(details),
                          onVerticalDragEnd: (details) =>
                              _onVerticalDragEnd(details),
                          pillColor: widget.pillColor),
                    Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: widget.child,
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails drag) {
    setState(() {
      _initialPosition = drag.globalPosition.dy;
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails drag) {
    setState(() {
      final temp = _currentPosition;
      _currentPosition = drag.globalPosition.dy - _initialPosition;
      if (_currentPosition < 0) {
        _currentPosition = temp;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails drag) {
    if (_currentPosition > 100.0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _currentPosition = 0.0;
    });
  }
}
