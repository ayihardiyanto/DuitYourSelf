
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';

// import '../../../data/models/search_employee_model.dart';
// import '../../themes/color_theme.dart';
// import '../../themes/px_text.dart';

// ///DropDownField has customized autocomplete text field functionality
// ///
// ///Parameters
// ///
// ///value - dynamic - Optional value to be set into the Dropdown field by default when this field renders
// ///
// ///icon - Widget - Optional icon to be shown to the left of the Dropdown field
// ///
// ///hintText - String - Optional Hint text to be shown
// ///
// ///hintStyle - TextStyle - Optional styling for Hint text. Default is normal, gray colored font of size 18.0
// ///
// ///labelText - String - Optional Label text to be shown
// ///
// ///labelStyle - TextStyle - Optional styling for Label text. Default is normal, gray colored font of size 18.0
// ///
// ///required - bool - True will validate that this field has a non-null/non-empty value. Default is false
// ///
// ///enabled - bool - False will disable the field. You can unset this to use the Dropdown field as a read only form field. Default is true
// ///
// ///items - List<dynamic> - List of items to be shown as suggestions in the Dropdown. Typically a list of String values.
// ///You can supply a static list of values or pass in a dynamic list using a FutureBuilder
// ///
// ///textStyle - TextStyle - Optional styling for text shown in the Dropdown. Default is bold, black colored font of size 14.0
// ///
// ///inputFormatters - List<TextInputFormatter> - Optional list of TextInputFormatter to format the text field
// ///
// ///setter - FormFieldSetter<dynamic> - Optional implementation of your setter method. Will be called internally by Form.save() method
// ///
// ///onValueChanged - ValueChanged<dynamic> - Optional implementation of code that needs to be executed when the value in the Dropdown
// ///field is changed
// ///
// ///strict - bool - True will validate if the value in this dropdown is amongst those suggestions listed.
// ///False will let user type in new values as well. Default is true
// ///
// ///itemsVisibleInDropdown - int - Number of suggestions to be shown by default in the Dropdown after which the list scrolls. Defaults to 3
// class SearchableDropDownField extends FormField<String> {
//   final dynamic value;
//   final Widget icon;
//   final FocusNode node;
//   final String hintText;
//   final TextStyle hintStyle;
//   final String labelText;
//   final TextStyle labelStyle;
//   final double height;
//   final TextStyle textStyle;
//   final bool required;
//   final bool enabledField;
//   final List<dynamic> items;
//   final List<TextInputFormatter> inputFormatters;
//   final FormFieldSetter<dynamic> setter;
//   final ValueChanged<dynamic> onValueChanged;
//   final bool strict;
//   final int itemsVisibleInDropdown;
//   final int counterText;
//   final bool errorCondition;
//   final EdgeInsets contentPadding;
//   final List<SearchEmployee> mapItems;
//   final isClearTextOnTap;

//   /// Controls the text being edited.
//   ///
//   /// If null, this widget will create its own [TextEditingController] and
//   /// initialize its [TextEditingController.text] with [initialValue].
//   final TextEditingController controller;

//   SearchableDropDownField(
//       {Key key,
//       this.isClearTextOnTap = false,
//       this.errorCondition,
//       this.mapItems,
//       this.counterText,
//       this.contentPadding,
//       this.height,
//       this.node,
//       this.controller,
//       this.value,
//       this.required = false,
//       this.icon,
//       this.hintText,
//       this.hintStyle,
//       this.labelText,
//       this.labelStyle,
//       this.inputFormatters,
//       this.items,
//       this.textStyle,
//       this.setter,
//       this.onValueChanged,
//       this.itemsVisibleInDropdown = 5,
//       this.enabledField = true,
//       this.strict = true})
//       : super(
//           key: key,
//           autovalidate: false,
//           initialValue: controller != null ? controller.text : (value ?? ''),
//           onSaved: setter,
//           builder: (FormFieldState<String> field) {
//             final DropDownFieldState state = field;
//             final ScrollController _scrollController = ScrollController();
//             final InputDecoration effectiveDecoration = InputDecoration(
//               alignLabelWithHint: true,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               contentPadding: contentPadding ?? EdgeInsets.all(10),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Grey.brightGrey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 borderSide: BorderSide(color: Purple.barneyPurple),
//               ),
//               filled: true,
//               fillColor: enabledField == true || enabledField == null
//                   ? Colors.white
//                   : Grey.brightGrey,
//               isDense: true,
//               labelText: labelText,
//               labelStyle: PxText.lableStyle12.copyWith(
//                   color: node.hasFocus
//                       ? (errorCondition == false || errorCondition == null
//                           ? Purple.barneyPurple
//                           : Red.errorColor)
//                       : Grey.greyedText),
//               hintText: hintText,
//               counterText: counterText ?? '',
//               icon: icon,
//               suffixIcon: Icon(Icons.keyboard_arrow_down,
//                   size: 20.0, color: Colors.black),
//               hintStyle: hintStyle,
//             );

