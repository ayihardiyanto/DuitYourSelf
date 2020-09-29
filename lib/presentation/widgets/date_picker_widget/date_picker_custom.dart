// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:duit_yourself/presentation/themes/color_theme.dart';


// Examples can assume:
// BuildContext context;

/// Initial display mode of the date picker dialog.
///
/// Date picker UI mode for either showing a list of available years or a
/// monthly calendar initially in the dialog shown by calling [showDatePicker].
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
enum DatePickerMode {
  /// Show a date picker UI for choosing a month and day.
  day,

  /// Show a date picker UI for choosing a year.
  year,
}

const Duration _kMonthScrollDuration = Duration(milliseconds: 200);
const double _kDayPickerRowHeight = 38.0;
const int _kMaxDayPickerRowCount =
    7; //  A 31 day month that starts on Saturday.
// Two extra rows: one for the day-of-week header and one for the month header.
const double _kMaxDayPickerHeight =
    _kDayPickerRowHeight * (_kMaxDayPickerRowCount + 1);

// Shows the selected date in large font and toggles between year and day mode
class DatePickerHeader extends StatefulWidget {
  DatePickerHeader({
    @required this.selectedDate,
    @required this.mode,
    @required this.onModeChanged,
    @required this.orientation,
    @required this.selectedMonth,
  })  : assert(selectedDate != null),
        assert(mode != null),
        assert(orientation != null);
  final DateTime selectedDate;
  final DatePickerMode mode;
  final ValueChanged<DatePickerMode> onModeChanged;
  final Orientation orientation;
  final DateTime selectedMonth;

  @override
  State<StatefulWidget> createState() => _DatePickerHeader(
      selectedDate: selectedDate,
      mode: mode,
      onModeChanged: onModeChanged,
      orientation: orientation,
      selectedMonth: selectedMonth);
}

class _DatePickerHeader extends State<DatePickerHeader> {
  _DatePickerHeader({
    this.selectedDate,
    this.mode,
    this.onModeChanged,
    this.orientation,
    this.selectedMonth,
  });
  final DateTime selectedDate;
  final DatePickerMode mode;
  final ValueChanged<DatePickerMode> onModeChanged;
  final Orientation orientation;
  final DateTime selectedMonth;

  void _handleChangeMode(DatePickerMode value) {
    if (value != mode) onModeChanged(value);
  }

  Widget dayButton(backgroundColor, localizations, dayStyle) {
    return IgnorePointer(
      ignoring: mode == DatePickerMode.day,
      ignoringSemantics: false,
      child: _DateHeaderButton(
        color: backgroundColor,
        onTap: Feedback.wrapForTap(
            () => _handleChangeMode(DatePickerMode.day), context),
        child: Semantics(
          selected: mode == DatePickerMode.day,
          child: Text(
              localizations.formatMonthYear(selectedMonth).split(' ')[0],
              style: dayStyle),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final MaterialLocalizations localizations =
    //     MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final TextTheme headerTextTheme = themeData.primaryTextTheme;
    // Color dayColor;
    Color yearColor;
    switch (themeData.primaryColorBrightness) {
      case Brightness.light:
        // dayColor =
        //     mode == DatePickerMode.day ? Yellow.sunYellow : Colors.black54;
        yearColor =
            mode == DatePickerMode.year ? Colors.black54 : Colors.black54;
        break;
      case Brightness.dark:
        // dayColor =
        //     mode == DatePickerMode.day ? Yellow.sunYellow : Colors.white70;
        yearColor = mode == DatePickerMode.year ? Colors.white : Colors.white;
        break;
    }
    // day style for header
    // final TextStyle dayStyle =
    //     headerTextTheme.headline4.copyWith(color: dayColor);
    final TextStyle yearStyle =
        headerTextTheme.subtitle1.copyWith(color: yearColor);

    Color backgroundColor;
    switch (themeData.brightness) {
      case Brightness.light:
        backgroundColor = themeData.dialogBackgroundColor;
        break;
      case Brightness.dark:
        backgroundColor = themeData.dialogBackgroundColor;
        break;
    }

    EdgeInsets padding;
    MainAxisAlignment mainAxisAlignment;
    switch (orientation) {
      case Orientation.portrait:
        padding = const EdgeInsets.all(8.0);
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case Orientation.landscape:
        padding = const EdgeInsets.all(8.0);
        mainAxisAlignment = MainAxisAlignment.center;
        break;
    }

    final Widget yearButton = IgnorePointer(
      ignoring: mode != DatePickerMode.day,
      ignoringSemantics: false,
      child: _DateHeaderButton(
        color: Colors.transparent,
        onTap: Feedback.wrapForTap(
            () => _handleChangeMode(DatePickerMode.year), context),
        child: Semantics(
          selected: mode == DatePickerMode.year,
          child: Container(
            width: 20.0,
            child: Text('',
                // localizations.formatYear(selectedDate),
                style: yearStyle),
          ),
        ),
      ),
    );

    return Container(
      margin: EdgeInsets.only(
        left: 10.0,
      ),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width * 0.1,
      padding: padding,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // dayButton(backgroundColor, localizations, dayStyle),
              // SizedBox(height: MediaQuery.of(context).size.height* 0.02),
              yearButton
            ],
          ),
        ],
      ),
    );
  }
}

