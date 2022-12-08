import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';

class myButton extends StatelessWidget {
  myButton({
    Key? key,
    this.width = double.infinity,
    this.height = 0.0,
    this.radius = 20.0,
    this.elevation = 0.0,
    required this.text,
    this.color,
    this.iconWidget,
    this.textOnly = true,
    this.onPressed,
  }) : super(key: key);

  final Function()? onPressed;
  final String text;
  final double width;
  final double height;
  final double radius;
  final double elevation;
  Color? color;
  Widget? iconWidget;
  final bool textOnly;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialButton(
        color: color ?? Theme.of(context).backgroundColor,
        minWidth: width,
        height: height == 0 ? size.height * 0.05 : height,
        elevation: elevation,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        child: textOnly
            ? Text(text,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                    ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconWidget!,
                  horizontalSpace(10.w),
                  Text(text,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: Colors.white,
                              )),
                ],
              ));
  }
}
