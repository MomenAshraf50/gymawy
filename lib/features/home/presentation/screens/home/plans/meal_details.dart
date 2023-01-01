import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

class MealsDetailsScreen extends StatelessWidget {
  const MealsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  end: AlignmentDirectional.bottomEnd,
                  begin: AlignmentDirectional.topStart,
                  colors: [
                    Color.fromARGB(255, 255, 192, 147),
                    ColorsManager.mainColor,
                    ColorsManager.mainColor,
                  ],
                )),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.rSp, 70.rSp, 20.rSp, 20.rSp),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultBackButton(function: () {
                              Navigator.pop(context);
                            }),
                            SvgPicture.asset(Assets.images.svg.meal),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.rSp),
                            topRight: Radius.circular(40.rSp),
                          ),
                        ),
                        child: Padding(
                          padding: designApp,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(5.h),
                              const myText(
                                title: 'Blueberry Pancake',
                                style: Style.small,
                                fontWeight: FontWeight.w600,
                              ),
                              verticalSpace(0.5.h),
                              const myText(
                                title: 'by Coach kalosha',
                                style: Style.extraSmall,
                              ),
                              verticalSpace(2.h),
                              const myText(
                                title: 'Nutrition',
                                style: Style.small,
                                fontWeight: FontWeight.w600,
                              ),
                              verticalSpace(3.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SvgPicture.asset(Assets.images.svg.calories),
                                    horizontalSpace(0.5.w),
                                    myText(
                                      title: '180k Cal',
                                      style: Style.extraSmall,
                                      fontSize: 10.rSp,
                                    ),
                                    horizontalSpace(5.w),
                                    SvgPicture.asset(Assets.images.svg.fat),
                                    horizontalSpace(0.5.w),
                                    myText(
                                      title: '30g fats',
                                      style: Style.extraSmall,
                                      fontSize: 10.rSp,
                                    ),
                                    horizontalSpace(5.w),
                                    SvgPicture.asset(Assets.images.svg.protein),
                                    horizontalSpace(0.5.w),
                                    myText(
                                      title: '20g proteins',
                                      style: Style.extraSmall,
                                      fontSize: 10.rSp,
                                    ),
                                    horizontalSpace(5.w),
                                    SvgPicture.asset(Assets.images.svg.rice),
                                    horizontalSpace(0.5.w),
                                    myText(
                                      title: '50g carb',
                                      style: Style.extraSmall,
                                      fontSize: 10.rSp,
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(3.h),
                              const myText(
                                title: AppString.descriptions,
                                style: Style.small,
                                fontWeight: FontWeight.w600,
                              ),
                              verticalSpace(2.h),
                              const myText(
                                title: 'Pancakes are some people\'s favorite breakfast, who doesn\'t like pancakes? Especially with the real honey splash on top of the pancakes, of course ever',
                                style: Style.extraSmall,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
