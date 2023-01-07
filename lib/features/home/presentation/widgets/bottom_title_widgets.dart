import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/util/resources/colors_manager.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: ColorsManager.whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Sun', style: style);
      break;
    case 3:
      text = const Text('Mon', style: style);
      break;
    case 5:
      text = const Text('Tue', style: style);
      break;
    case 7:
      text = const Text('Wed', style: style);
      break;
    case 9:
      text = const Text('Thu', style: style);
      break;
    case 11:
      text = const Text('Fri', style: style);
      break;
    case 13:
      text = const Text('Sat', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}