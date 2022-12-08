import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'myText.dart';

class myListTitle extends StatelessWidget {
  const myListTitle({Key? key,
  required this.title,
  this.svgImg,
  this.icon,
  this.onClick,
  this.onLongClick,
  this.styleText,

  }) : super(key: key);
  final String title;
  final Style? styleText;
  final String? svgImg;
  final IconData? icon;
  final VoidCallback? onClick;
  final VoidCallback? onLongClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.08.rSp,
      decoration: BoxDecoration(
        color: ColorsManager.textFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onClick,
        onLongPress: onLongClick,
        leading: svgImg !=null ?
        svgImage(path: svgImg! ,
          color: ColorsManager.iconColor,):
        Icon(icon),
        title: myText(
          title: title,
          style: styleText ?? Style.small,
        ),
      ),
    );
  }
}
