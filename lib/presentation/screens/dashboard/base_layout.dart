import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final dynamic arguments;
  final Widget rightColumn;
  final Widget leftColumn;
  final int flexRight;
  final int flexLeft;

  const BaseLayout(
      {Key key,
      this.arguments,
      this.rightColumn,
      this.leftColumn,
      this.flexRight,
      this.flexLeft})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // print('$flexLeft, $flexRight');
    return MouseRegion(
      // onHover: (event) => arguments(false),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.02,
                top: height * 0.02,
                right: width * 0.01,
                bottom: height * 0.02,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: White.smokeWhite,
                      ),
                      child: leftColumn == null
                          ? Center(child: Text('LEFT PART'))
                          : leftColumn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                left: width * 0.005,
                top: height * 0.02,
                right: width * 0.01,
                bottom: height * 0.02,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: White.smokeWhite,
                      ),
                      child: rightColumn == null
                          ? Center(child: Text('RIGHT PART'))
                          : rightColumn,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}