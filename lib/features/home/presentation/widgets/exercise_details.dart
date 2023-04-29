import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

Widget exerciseDetails({
  required String exerciseImage,
  required String exerciseName,
  required String exerciseCategory,
  int? sets,
  int? rest,
  int? reps,
  bool? isExercisePlanDetails,
}){
  return Row(
    children: [
      Container(
        height: 10.h,
        width: 20.w,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.rSp),
        ),
        child: Image.network(
          exerciseImage,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        )
        // SvgPicture.asset(
        //   Assets.images.svg.exercise_photo,
        //   alignment: Alignment.topCenter,
        //   fit: BoxFit.cover,
        // ),
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
              title: exerciseName,
              style: Style.small,
              fontWeight: FontWeight.w600,
              fontSize: 14.rSp,
              maxLines: 1,
              letterSpacing: 0.1,
            ),
            verticalSpace(0.5.h),
                myText(
                  title: exerciseCategory,
                  letterSpacing: 0.1,
                  style: Style.extraSmall,
                ),
            verticalSpace(0.5.h),
            if(isExercisePlanDetails == true)
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
                  children:  [
                    myText(
                      title: '$sets',
                      style: Style.extraSmall,
                    ),
                    myText(
                      title: '$reps',
                      style: Style.extraSmall,
                    ),
                    myText(
                      title: '$rest Sec',
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
      Icon(
        Icons.arrow_forward_ios_outlined,
        color: const Color.fromARGB(255, 161, 175, 176),
        size: 15.rSp,
      )
    ],
  );
}