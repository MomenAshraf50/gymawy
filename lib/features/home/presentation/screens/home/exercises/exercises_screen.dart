import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/add_exercise_details.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_exercise_item.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/widgets/default_action_button.dart';
import '../../../controller/home_cubit.dart';
import 'add_exercise.dart';
import 'exercise_basic_data.dart';
import 'exercise_type.dart';

class ExercisesScreen extends StatelessWidget {
  ExercisesScreen({Key? key, required this.isAddExercise, this.planId})
      : super(key: key);

  bool isAddExercise;
  int? planId;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getExercise();
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: designApp,
              child: Column(
                children: [
                  defaultAppBar(
                    title: AppString.exercises,
                    context: context,
                    actions: [
                      if(isAddExercise == false)
                      defaultActionButton(
                        onPressed: () {
                          navigateTo(
                              context,
                              SearchScreen(
                                exercises: true,
                              ));
                        },
                        icon: Icons.search,
                        backgroundColor: ColorsManager.white,
                        iconColor: ColorsManager.black,
                      ),
                      horizontalSpace(5.w),
                      if (isCoachLogin == true)
                        defaultActionButton(
                            icon: Icons.add,
                            onPressed: () {
                              navigateTo(context, AddExerciseScreen());
                            },
                            backgroundColor: Colors.green)
                    ],
                  ),
                  if (homeCubit.exerciseResult != null)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => InkWell(
                          onTap: isAddExercise
                              ? () {
                                  navigateTo(
                                      context,
                                      AddExerciseDetails(
                                        exerciseId: homeCubit.exerciseResult![index].exerciseId,
                                        planId: planId!,
                                        update: false,
                                      ));
                                }
                              : () {
                                  navigateTo(
                                      context,
                                      ExerciseBasicData(
                                        exerciseEntity:
                                            homeCubit.exerciseResult![index],
                                      ));
                                  debugPrintFullText('$index');
                                },
                          child: buildExercisesItems(
                            exerciseImage:
                                homeCubit.exerciseResult![index].exercisePic,
                            exerciseName:
                                homeCubit.exerciseResult![index].exerciseName,
                            exerciseCategory: homeCubit
                                .exerciseResult![index].exerciseCategory,
                          ),
                        ),
                        itemCount: homeCubit.exerciseResult!.length,
                        physics: const BouncingScrollPhysics(),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
