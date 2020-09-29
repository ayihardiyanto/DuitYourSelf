import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RadioButton extends StatelessWidget {
  final Widget content;
  final ContentPosition position;
  final dynamic groupValue;
  final dynamic value;
  final Function onChange;
  final bool toggleAble;

  const RadioButton({
    Key key,
    this.content,
    this.position,
    this.groupValue,
    this.value,
    this.onChange,
    this.toggleAble,
  }) : super(key: key);

  bool get isHorizontal =>
      position == ContentPosition.RIGHT || position == ContentPosition.LEFT ||
      position == null;

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;
//    print(isHorizontal);
    return Container(
      width: 300,
      height: 40,
      child: isHorizontal
          ? Center(
            child: Row(
                children: mainLayout(position, primary),
              ),
          )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: mainLayout(position, primary),
            ),
    );
  }

  List<Widget> mainLayout(ContentPosition position, Color primary) {
    List<Widget> widgets = [
      Radio(
        mouseCursor: MouseCursor.defer,
        toggleable: toggleAble??true,
        activeColor: primary,
        groupValue: groupValue,
        value: value,
        onChanged: onChange,
      ),
      content
    ];
    return position == ContentPosition.RIGHT ||
            position == ContentPosition.BOTTOM
        ? [widgets[0], widgets[1]]
        : [widgets[1], widgets[0]];
  }
}

enum ContentPosition { RIGHT, BOTTOM, LEFT, TOP }
