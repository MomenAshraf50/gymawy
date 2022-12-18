import 'package:flutter/material.dart';

Widget defaultActionButton(
{
  required VoidCallback onPressed,
  required IconData icon,
  required Color backgroundColor,
  double? radius
}
    ){
  return  CircleAvatar(
    backgroundColor: backgroundColor,
    radius:radius ,
    child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        )),
  );
}