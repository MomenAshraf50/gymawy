import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../resources/colors_manager.dart';


class ProgressDialog extends Dialog {
  final String progressAmount;
  final double liquidValue;


  const ProgressDialog({
    required this.progressAmount,
    required this.liquidValue,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        width: 13.w,
        height: 6.h,
        child: LiquidCircularProgressIndicator(
          value: liquidValue,
          valueColor:
          const AlwaysStoppedAnimation(ColorsManager.mainColor),
          backgroundColor: Colors.white,
          borderColor: ColorsManager.mainColor,
          borderWidth: 5.0,
          direction: Axis.vertical,
          center: myText(
            title: progressAmount,
            style: Style.extraSmall,
            fontSize: 12.rSp,
          ),
        ),
      )
    );
  }
}
