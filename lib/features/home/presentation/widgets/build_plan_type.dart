import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/myText.dart';

Widget buildPlansTypeItems() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Card(
      color: const Color.fromARGB(255, 247, 248, 248),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
        child: Column(
          children: [
            Row(
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
                      const myText(
                        title: AppString.frontPullUps,
                        style: Style.small,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      verticalSpace(2.h),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: const [
                              myText(
                                title: AppString.sets,
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
                              ),
                              myText(
                                title: AppString.reps,
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
                              ),
                              myText(
                                title: AppString.rest,
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
                              ),
                            ],
                          ),
                          horizontalSpace(4.w),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: const [
                              myText(
                                title: '3',
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
                              ),
                              myText(
                                title: '12-10-8',
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
                              ),
                              myText(
                                title: '30 sec',
                                style: Style.extraSmall,
                                fontFamily: 'poppins',
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: const Color.fromARGB(255, 161, 175, 176),
                      size: 15.rSp,
                    )),
              ],
            ),
            verticalSpace(2.h),
          ],
        ),
      ),
    ),
  );
}