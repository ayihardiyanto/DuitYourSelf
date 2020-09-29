import 'package:flutter/material.dart';
import 'package:duit_yourself/common/config/screen_config.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/custom_text_form_field.dart';
import 'date_picker_custom.dart';
import 'date_picker_icon.dart';

class FormDatePicker extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String label;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool isMultiDay;
  final bool enableTap;
  final bool Function(DateTime) selectableDayPredicate;

  const FormDatePicker(
      {Key key,
      @required this.controller,
      @required this.focusNode,
      @required this.label,
      @required this.initialDate,
      @required this.firstDate,
      @required this.lastDate,
      this.isMultiDay,
      this.enableTap,
      this.selectableDayPredicate  
      })
      : super(key: key);
  @override
  _FormDatePickerState createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
  bool dateIsSelected = true;
  String selectedDate;
  
  void _handleDatePicked() {
    print('formdate ${widget.enableTap}');
    showDatePickerCustom(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      multipleDay: widget.isMultiDay,
      selectableDayPredicate: widget.selectableDayPredicate
    ).then((value) {
      if (value == null) {
        if (widget.controller.text.isEmpty) {
          setState(() {
            dateIsSelected = false;
          });
        } else {
          setState(() {
            dateIsSelected = true;
          });
        }
      } else {
        setState(() {
          dateIsSelected = true;
          result(value);
        });
      }
    });
  }

  dynamic result(DateTime input) {
    String screenResult = input.toIso8601String();
    widget.controller.text = screenResult;
    selectedDate = screenResult;
    return selectedDate;
  
  }

  @override
  Widget build(BuildContext context) {  
    return CustomTextField(
      controller: widget.controller,
      readOnly: true,
      showCursor: false,
      autovalidate: true,
      node: widget.focusNode,
      enabled: widget.enableTap,
      errorCondition: !dateIsSelected,
      validator: (value) {
        if (!dateIsSelected) {
          return 'exception';
        }
        return null;
      },
      marginTop: ScreenConfig().height(10),
      labelText: widget.label,
      suffixIcon: Icon(
        CustomIcon.date,
        size: ScreenConfig().height(17),
      ),
      onTap: () => _handleDatePicked()
    );
  }
}
