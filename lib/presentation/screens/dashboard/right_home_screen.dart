import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RightHomeScreen extends StatelessWidget {
  final String username;

  const RightHomeScreen({Key key, this.username}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: White.white,
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Hi, $username!',
                      style: PxText.contentText.copyWith(
                          color: Black.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Get offers from sellers for your project',
                    style: PxText.contentText
                        .copyWith(color: Black.black, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomFlatButton(
                    buttonTitle: 'Post New Job',
                    buttonStyle: CustomButtonStyle.STYLE_THREE,
                    titleColor: Yellow.mangoYellow,
                    height: 35,
                    width: 100,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: White.white,
            height: 200,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ListView(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ListTile(
                      title: Text(
                        'See Requested Jobs',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.8,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
