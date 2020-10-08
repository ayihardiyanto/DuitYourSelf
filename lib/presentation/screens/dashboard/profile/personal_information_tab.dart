import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/material.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({
    Key key,
    this.render,
    this.nameController,
    this.selfDescriptionControler,
    this.isShimmer,
    this.onSave,
    this.onCancel,
    this.headline,
  }) : super(key: key);

  final Function render;
  final TextEditingController nameController;
  final TextEditingController selfDescriptionControler;
  final TextEditingController headline;
  final bool isShimmer;
  final Function onSave;
  final Function onCancel;

  @override
  Widget build(BuildContext context) {
    print('HEAD LINE ${headline.text.isEmpty}');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        bottom: height * 0.05,
        // left: width * 0.03,
        right: width * 0.03,
      ),
      constraints: BoxConstraints(minHeight: 500, maxHeight: double.infinity),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.025, top: height * 0.025),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                row(
                    textValue: isShimmer ? '' : nameController.text,
                    width: width,
                    textKey: 'Fullname',
                    controller: nameController),
                row(
                    textValue: isShimmer
                        ? ''
                        : (headline.text.isEmpty
                            ? 'Your Headline'
                            : headline.text),
                    width: width,
                    textKey: 'Headline',
                    controller: headline),
                row(
                    textValue: isShimmer ? '' : selfDescriptionControler.text,
                    width: width,
                    textKey: 'Self Description',
                    controller: selfDescriptionControler)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomFlatButton(
                buttonTitle: 'Cancel',
                buttonStyle: CustomButtonStyle.STYLE_TWO,
                height: 35,
                width: 100,
                onPressed: () {
                  onCancel();
                },
              ),
              SizedBox(
                width: 20,
              ),
              CustomFlatButton(
                buttonTitle: 'Save',
                height: 35,
                width: 100,
                onPressed: nameController.text.isEmpty
                    ? null
                    : () {
                        onSave();
                      },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget row(
      {String textValue,
      String textKey,
      double height,
      double width,
      TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: width * 0.2,
              child: Text(
                textKey + (textKey == 'Fullname' ? '*' : '  '),
                style: PxText.contentText.copyWith(
                    color: Black.lightBlack, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFieldDuit(
                    hintText: textKey.split('*')[0],
                    contentPadding: EdgeInsets.all(15),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.clear,
                                color: Black.lightBlack,
                              ),
                            ),
                            onPressed: () {
                              controller.clear();
                            })
                        : null,
                    controller: isShimmer ? null : controller,
                    margin: EdgeInsets.all(0),
                    maxLine: textKey == 'Self Description' ? 3 : null,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
