import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';

class myText extends StatelessWidget {
  const myText({Key? key,
    required this.title,
    required this.style,
    this.align,
    this.color,
    this.letterSpacing = 1.0,
    this.fontFamily = 'english',
    this.fontWeight,

  }) : super(key: key);
  final String title;
  final Style style;
  final TextAlign? align;
  final Color? color;
  final String? fontFamily;
  final double? letterSpacing;
  final FontWeight? fontWeight;


  @override
  Widget build(BuildContext context) {
    return Text(title,
      textAlign: align ?? TextAlign.start,
      style: getStyle(context).copyWith(
        color: color ?? getStyle(context).color,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? Theme.of(context).textTheme.displayMedium!.fontWeight,
      ),);
  }

  TextStyle getStyle(BuildContext context) {
    switch (style) {
      case Style.extraSmall:
        return Theme
            .of(context)
            .textTheme
            .bodySmall!;
      case Style.small:
        return Theme
            .of(context)
            .textTheme
            .displaySmall!;
      case Style.medium:
        return Theme
            .of(context)
            .textTheme
            .displayMedium!;
      case Style.large:
        return Theme
            .of(context)
            .textTheme
            .displayLarge!;
      case Style.headMedium:
        return Theme
            .of(context)
            .textTheme
            .headlineMedium!;
      case Style.headLarge:
        return Theme
            .of(context)
            .textTheme
            .headlineLarge!;
    }
  }
}
