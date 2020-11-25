import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_button_widget/custom_flat_button.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/textfield_duit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralFormLayout extends StatelessWidget {
  GeneralFormLayout({
    Key key,
    this.render,
    this.normalSizeController1,
    this.mediumSizeController1,
    this.isShimmer,
    this.onSave,
    this.onCancel,
    this.normalSizeController2,
    this.normalSizeTitle1,
    this.normalSizeTitle2,
    this.mediumSizeTitle1,
    @required this.isButtonEnabled,
    this.normalSizeController3,
    this.isJobScreen,
    this.onCheckedBox,
    this.checkBoxValue,
    this.normalSizeController4,
  }) : super(key: key);

  final bool isJobScreen;
  final Function render;
  final Function onCheckedBox;
  final bool checkBoxValue;
  final TextEditingController normalSizeController1;
  final TextEditingController mediumSizeController1;
  final TextEditingController normalSizeController2;
  final TextEditingController normalSizeController3;
  final TextEditingController normalSizeController4;
  final String normalSizeTitle1;
  final String normalSizeTitle2;
  final String mediumSizeTitle1;
  final bool isShimmer;
  final Function onSave;
  final Function onCancel;
  final bool isButtonEnabled;

  @override
  Widget build(BuildContext context) {
    // print('HEAD LINE ${headline.text.isEmpty}');
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
                if (isJobScreen ?? false)
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: width * 0.0075),
                          width: width * 0.2,
                          child: Text(
                            'Set Status',
                            style: PxText.contentText.copyWith(
                                color: Black.lightBlack,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Checkbox(
                                  value: checkBoxValue,
                                  onChanged: onCheckedBox),
                            ),
                            Text(
                              checkBoxValue ? 'Open' : 'closed',
                              style: PxText.contentText.copyWith(
                                  color: Black.lightBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                row(
                    textValue: isShimmer
                        ? ''
                        : (isJobScreen ?? false)
                            ? 'Job Title'
                            : normalSizeController1.text,
                    width: width,
                    textKey: normalSizeTitle1 ?? 'Fullname',
                    controller: normalSizeController1),
                row(
                    textValue: isShimmer
                        ? ''
                        : (isJobScreen ?? false)
                            ? 'Separate with semicolon (;)'
                            : 'Headline',
                    width: width,
                    textKey: normalSizeTitle2 ?? 'Headline',
                    controller: normalSizeController2),
                if (isJobScreen ?? false)
                  Column(
                    children: [
                      row(
                        textValue: isShimmer ? '' : 'Ex: Rupiah',
                        width: width,
                        textKey: 'Currency',
                        controller: normalSizeController3,
                      ),
                      row(
                        textValue: isShimmer ? '' : '5000000',
                        width: width,
                        textKey: 'Set Your Budget',
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: normalSizeController4,
                      ),
                    ],
                  ),
                row(
                    textValue: isShimmer
                        ? ''
                        : (isJobScreen ?? false)
                            ? 'Description'
                            : 'Self Description',
                    width: width,
                    textKey: mediumSizeTitle1 ?? 'Self Description',
                    controller: mediumSizeController1)
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
                onPressed: !isButtonEnabled
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
      List<TextInputFormatter> inputFormatters,
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
                    inputFormatters: inputFormatters,
                    hintText: textValue,
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
                    maxLine: textKey == 'Self Description' ||
                            textKey == 'Description'
                        ? 3
                        : null,
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
