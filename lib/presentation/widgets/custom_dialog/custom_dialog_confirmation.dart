import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/confirmation_button.dart';

class CustomDialogConfirmation {
  GestureTapCallback onTap;
  String title;
  String subTitle;
  CustomDialogConfirmation(
      {@required this.title, @required this.subTitle, this.onTap});

  Future<Future> showCustomDialog({
    @required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    // child: Image.asset(AssetsConstants.assetAlert),
                    height: 92,
                    width: 92,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Purple.barneyPurple,
                            fontSize: 22,
                            fontFamily: 'Poppins-Medium')),
                    alignment: Alignment.center,
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(subTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Grey.warmGrey,
                            fontSize: 16,
                            fontFamily: 'TTCommons-Regular')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Purple.barneyPurple),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 1.5),
                        child: ConfirmButtonWidget(
                          confirmText: 'Cancel',
                          onPressed: () {
//                          Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Purple.barneyPurple),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 1.5),
                        child: ConfirmButtonWidget(
                          confirmText: 'Yes',
                          onPressed: onTap,
                          buttonColor: Purple.barneyPurple,
                          textColor: White.white,
                        ),
                      ),
                    ],
                  )
                ],
              ))
      ),
    );
  }
}
