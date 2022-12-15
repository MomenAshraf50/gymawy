import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

Widget exerciseDetails({required VoidCallback onPressed}){
  return Row(
    children: [
      Container(
        height: 10.h,
        width: 20.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.rSp),
        ),
        child: SvgPicture.asset(
          Assets.images.svg.exercise_photo,
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 2.h
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(
              title: AppString.frontPullUps,
              style: Style.small,
              fontWeight: FontWeight.w600,
              fontSize: 16.rSp,
              maxLines: 1,
              letterSpacing: 0.1,
            ),
            verticalSpace(1.h),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    myText(
                      letterSpacing: 0.1,
                      title: AppString.sets,
                      style: Style.extraSmall,
                    ),
                    myText(
                      letterSpacing: 0.1,
                      title: AppString.reps,
                      style: Style.extraSmall,
                    ),
                    myText(
                      letterSpacing: 0.1,
                      title: AppString.rest,
                      style: Style.extraSmall,
                    ),
                  ],
                ),
                horizontalSpace(2.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    myText(
                      title: '3',
                      style: Style.extraSmall,
                    ),
                    myText(
                      title: '12-10-8',
                      style: Style.extraSmall,
                    ),
                    myText(
                      title: '30 sec',
                      style: Style.extraSmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const Spacer(),
      IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
            color: const Color.fromARGB(255, 161, 175, 176),
            size: 15.rSp,
          )),
    ],
  );
}