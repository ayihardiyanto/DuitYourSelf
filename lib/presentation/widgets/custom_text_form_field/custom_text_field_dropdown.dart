import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:duit_yourself/presentation/themes/color_theme.dart';
import 'package:duit_yourself/presentation/themes/px_text.dart';
import 'package:duit_yourself/presentation/widgets/custom_text_form_field/address_form_strings.dart';

// ignore: must_be_immutable
class CustomTextFieldDropdown extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final List dropdownValues;
  final bool setEnableTextField;
  final bool setEnableReadOnly;
  final bool dropdownFeature;
  final TextInputType inputType;
  final void Function(String) onChanged;
  final void Function() onTap;
  final String Function(String) validator;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode node;
  final bool isError;
  final bool autoFocus;
  final String hintText;
  final double height;
  final double width;
  final bool autovalidate;
  final TextStyle errorStyle;
  bool listEmployee;
  bool isAudiencegroupAndemployee;
  Function onTabFunction;

  CustomTextFieldDropdown({
    Key key,
    this.controller,
    this.labelText,
    this.dropdownValues,
    this.setEnableReadOnly,
    this.setEnableTextField,
    this.dropdownFeature,
    this.inputType,
    this.onChanged,
    this.onTap,
    this.validator,
    this.inputFormatters,
    @required this.node,
    this.isError,
    this.autoFocus,
    this.hintText,
    this.autovalidate,
    this.errorStyle,
    @required this.height,
    @required this.listEmployee,
    this.onTabFunction,
    isAudiencegroupAndemployee,
    this.width,
  }) : super(key: key) {
    this.isAudiencegroupAndemployee = isAudiencegroupAndemployee ?? false;
  }

  @override
  _CustomTextFieldDropDownState createState() =>
      _CustomTextFieldDropDownState();
}

