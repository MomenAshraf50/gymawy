import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/util/resources/colors_manager.dart';

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: ColorsManager.whiteColor,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
  String text;
  switch (value.toInt()) {
    case 1:
      text = '10%';
      break;
    case 2:
      text = '20%';
      break;
    case 3:
      text = '40%';
      break;
    case 4:
      text = '60%';
      break;
    case 5:
      text = '80%';
      break;
    case 6:
      text = '100%';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}