import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';


Widget buildCard({required String title, required String image,required BuildContext context}) {
  return SizedBox(
    width: 5.w,
    height: 25.h,
    child: Card(
      elevation: 7.0,
      shadowColor: ColorsManager.mainColor,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          svgImage(path: image),
          DefaultText(
            title: title,
            style: Style.large,
          ),
        ],
      ),
    ),
  );
}