class _CustomTextFieldDropDownState extends State<CustomTextFieldDropdown> {
  bool visible = false;
  String activeName = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.dropdownValues);
    final query = MediaQuery.of(context).size;
    final themeColor = Theme.of(context).primaryColor;
    if (widget.dropdownFeature == false) {
      return Container(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          focusNode: widget.node,
          style: PxText.grey33W.copyWith(
            color: widget.node.hasFocus ? themeColor : Grey.ashGrey,
          ),
          keyboardType: widget.inputType,
          readOnly: widget.setEnableReadOnly,
          enabled: widget.setEnableTextField,
          controller: widget.controller,
          decoration: InputDecoration(
            errorStyle: widget.errorStyle ?? PxText.tTCommonsBlack25W,
            filled: true,
            fillColor:
                (!widget.setEnableTextField) ? Colors.grey[200] : Colors.white,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: themeColor,
              ),
            ),
            labelText: widget.labelText,
            labelStyle: PxText.lableStyle12.copyWith(
              color: widget.node.hasFocus
                  ? (widget.isError == false || widget.isError == null
                      ? themeColor
                      : Red.errorColor)
                  : (widget.isError == false || widget.isError == null
                      ? (widget.controller.text.isEmpty
                          ? Grey.greyedText
                          : Grey.ashGrey)
                      : Red.errorColor),
            ),
          ),
          onChanged: widget.onChanged,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
        ),
      );
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: query.width,
            height: widget.height,
            child: TextFormField(
              enableInteractiveSelection: false,
              autofocus: widget.autoFocus ?? false,
              focusNode: widget.node,
              style: PxText.grey33W.copyWith(
                color: widget.node.hasFocus ? themeColor : Grey.ashGrey,
              ),
              autovalidateMode: AutovalidateMode.always,
              keyboardType: widget.inputType,
              readOnly: widget.setEnableReadOnly,
              enabled: widget.setEnableTextField,
              controller: widget.controller,
              decoration: InputDecoration(
                errorStyle: widget.errorStyle ?? PxText.tTCommonsBlack25W,
                filled: true,
                fillColor: (!widget.setEnableTextField)
                    ? Colors.grey[200]
                    : Colors.white,
                contentPadding: EdgeInsets.only(left: 10.0, right: -10.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: themeColor,
                  ),
                ),
                suffixIcon: Icon(Icons.keyboard_arrow_down,
                    color: widget.node.hasFocus ? themeColor : Colors.black54),
                labelText: widget.labelText,
                labelStyle: PxText.lableStyle12.copyWith(
                  color: widget.node.hasFocus
                      ? (widget.isError == false || widget.isError == null
                          ? themeColor
                          : Red.errorColor)
                      : (widget.isError == false || widget.isError == null
                          ? (widget.controller.text.isEmpty
                              ? Grey.greyedText
                              : Grey.ashGrey)
                          : Red.errorColor),
                ),
              ),
              onChanged: widget.onChanged,
              onTap: () {
                setState(() {
                  if (widget.validator != null) {
                    widget.validator(widget.controller.text);
                  }
                  if (widget.validator != null) {
                    widget.onChanged(widget.controller.text);
                  }
                  if (visible) {
                    visible = false;
                  } else {
                    if (!widget.setEnableReadOnly) {
                      widget.controller.text = '';
                    }
                    visible = true;
                  }
                });
              },
              validator: widget.validator,
              inputFormatters: widget.inputFormatters,
            ),
          ),
          Visibility(
            visible: visible,
            child: Container(
              width: query.width,
              height: (widget.dropdownValues.length <= 2)
                  ? 70
                  : (widget.dropdownValues.length <= 3) ? 90 : 150,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: themeColor),
              ),
              child: (widget.dropdownValues.isEmpty)
                  ? Center(
                      child: Text(
                        widget.controller.text.isEmpty
                            ? AddressFormStrings.loading
                            : AddressFormStrings.noMatches,
                        style: PxText.lableStyle12.copyWith(
                            color: widget.controller.text.isEmpty
                                ? Grey.ashGrey
                                : Colors.red,
                            fontSize: 14),
                      ),
                    )
                  : ListView(
                      children: List.generate(
                        widget.dropdownValues.length,
                        (index) {
                          var value = widget.dropdownValues[index];

                          return widget.listEmployee
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.controller.text = value.name;
                                      widget.onTap();
                                      if (widget.validator != null) {
                                        widget.validator(value.name);
                                      }
                                      if (widget.validator != null) {
                                        widget.onChanged(value.name);
                                      }
                                      if (visible) {
                                        visible = false;
                                      } else {
                                        visible = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 2.0),
                                    width: 500,
                                    height: widget.isAudiencegroupAndemployee
                                        ? 30
                                        : 22,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[300]),
                                      ),
                                    ),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Stack(
                                            children: [
                                              Align(
                                                child: Text(
                                                  value.name,
                                                  style: PxText.lableStyle12
                                                      .copyWith(
                                                          color: Grey.ashGrey,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                alignment: Alignment.topLeft,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                  value.email,
                                                  style: PxText.lableStyle12
                                                      .copyWith(
                                                          color: Grey.ashGrey,
                                                          fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              : widget.isAudiencegroupAndemployee
                                  ? GestureDetector(
                                      onTap: () {
                                        widget.onTabFunction(
                                            name: value.name,
                                            email: value.email,
                                            type: value.type);
                                        setState(() {
                                          if (widget.validator != null) {
                                            widget.validator(
                                                widget.controller.text);
                                          }
                                          if (widget.validator != null) {
                                            widget.onChanged(
                                                widget.controller.text);
                                          }
                                          if (visible) {
                                            visible = false;
                                          } else {
                                            if (!widget.setEnableReadOnly) {
                                              widget.controller.text = '';
                                            }
                                            visible = true;
                                          }
                                        });
                                      },
                                      child: value.type == 'employee'
                                          ? Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 2.0),
                                              width: 500,
                                              height: widget
                                                      .isAudiencegroupAndemployee
                                                  ? 30
                                                  : 22,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300]),
                                                ),
                                              ),
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          child: Text(
                                                            value.name,
                                                            style: PxText
                                                                .lableStyle12
                                                                .copyWith(
                                                                    color: Grey
                                                                        .ashGrey,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          alignment:
                                                              Alignment.topLeft,
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Text(
                                                            value.email,
                                                            style: PxText
                                                                .lableStyle12
                                                                .copyWith(
                                                                    color: Grey
                                                                        .ashGrey,
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 2.0),
                                              width: 500,
                                              height: widget
                                                      .isAudiencegroupAndemployee
                                                  ? 30
                                                  : 22,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300]),
                                                ),
                                              ),
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          child: Text(
                                                            value.name,
                                                            style: PxText
                                                                .lableStyle12
                                                                .copyWith(
                                                                    color: Grey
                                                                        .ashGrey,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                          alignment:
                                                              Alignment.topLeft,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                    )
                                  : MouseRegion(
                            onEnter: (_) {
                              setState(() {
                                activeName = value;
                              });
                            },
                            onExit: (_) {
                              setState(() {
                                activeName = '';
                              });
                              print( activeName);
                            },
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            widget.controller.text = value;
                                            widget.onTap();
                                            if (widget.validator != null) {
                                              widget.validator(value);
                                            }
                                            if (widget.validator != null) {
                                              widget.onChanged(value);
                                            }
                                            if (visible) {
                                              visible = false;
                                            } else {
                                              visible = true;
                                            }
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 2.0),
                                          width: 500,
                                          height: widget.listEmployee ? 40 : 22,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[300]),
                                            ),
                                          ),
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(3.0),
                                                child: Text(
                                                  value,
                                                  style: PxText.lableStyle12
                                                      .copyWith(
                                                          color: activeName == value  ? Purple.barneyPurple: widget.controller
                                                                      .text ==
                                                                  value
                                                              ? themeColor
                                                              : Grey.ashGrey,
                                                          fontSize: 14),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
