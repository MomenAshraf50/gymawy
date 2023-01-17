import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'myText.dart';

class ProgressDialog extends Dialog {
  final double height;
  final double value;
  final String message;

  const ProgressDialog({
    this.height = 160.0,
    this.value = 0.0,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              myText(
                  title: message, align: TextAlign.center, style: Style.medium),
              verticalSpace(5.h),
              LinearProgressIndicator(
                color: ColorsManager.mainColor,
                value: value, backgroundColor: ColorsManager.lightGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
