import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LeftHomeScreen extends StatelessWidget {
  final TextEditingController searchController;

  const LeftHomeScreen({Key key, this.searchController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: White.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  width: 500,
                  child: TextFieldDuit(
                    border: OutlineInputBorder(),
                    controller: searchController,
                    hintText: 'Find Opportunity',
                    fillColor: Grey.brightGrey,
                    borderColor: Grey.greyedText,
                    focusedBorderColor: Black.black,
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Blue.lightNavy,
                      onPressed: () {},
                    ),
                    suffixIcon: searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Blue.lightNavy,
                            ),
                            onPressed: () {
                              searchController.clear();
                            }),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 9, 9, 9),
                child: CustomFlatButton(
                    width: 20, buttonTitle: 'Search', onPressed: () {}),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: double.maxFinite,
          color: White.white,
          child: Text(
            'Recomendation',
            style: PxText.popUpTitle.copyWith(color: Black.lightBlack),
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Container(
          height: 300,
          constraints: BoxConstraints(
              minWidth: 900, maxWidth: 1280, minHeight: 200, maxHeight: 720),
          color: White.white,
          child: Center(
            child: ListView.builder(
              // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 4,
              //   childAspectRatio: 1,
              //   crossAxisSpacing: 5,
              //   mainAxisSpacing: 5,

              // ),
              scrollDirection: Axis.horizontal,

              padding: EdgeInsets.all(5),
              itemCount: 16,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Yellow.mangoYellow)),
                  width: 202,
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [],
                  ),
                );
              },
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.all(10),
        //   width: double.maxFinite,
        //   color: White.white,
        //   child: Text(
        //     'Recently Posted',
        //     style: PxText.popUpTitle.copyWith(
        //       color: Black.lightBlack,
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   height: 1,
        // ),
        // Wrap(
        //   children: 
        //     List.generate(
        //       15,
        //        (index) {
        //         return Container(
        //           margin: EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //               border: Border.all(color: Colors.blueAccent)),
        //           width: 200,
        //           height: 500,
        //         );
        //       },
        //     ),
          
        // )
      ],
    );
  }
}
