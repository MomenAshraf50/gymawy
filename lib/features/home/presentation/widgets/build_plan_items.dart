import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import '../../../../core/util/resources/appString.dart';

Widget buildPlansItems(context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.h),
    child: Card(
      color: const Color.fromARGB(255, 247, 248, 248),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(1.h),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const myText(title: AppString.planType,
                    style: Style.small,
                  fontWeight: FontWeight.w600,
                ),
                verticalSpace(1.h),
                Row(
                  children: [
                    const myText(title: AppString.visibility, style: Style.extraSmall),
                    horizontalSpace(2.w),
                    Icon(
                      Icons.visibility_off_outlined,
                      color: Colors.red,
                      size: 15.rSp,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: const Color.fromARGB(255, 210, 210, 210),
              size: 20.rSp,
            ),
          ],
        ),
      ),
    ),
  );
  }
