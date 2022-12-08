import 'package:flutter/material.dart';

class DefaultIconButton extends StatelessWidget {
  DefaultIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  Widget? icon;
  Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        iconSize: 33,
        icon: icon!,
    );
  }
}
