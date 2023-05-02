import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/goal_data_static.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:lottie/lottie.dart';

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
                ? const BoxShadow(
              color: ColorsManager.mainColor,
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
              child: Lottie.asset(model.img),
            ),
            Expanded(
              child: Column(
                children: [
                  DefaultText(
                    title: model.title,
                    style: Style.medium,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  verticalSpace(1.h),
                  DefaultText(
                      title: model.body,
                      style: Style.extraSmall,
                      maxLines: 4,
                      align: TextAlign.center,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );