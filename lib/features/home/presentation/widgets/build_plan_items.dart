import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
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
                Text(
                  AppString.planType,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400),
                ),
                verticalSpace(2.h),
                Row(
                  children: [
                    Text(
                      AppString.visibility,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w300),
                    ),
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
