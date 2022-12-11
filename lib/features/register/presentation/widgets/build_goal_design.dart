import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/goal_data_static.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

Widget buildDesign({
  required GoalDataStatic model,
  required int index,
  required BuildContext context,
  required int selected
}) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            selected == index
                ? BoxShadow(
              color: Theme.of(context).primaryColor,
              spreadRadius: 0,
              blurRadius: 25,
            ) : const BoxShadow(),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              ColorsManager.mainColor,
              ColorsManager.secColor,
            ],
          )),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: svgImage(path: model.img),
            ),
            verticalSpace(10.h),
            Expanded(
              flex: 1,
              child: myText(
                title: model.title,
                style: Style.large,
                color: Colors.white,
              ),
            ),
            verticalSpace(10.h),
            Expanded(
              flex: 1,
              child: myText(
                  title: model.body,
                  style: Style.small,
                  align: TextAlign.center,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );