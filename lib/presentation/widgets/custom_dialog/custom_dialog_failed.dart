import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duit_yourself/common/constants/assets_constants.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';

class CustomDialogFailed {
  String title;
  String subTitle;
  CustomDialogFailed({@required this.title,@required this.subTitle, });
  Future<Future> showCustomDialog(
      {@required BuildContext context,}) async {
    return showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop();
          });
          return AlertDialog(
              contentPadding: EdgeInsets.only(
                  right: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setHeight(20),
                  bottom: ScreenUtil().setWidth(5)),
              backgroundColor: Grey.lightGrey,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                  padding: EdgeInsets.all(0),
                  height: 250,
                  width: 340,
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset(AssetsConstants.assetAlert),
                        height: 92,
                        width: 92,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(title??'Sorry',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold,
                                color:
                                Purple.barneyPurple,
                                fontSize: 22,
                                fontFamily:
                                'Poppins-Medium')),
                        alignment: Alignment.center,
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Text(
                            subTitle??'Something went wrong :(',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.normal,
                                color: Grey.warmGrey,
                                fontSize: 16,
                                fontFamily:
                                'TTCommons-Regular')),
                      ),

                    ],
                  )));}
    );
  }
}
