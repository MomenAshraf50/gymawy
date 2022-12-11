import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';


Widget buildCard({required String title, required String image,required BuildContext context}) {
  return SizedBox(
    width: 5.w,
    height: 25.h,
    child: Card(
      elevation: 7.0,
      shadowColor: Theme.of(context).primaryColor,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          svgImage(path: image),
          myText(
            title: title,
            style: Style.large,
          ),
        ],
      ),
    ),
  );
}