//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   height: height ?? 37,
//                   child: TextFormField(
//                     focusNode: node,
//                     autovalidate: true,
//                     controller: state._effectiveController,
//                     decoration: effectiveDecoration.copyWith(
//                         errorText: field.errorText),
//                     style: textStyle ??
//                         PxText.body14
//                             .copyWith(color: Grey.brownGrey, fontSize: 12),
//                     textAlign: TextAlign.start,
//                     autofocus: false,
//                     obscureText: false,
//                     maxLengthEnforced: true,
//                     onChanged: (value) {},
//                     onTap: () {
//                       // ignore: invalid_use_of_protected_member
//                       state.setState(() {
//                         state.isFirstLoad = false;
//                         if (isClearTextOnTap) {
//                           state.clearValue();
//                         }
//                         if (state.containerHeight != 0) {
//                           // state._showdropdown = false;
//                           state.containerHeight = 0;
//                         } else {
//                           // state._showdropdown = true;
//                           state.containerHeight = state.showDropdown();
//                         }
//                       });
//                     },
//                     maxLines: 1,
//                     validator: (String newValue) {
//                       if (required) {
//                         if (newValue == null || newValue.isEmpty) {
//                           return 'This field cannot be empty!';
//                         }
//                       }

//                       //Items null check added since there could be an initial brief period of time
//                       //when the dropdown items will not have been loaded
//                       if (items != null) {
//                         if (strict &&
//                             newValue.isNotEmpty &&
//                             !items.contains(newValue)) {
//                           return 'Invalid value in this field!';
//                         }
//                       }

//                       return null;
//                     },
//                     onSaved: setter,
//                     enabled: enabledField,
//                     inputFormatters: inputFormatters,
//                   ),
//                 ),
//                 // if (!state._showdropdown)
//                 //   Container()

//                 if (mapItems == null)
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.0),
//                       border: Border.all(color: Purple.barneyPurple),
//                     ),
//                     alignment: Alignment.topCenter,
//                     height: state
//                         .containerHeight, //limit to default 3 items in dropdownlist view and then remaining scrolls
//                     width: MediaQuery.of(field.context).size.width,
//                     child: ListView(
//                       cacheExtent: 0.0,
//                       scrollDirection: Axis.vertical,
//                       controller: _scrollController,
//                       padding: EdgeInsets.only(left: 20.0, right: 20),
//                       children: items.isNotEmpty
//                           ? ListTile.divideTiles(
//                                   context: field.context,
//                                   tiles: state._getChildren(state._items))
//                               .toList()
//                           : [],
//                     ),
//                   ),
//                 // if (mapItems != null && state._showdropdown)
//                 if (mapItems != null)
//                   AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.0),
//                       border: Border.all(color: Purple.barneyPurple),
//                     ),
//                     alignment: Alignment.topCenter,
//                     height: state
//                         .containerHeight, //limit to default 3 items in dropdownlist view and then remaining scrolls
//                     width: MediaQuery.of(field.context).size.width,
//                     child: ListView(
//                       cacheExtent: 0.0,
//                       scrollDirection: Axis.vertical,
//                       controller: _scrollController,
//                       padding: EdgeInsets.only(left: 10.0, right: 10),
//                       children: mapItems.isNotEmpty
//                           ? ListTile.divideTiles(
//                                   context: field.context,
//                                   tiles: state._getMapChildren(state._mapItems))
//                               .toList()
//                           : [],
//                     ),
//                   ),
//               ],
//             );
//           },
//         );

//   @override
//   DropDownFieldState createState() => DropDownFieldState();
// }

// class DropDownFieldState extends FormFieldState<String> {
//   TextEditingController _controller;
//   // bool _showdropdown = false;
//   double containerHeight = 0;
//   bool _isSearching = true;
//   String _searchText = '';
//   bool isFirstLoad = true;
//   String activeName = '';
//   @override
//   SearchableDropDownField get widget => super.widget;
//   TextEditingController get _effectiveController =>
//       widget.controller ?? _controller;

//   List<String> get _items => widget.items;
//   List<SearchEmployee> get _mapItems => widget.mapItems;

//   void toggleDropDownVisibility() {}

//   void clearValue() {
//     setState(() {
//       _effectiveController.text = '';
//     });
//   }

//   double showDropdown() {
//     double containerHeight;
//     containerHeight = (_mapItems.length <= 5
//         ? _mapItems.length * 59
//         : widget.itemsVisibleInDropdown * 59) as double;
//     return containerHeight;
//   }

//   @override
//   void didUpdateWidget(SearchableDropDownField oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.controller != oldWidget.controller) {
//       oldWidget.controller?.removeListener(_handleControllerChanged);
//       widget.controller?.addListener(_handleControllerChanged);

