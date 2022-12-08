import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Formatting on DateTime {
  String get d => DateFormat(DateFormat.DAY).format(this);

  String get yMd => DateFormat('yyyy-MM-dd').format(this);

  String get dayOfWeek => DateFormat('E').format(this);

  String get dateAndTime => DateFormat('MM/dd/yyyy hh:mm:ss').format(this);
}

extension Precision on num {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

extension DateTimeParsing on DateTime {
  /// parse [time] in "hh:mm" format.
  static DateTime? tryParseTimeHM(String time) {
    try {
      final hm = time.split(':');
      int h = int.parse(hm[0]);
      int m = int.parse(hm[1]);
      return (DateTime(2000, 1, 1, h, m));
    } catch (e) {
      return null;
    }
  }
}

extension Comaparisons on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isNotSameDay(DateTime other) {
    return !isSameDay(other);
  }
}

extension SizeExtension on num {
  static final _screenSizes = ScreenSizes();

  ///* Get the `width` by percentage of screen width `10.w`
  double get w => _screenSizes.getWidth(this);

  ///* Get the `height` by percentage of screen height `10.h`
  double get h => _screenSizes.getHeight(this);

  ///* Get the `relative width` by pixels of screen width
  double get rw => _screenSizes.getRelativeWidth(this);

  ///* Get the `relative height` by pixels of screen height
  double get rh => _screenSizes.getRelativeHeight(this);

  ///* Get the responsive `font-size` for based on scale and screen size
  double get rSp => _screenSizes.getRelativeFontSize(this);
}

class ScreenSizes {
  static final ScreenSizes _screenSizes = ScreenSizes._();
  ScreenSizes._();
  factory ScreenSizes() => _screenSizes;

  static late double screenWidth;
  static late double screenHeight;

  final Size _designSize = const Size(375, 812);
  Size get designSize => _designSize;

  double get scaleWidth => screenWidth / designSize.width;
  double get scaleHeight => screenHeight / designSize.height;

  double getRelativeWidth(num size) => size * scaleWidth;
  double getRelativeHeight(num size) => size * scaleHeight;
  double getRelativeFontSize(num size) => size * min(scaleWidth, scaleHeight);

  double getWidth(num size) => size * screenWidth / 100;
  double getHeight(num size) => size * screenHeight / 100;

  static bool get isTablet => 100.w > 600;
}
