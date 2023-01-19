import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

import 'myButton.dart';

class DefaultDialog extends Dialog {
  final String message;
  final String pushButtonText;
  final VoidCallback pushButtonVoidCallback;
  final double height;
  final Color buttonColor;

  const DefaultDialog({
    required this.message,
    required this.pushButtonText,
    required this.pushButtonVoidCallback,
    this.height = 160.0,
    this.buttonColor= ColorsManager.mainColor,
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
              const Spacer(),
              Expanded(
                child: myButton(
                  color: buttonColor,
                  onPressed: pushButtonVoidCallback,
                  text: pushButtonText,
                  fontSize: 20.rSp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