//       if (oldWidget.controller != null && widget.controller == null) {
//         _controller =
//             TextEditingController.fromValue(oldWidget.controller.value);
//       }
//       if (widget.controller != null) {
//         setValue(widget.controller.text);
//         if (oldWidget.controller == null) _controller = null;
//       }
//     }
//   }

//   @override
//   void dispose() {
//     widget.controller?.removeListener(_handleControllerChanged);
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _isSearching = false;
//     if (widget.controller == null) {
//       _controller = TextEditingController(text: widget.initialValue);
//     }

//     _effectiveController.addListener(_handleControllerChanged);

//     _searchText = _effectiveController.text;
//   }

//   @override
//   void reset() {
//     super.reset();
//     setState(() {
//       _effectiveController.text = widget.initialValue;
//     });
//   }

//   List<ListTile> _getChildren(List<String> items) {
//     List<ListTile> childItems = [];
//     for (var item in items) {
//       if (_searchText.isNotEmpty) {
//         if (item.toUpperCase().contains(_searchText.toUpperCase())) {
//           childItems.add(_getListTile(item));
//         }
//       } else {
//         childItems.add(_getListTile(item));
//       }
//     }
//     // ignore: unnecessary_statements
//     _isSearching ? childItems : [];
//     return childItems;
//   }

//   ListTile _getListTile(String text) {
//     return ListTile(
//       dense: true,
//       title: Text(
//         text,
//         style: PxText.lableStyle12.copyWith(
//           color: Grey.brownGrey,
//           fontSize: 14,
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           if (widget.isClearTextOnTap) {
//             _effectiveController.text = '';
//           } else {
//             _effectiveController.text = text;
//           }
//           _handleControllerChanged();
//           // _showdropdown = false;
//           containerHeight = 0;
//           _isSearching = false;
//           if (widget.onValueChanged != null) widget.onValueChanged(text);
//         });
//       },
//     );
//   }

//   List<Widget> _getMapChildren(List<SearchEmployee> items) {
//     List<Widget> childItems = [];
//     for (var itemData in items) {
//       String item = itemData.name;
//       if (_searchText.isNotEmpty) {
//         if (item.toUpperCase().contains(_searchText.toUpperCase())) {
//           childItems.add(_getMapListTile(itemData));
//         }
//       } else {
//         childItems.add(_getMapListTile(itemData));
//       }
//     }
//     // ignore: unnecessary_statements
//     _isSearching ? childItems : [];
//     return childItems;
//   }

//   Widget _getMapListTile(SearchEmployee text) {

//     return MouseRegion(
//       onEnter: (_) {
//         setState(() {
//           activeName = text.name;
//         });
//       },
//       onExit: (_) {
//         setState(() {
//           activeName = '';
//         });
//         print( activeName);
//       },
//       child: InkWell(
//         onTap: () {
//           setState(() {
//             if (widget.isClearTextOnTap) {
//               _effectiveController.text = '';
//             } else {
//               _effectiveController.text = text.name;
//             }
//             _handleControllerChanged();
//             // _showdropdown = false;
//             if(!widget.isClearTextOnTap){
//               containerHeight = 0;
//             }
//             _isSearching = false;
//             if (widget.onValueChanged != null) widget.onValueChanged(text);
//           });
//         },
//         child: AnimatedContainer(
//           padding: EdgeInsets.all(10),
// //      hoverColor: Purple.barneyPurple,
//         duration: Duration(milliseconds: 100),
// //      dense: false,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 text.name,
//                 style: PxText.lableStyle12.copyWith(
//                   color:activeName == text.name ? Purple.barneyPurple: Grey.brownGrey,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 text.email,
//                 style: PxText.lableStyle12.copyWith(
//                   color:activeName == text.name ? Purple.barneyPurple.withOpacity(0.5): Grey.greyedText,
//                   fontSize: 12,
//                 ),
//               ),
//             ],
//           ),

//         ),
//       ),
//     );
//   }

//   void _handleControllerChanged() {
//     // Suppress changes that originated from within this class.
//     //
//     // In the case where a controller has been passed in to this widget, we
//     // register this change listener. In these cases, we'll also receive change
//     // notifications for changes originating from within this class -- for
//     // example, the reset() method. In such cases, the FormField value will
//     // already have been set.
//     if (_effectiveController.text != value) {
//       didChange(_effectiveController.text);
//     }

//     if (_effectiveController.text.isEmpty) {
//       setState(() {
//         _isSearching = false;
//         _searchText = '';
//       });
//     } else {
//       setState(() {
//         _isSearching = true;
//         _searchText = _effectiveController.text;
//         if (!isFirstLoad) {
//           // _showdropdown = true;

//           containerHeight = showDropdown();
//         }
//       });
//     }
//   }
// }
