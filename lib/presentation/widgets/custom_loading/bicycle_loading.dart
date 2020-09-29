import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';

class BicycleLoading {
  final String loadingText;
  final BuildContext context;

  BicycleLoading({this.loadingText, @required this.context});

  void showLoading() {
    Navigator.of(context).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return Scaffold(
              backgroundColor: Colors.white.withOpacity(0.65),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      height: MediaQuery.of(context).size.height / 4,
                      width: MediaQuery.of(context).size.width / 4,
                      child: FlareActor(
                        'assets/animation/progressLoading.flr',
                        animation: 'progressLoading',
                        alignment: Alignment.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          loadingText ?? 'Please wait',
                          style: PxText.body14.copyWith(color: Black.black),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        JumpingDotsProgressIndicator(
                          fontSize: 20.0,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  void hideLoading() {
    Navigator.of(context).pop();
  }
}
