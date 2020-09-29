import 'package:duit_yourself/common/config/screen_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_theme.dart';

class PxText {
  static final TextStyle titleBar = TextStyle(
      color: Black.black,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 16);

  static final TextStyle tTCommonsPurpleBold42W = TextStyle(
    color: Purple.barneyPurple,
    fontFamily: 'TTCommons',
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static final TextStyle tTCommonsGrey42W = TextStyle(
    color: Grey.brownGrey,
    fontFamily: 'TTCommons',
    fontSize: 12,
  );
  static final TextStyle black33W = TextStyle(
    color: Colors.black,
    fontSize: 12,
  );

  static final TextStyle white20 = TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  static final TextStyle tTCommonsBlackBold14 = TextStyle(
    color: Colors.black,
    fontFamily: 'TTCommons',
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static final TextStyle tTCommonsBlack14 = TextStyle(
    color: Colors.black,
    fontFamily: 'TTCommons',
    fontSize: 12,
  );

  static final TextStyle tTCommonsBlack25W = TextStyle(
    fontFamily: 'TTCommons',
    fontSize: 12,
  );

  static final TextStyle grey33W =
      TextStyle(color: Grey.brightGrey, fontSize: 12);

  static final TextStyle tTCommonsPurpleBold42WMedium = TextStyle(
    color: Purple.barneyPurple,
    fontFamily: 'TTCommonsRegular',
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );

  static final TextStyle tTCommonsNeonRed12Regular = TextStyle(
    color: Red.neonRed,
    fontFamily: 'TTCommonsRegular',
    fontSize: ScreenConfig().fontSize(14).toDouble(),
  );

  static final TextStyle buttonText14 = TextStyle(
    color: White.white,
    fontFamily: 'TTCommons',
    fontSize: 12,
  );

  static final TextStyle poppinsMediumPurple30 = TextStyle(
    color: Purple.barneyPurple,
    fontFamily: 'Poppins-Medium',
    fontWeight: FontWeight.normal,
    fontSize: ScreenConfig().fontSize(30).toDouble(),
  );

  static final TextStyle poppinsBold28 = TextStyle(
      fontSize: ScreenConfig().fontSize(28).toDouble(),
      color: Color(0xfffcd22a),
      fontWeight: FontWeight.bold);

  static final TextStyle poppinsBold30 =
  poppinsMediumPurple30.copyWith(fontWeight: FontWeight.bold);

  static final TextStyle ttCommonsGrey12 = TextStyle(
      color: Grey.ashGrey,
      fontFamily: 'TTCommons',
      fontSize: ScreenConfig().fontSize(14).toDouble());

  static final TextStyle taxStatusTitle = TextStyle(
      color: Black.littleLightBlack,
      fontFamily: 'TTCommonsRegular',
      fontSize: 12);

  static final TextStyle poppinsBold30W = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins-Medium',
    fontWeight: FontWeight.bold,
    fontSize: ScreenConfig().fontSize(30).toDouble(),
  );

  static final TextStyle poppinsBold22W = TextStyle(
    fontFamily: 'Poppins-Medium',
    fontWeight: FontWeight.w500,
    fontSize: ScreenConfig().fontSize(30).toDouble(),
  );

  static final TextStyle bodyCustomButton = TextStyle(
    fontFamily: 'TTCommons',
    fontSize: 12,
  );

  static final TextStyle buttonTitle = TextStyle(
    fontFamily: 'TTCommons',
    fontSize: ScreenConfig().fontSize(14),
  );

  static final TextStyle poppinsMediumRed22 = TextStyle(
    color: Red.errorColor,
    fontFamily: 'Poppins-Medium',
    fontWeight: FontWeight.normal,
    fontSize: ScreenConfig().fontSize(22).toDouble(),
  );

  static final TextStyle poppinsMediumBlack20 = TextStyle(
    fontFamily: 'Poppins-Medium',
    fontWeight: FontWeight.normal,
    fontSize: ScreenUtil().setSp(20),
  );
  static final TextStyle body14 = TextStyle(
    color: Colors.black,
    fontFamily: 'TTCommons',
    fontSize: 14,
  );
  static final TextStyle body16 = TextStyle(
    color: Colors.black,
    fontFamily: 'TTCommons',
    fontSize: 14,
  );

  static final TextStyle lableStyle12 = TextStyle(
    fontSize: 12,
    color: Colors.black,
    fontFamily: 'TTCommons',
  );
  static final TextStyle titleText = TextStyle(
      color: Grey.warmGrey, fontFamily: 'TTCommons-Medium', fontSize: 16);

  static final TextStyle contentText = TextStyle(
      color: White.white, fontFamily: 'TTCommons-Regular', fontSize: 14);

  static final TextStyle buttonText = TextStyle(
      color: Grey.warmGrey, fontFamily: 'TTCommons-Medium', fontSize: 16);

  static final TextStyle popUpTitle = TextStyle(
      color: Purple.barneyPurple,
      fontSize: 20,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold);

  static final TextStyle popUpMessage = TextStyle(
      color: Grey.warmGrey, fontSize: 16, fontFamily: 'TTCommons-Medium');
}
