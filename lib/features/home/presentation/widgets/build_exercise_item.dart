import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/exercise_type.dart';
import 'package:gymawy/features/home/presentation/widgets/exercise_details.dart';
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
              exerciseDetails(onPressed: () {
                navigateTo(context, const ExerciseType());
              }),
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
                      fontSize: 16.rSp,
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