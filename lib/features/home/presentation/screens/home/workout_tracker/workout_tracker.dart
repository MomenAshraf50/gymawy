import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/screens/home/workout_tracker/exercise_example.dart';
import 'package:gymawy/features/home/presentation/widgets/main_data.dart';

import '../../../../../../core/util/resources/appString.dart';

class WorkoutTrackerScreen extends StatelessWidget {
  const WorkoutTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              ColorsManager.orangePrimary,
              ColorsManager.mainColor
            ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: designApp,
          child: Column(
            children: [
              defaultAppBar(
                  title: AppString.workoutTracker,
                  color: Colors.transparent,
                  fontColor: ColorsManager.white,
                  context: context,
                  actions: [
                    InkWell(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                        child: SvgPicture.asset(
                            Assets.images.svg.two_points
                        )
                    )
                  ]
              ),

              verticalSpace(15.h),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.50,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 10.rSp,
                        ),
                        child: LineChart(
                          mainData(),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.rSp)
                    ),
                    height: 10.h,
                    width: 40.w,
                    child: Padding(
                      padding: EdgeInsets.all(10.rSp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              DefaultText(
                                  title: AppString.dayOfToday,
                                  style: Style.extraSmall,
                                  fontSize: 12.rSp,
                                  color: ColorsManager.darkGrey.withOpacity(0.8),
                              ),
                              const Spacer(),
                              DefaultText(
                                title: AppString.percent,
                                style: Style.extraSmall,
                                fontSize: 10.rSp,
                                color: ColorsManager.green,
                              ),
                               Icon(
                                  Icons.arrow_upward,
                                  color: ColorsManager.green,
                                  size: 14.rSp,
                              ),
                            ],
                          ),
                          verticalSpace(1.h),
                          DefaultText(
                            title: AppString.statuesBody,
                            style: Style.extraSmall,
                            fontSize: 12.rSp,
                            color: ColorsManager.darkGrey,
                          ),
                          verticalSpace(0.5.h),
                          Container(
                            color: ColorsManager.mainColor,
                            height: 0.6.h,
                            width: 20.w,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              verticalSpace(5.h),
              Center(
                child: Container(
                  color: ColorsManager.darkGrey.withOpacity(0.3),
                  height: 0.6.h,
                  width: 30.w,
                ),
              ),
              verticalSpace(5.h),
              Container(
                //margin: EdgeInsetsDirectional.all(10.rSp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.rSp),
                  color: ColorsManager.white.withOpacity(0.15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.rSp),
                  child: Row(
                    children: [
                      DefaultText(
                          title: AppString.dailyWorkoutSchedule,
                          style: Style.small,
                           color: ColorsManager.white,
                           fontSize: 14.rSp,
                           fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          navigateTo(context, const ExerciseExampleScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.rSp),
                            color: ColorsManager.white.withOpacity(0.3),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 1.h
                            ),
                            child: DefaultText(
                              title: AppString.check,
                              style: Style.small,
                              color: ColorsManager.white,
                              fontSize: 14.rSp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