class _DateHeaderButton extends StatelessWidget {
  const _DateHeaderButton({
    Key key,
    this.onTap,
    this.color,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Material(
      type: MaterialType.button,
      color: color,
      child: InkWell(
        borderRadius: kMaterialEdges[MaterialType.button],
        highlightColor: theme.highlightColor,
        splashColor: theme.splashColor,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: child,
        ),
      ),
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // print('const ${constraints.crossAxisExtent}');
    // print('cons ${constraints.viewportMainAxisExtent}');
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double viewTileHeight = constraints.viewportMainAxisExtent /
        _kMaxDayPickerRowCount;
    final double tileHeight = math.max(_kDayPickerRowHeight, viewTileHeight);
    // final double tileHeight = ScreenConfig().height(47);
    // print('layout $tileHeight');
    return SliverGridRegularTileLayout(
      crossAxisCount: columnCount,
      mainAxisStride: tileHeight,
      crossAxisStride: tileWidth,
      childMainAxisExtent: tileHeight,
      childCrossAxisExtent: tileWidth,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _kDayPickerGridDelegate = _DayPickerGridDelegate();

/// Displays the days of a given month and allows choosing a day.
///
/// The days are arranged in a rectangular grid with one column for each day of
/// the week.
///
/// The day picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
///
class DayPicker extends StatelessWidget {
  /// Creates a day picker.
  ///
  /// Rarely used directly. Instead, typically used as part of a [MonthPicker].
  DayPicker({
    Key key,
    @required this.selectedDate,
    @required this.currentDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    @required this.displayedMonth,
    this.selectableDayPredicate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.multipleDay,
    this.initialDate,
  })  : assert(selectedDate != null),
        assert(currentDate != null),
        assert(onChanged != null),
        assert(displayedMonth != null),
        assert(dragStartBehavior != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag gesture used to scroll a
  /// date picker wheel will begin upon the detection of a drag gesture. If set
  /// to [DragStartBehavior.down] it will begin when a down event is first
  /// detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;
  // Is Using to give decoration background color from initialDate to selectedDate
  final bool multipleDay;

  final DateTime initialDate;

  static const List<String> _shortWeekdays = <String>[
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];

  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  List<Widget> _getDayHeaders(
      TextStyle headerStyle, MaterialLocalizations localizations) {
    final List<Widget> result = <Widget>[];
    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = _shortWeekdays[i];
      result.add(ExcludeSemantics(
        child: Center(child: Text(weekday, style: headerStyle)),
      ));
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
    }
    return result;
  }

  // Do not use this directly - call getDaysInMonth instead.
  static const List<int> _daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  /// Returns the number of days in a month, according to the proleptic
  /// Gregorian calendar.
  ///
  /// This applies the leap year logic introduced by the Gregorian reforms of
  /// 1582. It will not give valid results for dates prior to that time.
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    return _daysInMonth[month - 1];
  }

  /// Computes the offset from the first day of week that the first day of the
  /// [month] falls on.
  ///
  /// For example, September 1, 2017 falls on a Friday, which in the calendar
  /// localized for United States English appears as:
  ///
  /// ```
  /// S M T W T F S
  /// _ _ _ _ _ 1 2
  /// ```
  ///
  /// The offset for the first day of the months is the number of leading blanks
  /// in the calendar, i.e. 5.
  ///
  /// The same date localized for the Russian calendar has a different offset,
  /// because the first day of week is Monday rather than Sunday:
  ///
  /// ```
  /// M T W T F S S
  /// _ _ _ _ 1 2 3
  /// ```
  ///
  /// So the offset is 4, rather than 5.
  ///
  /// This code consolidates the following:
  ///
  /// - [DateTime.weekday] provides a 1-based index into days of week, with 1
  ///   falling on Monday.
  /// - [MaterialLocalizations.firstDayOfWeekIndex] provides a 0-based index
  ///   into the [MaterialLocalizations.narrowWeekdays] list.
  /// - [MaterialLocalizations.narrowWeekdays] list provides localized names of
  ///   days of week, always starting with Sunday and ending with Saturday.
  int _computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final int year = displayedMonth.year;
    final int month = displayedMonth.month;
    final int daysInMonth = getDaysInMonth(year, month);
    final int firstDayOffset =
        _computeFirstDayOffset(year, month, localizations);
    final List<Widget> labels = <Widget>[
      ..._getDayHeaders(themeData.textTheme.headline2, localizations),
    ];
    int count = 0;
    for (int i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
      // a leap year.
      final int day = i - firstDayOffset + 1;
      int countDaysAfterMonth = 35 - daysInMonth - firstDayOffset;
      int counterMonth = getDaysInMonth(year, month == 1 ? month : month - 1);
      if (day > daysInMonth) {
        count++;
        if (countDaysAfterMonth == -2 && count == 6) break;
        if (count == countDaysAfterMonth + 1 || count == 7) break;
      }
      if (day < 1) {
        labels.add(Center(
            child: Container(
          child: Text(
            '${day + counterMonth}',
            style: themeData.textTheme.bodyText2.copyWith(
                color: Purple.royalPurple, fontWeight: FontWeight.bold),
          ),
        )));
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool disabled = dayToBuild.isAfter(lastDate) ||
            dayToBuild.isBefore(firstDate) ||
            (selectableDayPredicate != null &&
                !selectableDayPredicate(dayToBuild));
        final bool multiple = dayToBuild.isAfter(initialDate) &&
            dayToBuild.isBefore(selectedDate);
        final bool isInitialDay = initialDate.year == year &&
            initialDate.month == month &&
            initialDate.day == day;
        BoxDecoration decoration;
        TextStyle itemStyle = TextStyle(
            color: themeData.textSelectionColor,
            fontFamily: 'TTCommons',
            fontWeight: FontWeight.bold);

        final bool isSelectedDay = selectedDate.year == year &&
            selectedDate.month == month &&
            selectedDate.day == day;
        if (isInitialDay && multipleDay) {
          decoration = BoxDecoration(
            color: themeData.buttonColor,
            // shape: BoxShape.circle
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          );
        }else if(isSelectedDay && multipleDay){
          decoration = BoxDecoration(
            color: themeData.buttonColor,
            // shape: BoxShape.circle
            borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
          );
        }else if (multiple && multipleDay) {
          decoration = BoxDecoration(
            color: themeData.dividerColor,
            shape: BoxShape.rectangle,
          );
        }
        else if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a contrasting text color.
          itemStyle = themeData.textTheme.bodyText2;
          decoration = BoxDecoration(
            color: themeData.buttonColor,
            shape: BoxShape.circle
          );
        } else if (disabled) {
          itemStyle = themeData.textTheme.bodyText2.copyWith(
              color: themeData.disabledColor, fontWeight: FontWeight.bold);
        } else if (currentDate.year == year &&
            currentDate.month == month &&
            currentDate.day == day) {
          // The current day gets a different text color.
          itemStyle = themeData.textTheme.bodyText1.copyWith(
            color: themeData.accentColor,
          );
        }

        Widget dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Semantics(
              // We want the day of month to be spoken first irrespective of the
              // locale-specific preferences or TextDirection. This is because
              // an accessibility user is more likely to be interested in the
              // day of month before the rest of the date, as they are looking
              // for the day of month. To do that we prepend day of month to the
              // formatted full date.
              label:
                  '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              sortKey: OrdinalSortKey(day.toDouble()),
              child: ExcludeSemantics(
                child: Text(
                    day <= daysInMonth
                        ? localizations.formatDecimal(day)
                        : day > daysInMonth
                            ? localizations.formatDecimal(day - daysInMonth)
                            : localizations.formatDecimal(day - 30),
                    //styling
                    style: day <= daysInMonth
                        ? itemStyle
                        : themeData.textTheme.bodyText2.copyWith(
                            color: Purple.royalPurple,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        );

        if (!disabled) {
          dayWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              onChanged(dayToBuild);
            },
            child: dayWidget,
            dragStartBehavior: dragStartBehavior,
          );
        }

        labels.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          // Container(
          //   // height: _kDayPickerRowHeight,
          //   child: Center(
          //     child: ExcludeSemantics(
          //       child: Text('',
          //           style: TextStyle(color: Colors.white)),
          //     ),
          //   ),
          // ),
          Flexible(
            child: GridView.custom(
              gridDelegate: _kDayPickerGridDelegate,
              childrenDelegate:
                  SliverChildListDelegate(labels, addRepaintBoundaries: false),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

/// A scrollable list of months to allow picking a month.
///
/// Shows the days of each month in a rectangular grid with one column for each
/// day of the week.
///
/// The month picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
class MonthPicker extends StatefulWidget {
  /// Creates a month picker.
  ///
  /// Rarely used directly. Instead, typically used as part of the dialog shown
  /// by [showDatePicker].
  MonthPicker({
    Key key,
    @required this.selectedDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    this.selectableDayPredicate,
    this.dragStartBehavior = DragStartBehavior.start,
    this.multipleDay,
    this.initialDate,
  })  : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(selectedDate.isAfter(firstDate) ||
            selectedDate.isAtSameMomentAs(firstDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a month.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;
  // To give decoration between initialDate to selectedDate
  final bool multipleDay;

  final DateTime initialDate;

  @override
  _MonthPickerState createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker>
    with SingleTickerProviderStateMixin {
  // static final Animatable<double> _chevronOpacityTween =
  //     Tween<double>(begin: 1.0, end: 0.0)
  //         .chain(CurveTween(curve: Curves.easeInOut));

  @override
  void initState() {
    super.initState();
    // Initially display the pre-selected date.
    final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
    _dayPickerController = PageController(initialPage: monthPage);
    _handleMonthPageChanged(monthPage);
    _updateCurrentDate();

    // Setup the fade animation for chevrons
    _chevronOpacityController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    // _chevronOpacityAnimation =
    //     _chevronOpacityController.drive(_chevronOpacityTween);
  }

  @override
  void didUpdateWidget(MonthPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      final int monthPage = _monthDelta(widget.firstDate, widget.selectedDate);
      _dayPickerController = PageController(initialPage: monthPage);
      _handleMonthPageChanged(monthPage);
    }
  }

  MaterialLocalizations localizations;
  TextDirection textDirection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
  }

  DateTime _todayDate;
  DateTime _currentDisplayedMonthDate;
  Timer _timer;
  PageController _dayPickerController;
  AnimationController _chevronOpacityController;
  // Animation<double> _chevronOpacityAnimation;

  void _updateCurrentDate() {
    _todayDate = DateTime.now();
    final DateTime tomorrow =
        DateTime(_todayDate.year, _todayDate.month, _todayDate.day + 1);
    Duration timeUntilTomorrow = tomorrow.difference(_todayDate);
    timeUntilTomorrow +=
        const Duration(seconds: 1); // so we don't miss it by rounding
    _timer?.cancel();
    _timer = Timer(timeUntilTomorrow, () {
      setState(() {
        _updateCurrentDate();
      });
    });
  }

  static int _monthDelta(DateTime startDate, DateTime endDate) {
    return (endDate.year - startDate.year) * 12 +
        endDate.month -
        startDate.month;
  }

  /// Add months to a month truncated date.
  DateTime _addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
    return DateTime(
        monthDate.year + monthsToAdd ~/ 12, monthDate.month + monthsToAdd % 12);
  }

  Widget _buildItems(BuildContext context, int index) {
    DateTime month = _addMonthsToMonthDate(widget.firstDate, index);
    return DayPicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: _todayDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
      dragStartBehavior: widget.dragStartBehavior,
      initialDate: widget.initialDate,
      multipleDay: widget.multipleDay,
    );
  }

  void _handleNextMonth() {
    if (!_isDisplayingLastMonth) {
      SemanticsService.announce(
          localizations.formatMonthYear(_nextMonthDate), textDirection);
      _dayPickerController.nextPage(
          duration: _kMonthScrollDuration, curve: Curves.ease);
    }
  }

  void _handlePreviousMonth() {
    if (!_isDisplayingFirstMonth) {
      SemanticsService.announce(
          localizations.formatMonthYear(_previousMonthDate), textDirection);
      _dayPickerController.previousPage(
          duration: _kMonthScrollDuration, curve: Curves.ease);
    }
  }

  /// True if the earliest allowable month is displayed.
  bool get _isDisplayingFirstMonth {
    return !_currentDisplayedMonthDate
        .isAfter(DateTime(widget.firstDate.year, widget.firstDate.month));
  }

  /// True if the latest allowable month is displayed.
  bool get _isDisplayingLastMonth {
    return !_currentDisplayedMonthDate
        .isBefore(DateTime(widget.lastDate.year, widget.lastDate.month));
  }

  DateTime _previousMonthDate;
  DateTime _nextMonthDate;

  void _handleMonthPageChanged(int monthPage) {
    setState(() {
      monthPage = monthPage;
      _previousMonthDate =
          _addMonthsToMonthDate(widget.firstDate, monthPage - 1);
      _currentDisplayedMonthDate =
          _addMonthsToMonthDate(widget.firstDate, monthPage);
      _nextMonthDate = _addMonthsToMonthDate(widget.firstDate, monthPage + 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // The month picker just adds month navigation to the day picker, so make
      // it the same height as the DayPicker
      height: _kMaxDayPickerHeight + 150,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              child: Semantics(
                sortKey: _MonthPickerSortKey.calendar,
                child: NotificationListener<ScrollStartNotification>(
                  onNotification: (_) {
                    _chevronOpacityController.forward();
                    return false;
                  },
                  child: NotificationListener<ScrollEndNotification>(
                    onNotification: (_) {
                      _chevronOpacityController.reverse();
                      return false;
                    },
                    child: PageView.builder(
                      dragStartBehavior: widget.dragStartBehavior,
                      key: ValueKey<DateTime>(widget.selectedDate),
                      controller: _dayPickerController,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _monthDelta(widget.firstDate, widget.lastDate) + 1,
                      itemBuilder: _buildItems,
                      onPageChanged: _handleMonthPageChanged,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, top: 20),
            child: Text(
                '${localizations.formatMonthYear(_currentDisplayedMonthDate)}'
                    .split(' ')[0],
                style: Theme.of(context).textTheme.headline1),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, top: 60),
            child: Text(
              '${localizations.formatMonthYear(_currentDisplayedMonthDate)}'
                  .split(' ')[1],
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          PositionedDirectional(
            top: 10.0,
            end: 60,
            child: Semantics(
              sortKey: _MonthPickerSortKey.previousMonth,
              child: ButtonTheme(
                // minWidth: 1,
                height: 40,
                child: MaterialButton(
                  shape: CircleBorder(),
                  color: Theme.of(context).cursorColor,
                  child: Icon(Icons.chevron_left, color: White.white),
                  // tooltip: _isDisplayingFirstMonth
                  //     ? null
                  //     : '${localizations.previousMonthTooltip} ${localizations.formatMonthYear(_previousMonthDate)}',
                  onPressed:
                      _isDisplayingFirstMonth ? null : _handlePreviousMonth,
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: 10.0,
            end: 5.0,
            child: Semantics(
              sortKey: _MonthPickerSortKey.nextMonth,
              child: ButtonTheme(
                // minWidth: 10,
                height: 40,
                child: MaterialButton(
                  shape: CircleBorder(),
                  color: Theme.of(context).cursorColor,
                  child: Icon(
                    Icons.chevron_right,
                    color: White.white,
                  ),
                  // tooltip: _isDisplayingLastMonth
                  //     ? null
                  //     : '${localizations.nextMonthTooltip} ${localizations.formatMonthYear(_nextMonthDate)}',
                  onPressed: _isDisplayingLastMonth ? null : _handleNextMonth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _chevronOpacityController?.dispose();
    _dayPickerController?.dispose();
    super.dispose();
  }
}

// Defines semantic traversal order of the top-level widgets inside the month
// picker.
class _MonthPickerSortKey extends OrdinalSortKey {
  const _MonthPickerSortKey(double order) : super(order);

  static const _MonthPickerSortKey previousMonth = _MonthPickerSortKey(1.0);
  static const _MonthPickerSortKey nextMonth = _MonthPickerSortKey(2.0);
  static const _MonthPickerSortKey calendar = _MonthPickerSortKey(3.0);
}

/// A scrollable list of years to allow picking a year.
///
/// The year picker widget is rarely used directly. Instead, consider using
/// [showDatePicker], which creates a date picker dialog.
///
/// Requires one of its ancestors to be a [Material] widget.
///
/// See also:
///
///  * [showDatePicker], which shows a dialog that contains a material design
///    date picker.
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
class YearPicker extends StatefulWidget {
  /// Creates a year picker.
  ///
  /// The [selectedDate] and [onChanged] arguments must not be null. The
  /// [lastDate] must be after the [firstDate].
  ///
  /// Rarely used directly. Instead, typically used as part of the dialog shown
  /// by [showDatePicker].
  YearPicker({
    Key key,
    @required this.selectedDate,
    @required this.onChanged,
    @required this.firstDate,
    @required this.lastDate,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  @override
  _YearPickerState createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  static const double _itemExtent = 50.0;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      // Move the initial scroll position to the currently selected date's year.
      initialScrollOffset:
          (widget.selectedDate.year - widget.firstDate.year) * _itemExtent,
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    final ThemeData themeData = Theme.of(context);
    final TextStyle style = TextStyle(color: Grey.lightGrey, fontSize: 15.0);
    return SizedBox(
      height: 500,
      child: ListView.builder(
        dragStartBehavior: widget.dragStartBehavior,
        controller: scrollController,
        itemExtent: _itemExtent,
        itemCount: widget.lastDate.year - widget.firstDate.year + 1,
        itemBuilder: (BuildContext context, int index) {
          final int year = widget.firstDate.year + index;
          final bool isSelected = year == widget.selectedDate.year;
          final TextStyle itemStyle = isSelected
              ? themeData.textTheme.headline5
                  .copyWith(color: themeData.buttonColor)
              : style;
          return InkWell(
            key: ValueKey<int>(year),
            onTap: () {
              widget.onChanged(DateTime(
                  year, widget.selectedDate.month, widget.selectedDate.day));
            },
            child: Center(
              child: Semantics(
                selected: isSelected,
                child: Text(year.toString(), style: itemStyle),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DatePickerDialog extends StatefulWidget {
  const _DatePickerDialog({
    Key key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.initialDatePickerMode,
    this.entity,
    this.multipleDay,
  }) : super(key: key);

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final SelectableDayPredicate selectableDayPredicate;
  final DatePickerMode initialDatePickerMode;
  final String entity;
  final bool multipleDay;

  @override
  _DatePickerDialogState createState() => _DatePickerDialogState();
}

class _DatePickerDialogState extends State<_DatePickerDialog> {
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _mode = widget.initialDatePickerMode;
  }

  bool _announcedInitialDate = false;

  MaterialLocalizations localizations;
  TextDirection textDirection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations = MaterialLocalizations.of(context);
    textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        localizations.formatFullDate(_selectedDate),
        textDirection,
      );
    }
  }

  DateTime _selectedDate;
  DatePickerMode _mode;
  final GlobalKey _pickerKey = GlobalKey();
  Orientation orientation;
  bool singleClick= false;

  void _vibrate() {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        HapticFeedback.vibrate();
        break;
      case TargetPlatform.iOS:
        break;
      case TargetPlatform.linux:
        break;
      case TargetPlatform.macOS:
        break;
      case TargetPlatform.windows:
        break;
    }
  }

  void _handleModeChanged(DatePickerMode mode) {
    _vibrate();
    setState(() {
      _mode = mode;
      if (_mode == DatePickerMode.day) {
        SemanticsService.announce(
            localizations.formatMonthYear(_selectedDate), textDirection);
      } else {
        SemanticsService.announce(
            localizations.formatYear(_selectedDate), textDirection);
      }
    });
  }

  void _handleYearChanged(DateTime value) {
    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) value = widget.lastDate;
    if (value == _selectedDate) return;

    _vibrate();
    setState(() {
      _mode = DatePickerMode.day;
      _selectedDate = value;
    });
  }

  void _handleDayChanged(DateTime value) {
    _vibrate();
    singleClick = true;
    setState(() {
      _selectedDate = value;
    });
    // pop when date selected
    if (widget.multipleDay) {
      Timer(Duration(milliseconds: 750), () {
        Navigator.pop(context, _selectedDate);
      });
    } else {
      Navigator.pop(context, _selectedDate);
    }
  }

  // void _handleCancel() {
  //   Navigator.pop(context);
  // }

  // void _handleOk() {
  //   Navigator.pop(context, _selectedDate);
  // }

  Widget _buildPicker() {
    assert(_mode != null);
    switch (_mode) {
      case DatePickerMode.day:
        return MonthPicker(
          key: _pickerKey,
          selectedDate: _selectedDate,
          onChanged: _handleDayChanged,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          selectableDayPredicate: widget.selectableDayPredicate,
          initialDate: widget.initialDate,
          multipleDay: widget.multipleDay,
        );
      case DatePickerMode.year:
        return YearPicker(
          key: _pickerKey,
          selectedDate: _selectedDate,
          onChanged: _handleYearChanged,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    final ThemeData theme = ThemeData(
      //dialog datepicker
      dialogBackgroundColor: Purple.barneyPurple,
      //disable color
      disabledColor: Purple.orchid,
      //button color
      buttonColor:Yellow.sunYellow,
      //button arrow color
      cursorColor: Purple.royalPurple,
      //multiDay drag color
      dividerColor:Yellow.mangoYellow.withOpacity(0.3),
      //datepicker text
      textSelectionColor: Colors.white,
      hoverColor: Colors.transparent,
      textTheme: TextTheme(
          //month text style
          headline1: TextStyle(
              color:  Yellow.sunYellow,
              fontSize: 30.0,
              fontFamily: 'TTCommons',
              fontWeight: FontWeight.bold),
          //header day
          headline2: TextStyle(
            color: Yellow.sunYellow,
            fontSize: 14.0,
            fontFamily: 'TTCommons',
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(color: Colors.white),
          caption: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(color: Colors.white)),
      colorScheme: ColorScheme.light(primary: Colors.yellow),
    );
    final Widget picker = IgnorePointer(child: _buildPicker(),ignoring: singleClick,);

//Button ok and cancel

    // final Widget actions = ButtonBar(
    //   children: <Widget>[
    //     FlatButton(
    //       child: Text(localizations.cancelButtonLabel),
    //       onPressed: _handleCancel,
    //     ),
    //     FlatButton(
    //       child: Text(localizations.okButtonLabel),
    //       onPressed: _handleOk,
    //     ),
    //   ],
    // );
    

    final Dialog dialog = Dialog(
      elevation: 0,
      backgroundColor: theme.dialogBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 400,
        height: 500,
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
        // assert(orientation != null);
        Widget header = DatePickerHeader(
          selectedDate: _selectedDate,
          mode: _mode,
          onModeChanged: _handleModeChanged,
          orientation: orientation,
          selectedMonth: _selectedDate,
        );
        switch (orientation) {
          case Orientation.portrait:
            orientation = orientation;
            return Container(
              color: theme.dialogBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      picker,
                      if (_mode == DatePickerMode.day)
                        header
                      else
                        Container(),
                      // Flexible(child: picker),
                    ],
                  )
                  // actions,
                ],
              ),
            );
          case Orientation.landscape:
            orientation = orientation;
            return Container(
              color: theme.dialogBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      picker,
                      if (_mode == DatePickerMode.day)
                      header
                      else
                      Container(),
                      // Flexible(child: picker),
                    ],
                  )
                  // actions,
                ],
              ),
            );
        }
        return null;
      }),
        ),
    );

    return Theme(
      data: theme.copyWith(
        dialogBackgroundColor: Colors.transparent,
      ),
      child: dialog,
    );
  }
}

/// Signature for predicating dates for enabled date selections.
///
/// See [showDatePicker].
typedef SelectableDayPredicate = bool Function(DateTime day);

/// Shows a dialog containing a material design date picker.
///
/// The returned [Future] resolves to the date selected by the user when the
/// user closes the dialog. If the user cancels the dialog, null is returned.
///
/// An optional [selectableDayPredicate] function can be passed in to customize
/// the days to enable for selection. If provided, only the days that
/// [selectableDayPredicate] returned true for will be selectable.
///
/// An optional [initialDatePickerMode] argument can be used to display the
/// date picker initially in the year or month+day picker mode. It defaults
/// to month+day, and must not be null.
///
/// An optional [locale] argument can be used to set the locale for the date
/// picker. It defaults to the ambient locale provided by [Localizations].
///
/// An optional [textDirection] argument can be used to set the text direction
/// (RTL or LTR) for the date picker. It defaults to the ambient text direction
/// provided by [Directionality]. If both [locale] and [textDirection] are not
/// null, [textDirection] overrides the direction chosen for the [locale].
///
/// The [context] and [useRootNavigator] arguments are passed to [showDialog],
/// the documentation for which discusses how it is used.
///
/// The [builder] parameter can be used to wrap the dialog widget
/// to add inherited widgets like [Theme].
///
/// {@tool sample}
/// Show a date picker with the dark theme.
///
/// ```dart
/// Future<DateTime> selectedDate = showDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   firstDate: DateTime(2018),
///   lastDate: DateTime(2030),
///   builder: (BuildContext context, Widget child) {
///     return Theme(
///       data: ThemeData.dark(),
///       child: child,
///     );
///   },
/// );
/// ```
/// {@end-tool}
///
/// The [context], [initialDate], [firstDate], and [lastDate] parameters must
/// not be null.
///
/// See also:
///
///  * [showTimePicker], which shows a dialog that contains a material design
///    time picker.
///  * [DayPicker], which displays the days of a given month and allows
///    choosing a day.
///  * [MonthPicker], which displays a scrollable list of months to allow
///    picking a month.
///  * [YearPicker], which displays a scrollable list of years to allow picking
///    a year.
Future<DateTime> showDatePickerCustom({
  @required BuildContext context,
  @required DateTime initialDate,
  @required DateTime firstDate,
  @required DateTime lastDate,
  SelectableDayPredicate selectableDayPredicate,
  DatePickerMode initialDatePickerMode = DatePickerMode.day,
  Locale locale,
  TextDirection textDirection,
  TransitionBuilder builder,
  bool useRootNavigator = true,
  bool multipleDay,
}) async {
  assert(initialDate != null);
  assert(firstDate != null);
  assert(lastDate != null);
  assert(useRootNavigator != null);
  assert(!initialDate.isBefore(firstDate),
      'initialDate must be on or after firstDate');
  assert(!initialDate.isAfter(lastDate),
      'initialDate must be on or before lastDate');
  assert(
      !firstDate.isAfter(lastDate), 'lastDate must be on or after firstDate');
  // assert(
  //   selectableDayPredicate == null || selectableDayPredicate(initialDate),
  //   'Provided initialDate must satisfy provided selectableDayPredicate'
  // );
  assert(
      initialDatePickerMode != null, 'initialDatePickerMode must not be null');
  assert(context != null);
  assert(debugCheckHasMaterialLocalizations(context));

  // String entity;

  Future<void> getPrefEntity() async {
    // final pref = await SharedPreferences.getInstance();
    // entity = 'px';
  }

  await getPrefEntity();
  Widget child = _DatePickerDialog(
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    selectableDayPredicate: selectableDayPredicate,
    initialDatePickerMode: initialDatePickerMode,
    // entity: entity,
    multipleDay: multipleDay ?? false,
  );

  if (textDirection != null) {
    child = Directionality(
      textDirection: textDirection,
      child: child,
    );
  }

  if (locale != null) {
    child = Localizations.override(
      context: context,
      locale: locale,
      child: child,
    );
  }
  return await _customSlideDialog(
    context: context,
    child: child,
  );

  // return await showDialog<DateTime>(
  //   context: context,
  //   useRootNavigator: useRootNavigator,
  //   builder: (BuildContext context) {
  //     return builder == null ? child : builder(context, child);
  //   },
  // );
}


// showUp pop dialog  
Future<T> _customSlideDialog<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return null;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * -100, 0.0),
          child: Opacity(
            opacity: animation1.value,
            child: child,
          ));
    },
  );
}

// Slide Dialog

class SlideDialog extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;
  final Color pillColor;

  SlideDialog({
    @required this.child,
    @required this.pillColor,
    @required this.backgroundColor,
  });

  @override
  _SlideDialogState createState() => _SlideDialogState();
}

class _SlideDialogState extends State<SlideDialog> {
  var initialPosition = 0.0;
  var currentPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // print(deviceHeight);

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          EdgeInsets.only(top: deviceHeight / 2.5 + currentPosition),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Container(
            width: deviceWidth,
            height: deviceHeight,
            child: Material(
              color: widget.backgroundColor ??
                  Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // PillGesture(
                    //   pillColor: widget.pillColor,
                    //   onVerticalDragStart: _onVerticalDragStart,
                    //   onVerticalDragEnd: _onVerticalDragEnd,
                    //   onVerticalDragUpdate: _onVerticalDragUpdate,
                    // ),
                    widget.child,
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _onVerticalDragStart(DragStartDetails drag) {
  //   setState(() {
  //     _initialPosition = drag.globalPosition.dy;
  //   });
  // }

  // void _onVerticalDragUpdate(DragUpdateDetails drag) {
  //   setState(() {
  //     final temp = _currentPosition;
  //     _currentPosition = drag.globalPosition.dy - _initialPosition;
  //     if (_currentPosition < 0) {
  //       _currentPosition = temp;
  //     }
  //   });
  // }

  // void _onVerticalDragEnd(DragEndDetails drag) {
  //   if (_currentPosition > 100.0) {
  //     Navigator.pop(context);
  //     return;
  //   }
  //   setState(() {
  //     _currentPosition = 0.0;
  //   });
  // }
}
