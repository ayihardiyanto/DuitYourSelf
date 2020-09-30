import 'package:flutter/material.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/widgets/screen_layouts/screen_layout.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerTaskForm extends StatelessWidget {
  final String title;
  ShimmerTaskForm({@required this.title}):assert(title != null);
  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
        title: title,
        onPressed: null,
        buttonColor: Grey.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Shimmer(
                color: Black.black, //Default value
                enabled: true,
                child: Container(
                  height: 37,
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              Shimmer(
                color: Black.black, //Default value
                enabled: true,
                child: Container(
                  height: 100,
                  color: Colors.grey[200],
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 30,
                            width: 50,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),
                        //judul
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 10,
                            width: 150,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 20,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 20,
                            color: Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,height: 20,),
                  Container(
                    width: 500,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30,
                          width: 50,
                        ),
                        SizedBox(height: 20),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 30,
                            color: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 10),
                        Shimmer(
                          color: Black.black, //Default value
                          enabled: true,
                          child: Container(
                            height: 30,
                            color: Colors.grey[200],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  }
}
