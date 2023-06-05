import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
// import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

Widget buildDayProgressItems(){
  return Padding(
    padding:  EdgeInsets.all(12.rSp),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 1.h,
          width: 6.w,
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
        const DefaultText(title: 'Sat', style: Style.extraSmall)
      ],
    ),
  );

}