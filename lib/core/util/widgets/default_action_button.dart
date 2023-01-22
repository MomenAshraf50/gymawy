import 'package:flutter/material.dart';

Widget defaultActionButton(
{
  required VoidCallback onPressed,
  required IconData icon,
  required Color backgroundColor,
  double? radius,
  Color? iconColor = Colors.white,
}
    ){
  return  CircleAvatar(
    backgroundColor: backgroundColor,
    radius:radius ,
    child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        )),
  );
}