import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/widgets/exercise_details.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/default_text.dart';

Widget buildExercisesItems({
  required String exerciseImage,
  required String exerciseName,
  required String exerciseCategory,
}) => BlocBuilder<HomeCubit, HomeStates>(
  builder: (context, state) {

    HomeCubit homeCubit = HomeCubit.get(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Card(
        color: const Color.fromARGB(255, 247, 248, 248),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 1.h),
          child: Column(
            children: [
              exerciseDetails(
                exerciseCategory: exerciseCategory,
                exerciseImage: exerciseImage,
                exerciseName: exerciseName,
              ),
              if(isCoachLogin == false)
              Container(
                width: double.infinity,
                height: 0.3.h,
                color: Colors.grey.shade300,
              ),
              if(isCoachLogin == false)
                verticalSpace(0.5.h),
              if(isCoachLogin == false)
                InkWell(
                onTap: () {
                  //homeCubit.changeCompleted();
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
                    DefaultText(
                      title: homeCubit.isCompleted
                          ? AppString.markAsCompleted
                          : AppString.completed,
                      style: Style.small,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.rSp,
                      maxLines: 1,
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