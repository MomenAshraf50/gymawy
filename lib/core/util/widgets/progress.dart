import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'myText.dart';

class ProgressDialog extends Dialog {
  final double height;
  final double width;
  final String message;

  const ProgressDialog({
    this.height = 160.0,
    this.width = 80.0,
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
              Container(
                height: 1.h,
                width: width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors:
                      [
                        Color.fromARGB(255, 255, 185, 145)  ,
                        ColorsManager.mainColor
                      ]
                  ),
                  borderRadius: BorderRadius.circular(10.rSp),
                ),
              ),
              // myText(
              //     title: message, align: TextAlign.center, style: Style.medium),
              // const Spacer(),
              // Row(
              //   children: [
              //     Expanded(
              //       child: myButton(
              //         onPressed: popButtonVoidCallback,
              //         text: popButtonText,
              //         fontSize: 20.rSp,
              //       ),
              //     ),
              //     horizontalSpace(2.h),
              //     Expanded(
              //       child: myButton(
              //         onPressed: pushButtonVoidCallback,
              //         text: pushButtonText,
              //         fontSize: 20.rSp,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
