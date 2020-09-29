import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class CustomDialogCsv extends Dialog {

  final Widget content;
  final String title;
  final int popIndex;
  final GlobalKey globalKey;

  CustomDialogCsv({ this.globalKey,
      @required this.content,
      @required this.title, this.popIndex = 0}) : super(key: globalKey);

@override
  Widget build(BuildContext context) {
    return AlertDialog(
          contentPadding: EdgeInsets.only(
              right: ScreenUtil().setHeight(40),
              left: ScreenUtil().setHeight(40),
              bottom: ScreenUtil().setWidth(35)),
          titlePadding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setHeight(40), vertical: 35),
          title: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.end,
            verticalDirection: VerticalDirection.up,
            children: [
              Text(
                title,
                style: PxText.popUpTitle.copyWith(
                    color: Black.black, fontSize: ScreenUtil().setSp(22)),
              ),
              _CloseDialog(
                onPressed: () {
                  // Navigator.pop(context);
                },
              )
            ],
          ),
          backgroundColor: Grey.lightGrey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: content);
  }
}

class _CloseDialog extends StatelessWidget {
  final GestureTapCallback onPressed;

  _CloseDialog({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.close),
        color: Grey.brownGrey,
        tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
        onPressed:
        () {
          Navigator.of(context).pop();
        }
        );
  }
}
