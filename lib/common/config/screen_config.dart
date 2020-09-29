import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ScreenConfig {
  double hFactor = 8.2;
  double wFactor = 3.75;

  static double actualHeight;
  static double actualWidth;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  static double _blockWidth = 0;
  static double _blockHeight = 0;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      actualWidth = constraints.maxWidth;
      actualHeight = constraints.maxHeight;
      isPortrait = true;
      if (actualWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      actualWidth = constraints.maxHeight;
      actualHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = actualWidth / 100;
    _blockHeight = actualHeight / 100;

    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }


///@param [size] is the size of the font on UI design
///height and width size is based on density of the screen

  double height(num size) => (size / hFactor) * heightMultiplier;

  double width(num size) => (size / wFactor) * widthMultiplier;

///@param [size] is the size of the font on UI design
///@param [allowFontScalingSelf] is used whenever the text need to be scaled based on density of the screen
///You can set @param [allowFontScalingSelf] true if you need to scale text
///and set it to false, or leave it blank if you desired to have the text follow the system [textScaleFactor] 

  double fontSize(num size, {bool allowFontScalingSelf}) => allowFontScalingSelf == null || allowFontScalingSelf == false ? size.toDouble() : height(size);
}
