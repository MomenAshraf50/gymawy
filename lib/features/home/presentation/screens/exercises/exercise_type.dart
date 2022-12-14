import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/resources/trainig_image.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myText.dart';

class ExerciseType extends StatelessWidget {
  const ExerciseType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selected = 0;
    List<TrainingImage> listTrainingImages = [
      TrainingImage(
        img: Assets.images.svg.client,
      ),
      TrainingImage(
        img: Assets.images.svg.coach,
      ),
    ];
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DefaultBackButton(function: () {
                      Navigator.pop(context);
                    }),
                    const Expanded(
                        child: Center(
                            child: myText(
                              title: AppString.benchPress,
                              style: Style.large,
                              fontFamily: 'poppins',
                            ))),
                  ],
                ),
                verticalSpace(2.h),
                SizedBox(
                  height: 30.h,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padEnds: false,
                    controller: PageController(
                      initialPage: selected,
                      viewportFraction: 0.7,
                      keepPage: true,
                    ),
                    allowImplicitScrolling: true,
                    pageSnapping: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(9.rSp),
                        decoration: BoxDecoration(
                          boxShadow: [
                            // selected == index ?
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              spreadRadius: 0,
                              blurRadius: 8,
                            )
                            // : const BoxShadow(),
                          ],
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: Colors.orange),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              ColorsManager.whiteColor,
                              ColorsManager.whiteColor,
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.rSp),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                listTrainingImages[index].img,
                                height: 25.h,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: listTrainingImages.length,
                  ),
                ),
                verticalSpace(5.h),
                const myText(
                  title: AppString.equipment,
                  style: Style.medium,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'poppins',
                ),
                verticalSpace(2.h),
                const myText(
                  title: AppString.barbell,
                  style: Style.small,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'poppins',
                ),
                verticalSpace(5.h),
                const myText(
                  title: AppString.target,
                  style: Style.medium,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'poppins',
                ),
                verticalSpace(2.h),
                const myText(
                  title: AppString.chest,
                  style: Style.small,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'poppins',
                ),
                verticalSpace(5.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const myText(
                            title: AppString.sets,
                            style: Style.medium,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          verticalSpace(2.h),
                          const myText(
                            title: AppString.reps,
                            style: Style.medium,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          verticalSpace(2.h),
                          const myText(
                            title: AppString.rest,
                            style: Style.medium,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                    horizontalSpace(5.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const myText(
                            title: '3',
                            style: Style.extraSmall,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          verticalSpace(2.h),
                          const myText(
                            title: '12-10-8',
                            style: Style.extraSmall,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                          ),
                          verticalSpace(2.h),
                          const myText(
                            title: '30 sec',
                            style: Style.extraSmall,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                verticalSpace(5.h),
                myButton(
                    elevation: 0.0,
                    textOnly: true,
                    text: AppString.complete,
                    onPressed: () {
                      // navigateTo(context, PinPage());
                    }),
                verticalSpace(10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

