import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/widgets/build_exercise_item.dart';
import '../../../../../../core/util/widgets/default_action_button.dart';
import '../../../controller/home_cubit.dart';
import 'add_exercise.dart';
import 'exercise_basic_data.dart';
import 'exercise_type.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getExercise();
    return BlocBuilder<HomeCubit,HomeStates>(
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
                      if(isCoachLogin == true)
                        defaultActionButton(
                            icon: Icons.add,
                            onPressed: (){
                              navigateTo(context, AddExerciseScreen());
                            },
                            backgroundColor: Colors.green
                        )
                    ],
                  ),
                  if(homeCubit.exerciseResult != null)
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        child: buildExercisesItems(
                          exerciseImage: homeCubit.exerciseResult![index].exercisePic,
                          exerciseName: homeCubit.exerciseResult![index].exerciseName,
                          exerciseCategory: homeCubit.exerciseResult![index].exerciseCategory,
                        ),
                        onTap: () {
                          navigateTo(context, ExerciseBasicData(
                            exerciseEntity: homeCubit.exerciseResult![index],
                          ));
                          debugPrintFullText('$index');
                        },
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
