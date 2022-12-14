import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/exercise_type.dart';

import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/myText.dart';

Widget buildExercisesItems() => BlocBuilder<HomeCubit, HomeStates>(
  builder: (context, state) {

    HomeCubit homeCubit = HomeCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Card(
        color: const Color.fromARGB(255, 247, 248, 248),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 0, 5.w, 0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            horizontalSpace(2.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                      onPressed: () {
                        navigateTo(context, const ExerciseType());
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: const Color.fromARGB(255, 161, 175, 176),
                        size: 15.rSp,
                      )),
                ],
              ),
              Container(
                width: double.infinity,
                height: 0.3.h,
                color: Colors.grey.shade300,
              ),
              verticalSpace(0.5.h),
              InkWell(
                onTap: () {
                  homeCubit.changeCompleted();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    homeCubit.isCompleted
                        ? Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(Assets.images.svg.circle),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.grey.shade300,
                          ),
                        )
                      ],
                    )
                        : Padding(
                      padding: EdgeInsets.all(8.0.rSp),
                      child: SvgPicture.asset(
                          Assets.images.svg.checked_icon),
                    ),
                    horizontalSpace(2.w),
                    myText(
                      title: homeCubit.isCompleted
                          ? AppString.markAsCompleted
                          : AppString.completed,
                      style: Style.small,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'poppins',
                      color: homeCubit.isCompleted
                          ? const Color.fromARGB(255, 161, 175, 176)
                          : Colors.green,
                    ),
                  ],
                ),
              ),
              verticalSpace(0.5.h),
            ],
          ),
        ),
      ),
    );
  },
);