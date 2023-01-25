import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/exercises_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_type.dart';
import 'package:gymawy/features/home/presentation/widgets/exercise_details.dart';
import '../../../../../../core/util/widgets/default dialog.dart';
import '../../../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../../controller/home_cubit.dart';
import '../exercises/exercise_type.dart';
import 'add_plan.dart';

class PlanDetails extends StatelessWidget {
  PlanDetails({Key? key,
    this.exercisePlanId ,
    this.ownerUserId,
    this.exercisePlanVisibility,
    this.exercisePlanName
  }) : super(key: key);

  int? exercisePlanId;
  int? ownerUserId;
  String? exercisePlanName;
  String? exercisePlanVisibility;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getExercisePlanDetails();

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit,HomeStates>(
          listener: (context, state) {
            if(state is DeleteExercisePlanSuccessState)
            {
              Navigator.pop(context);
              Navigator.pop(context);
              homeCubit.getExercisePlan();
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: 'Exercise Plan Deleted Successfully');
            }
          },
          builder: (context, state) {
            return Padding(
              padding: designApp,
              child: homeCubit.exerciseDetailsResult != null ?
              Column(
                children: [
                  defaultAppBar(
                    title: AppString.planType,
                    context: context,
                    actions: [
                      if(userId == ownerUserId)
                      defaultActionButton(
                          onPressed: ()
                          {
                            navigateTo(context, AddPlan(
                              exercisePlanId: exercisePlanId,
                              exercisePlanName: exercisePlanName,
                              exercisePlanVisibility: exercisePlanVisibility,
                            ));
                          },
                          icon: Icons.edit,
                          backgroundColor: ColorsManager.white,
                          iconColor: ColorsManager.black,
                      ),
                      if(userId == ownerUserId)
                        defaultActionButton(
                        onPressed: ()
                        {
                          navigateTo(context, ExercisesScreen(isAddExercise: true,planId: exercisePlanId,));
                        },
                        icon: Icons.add,
                        backgroundColor: Colors.green,
                        iconColor: ColorsManager.white,
                      ),

                    ],
                  ),
                  verticalSpace(2.h),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return homeCubit.exerciseDetailsResult![index].planId == exercisePlanId?
                          InkWell(
                          onTap: ()
                          {
                            navigateTo(context, ExerciseType(
                              video: homeCubit.exerciseDetailsResult![index].exerciseModel.exerciseVid,
                              pic: homeCubit.exerciseDetailsResult![index].exerciseModel.exercisePic,
                              cat: homeCubit.exerciseDetailsResult![index].exerciseModel.exerciseCategory,
                              userName: homeCubit.exerciseDetailsResult![index].exerciseModel.exerciseMaker,
                              sets: homeCubit.exerciseDetailsResult![index].sets,
                              rest: homeCubit.exerciseDetailsResult![index].rest.toInt(),
                              reps: homeCubit.exerciseDetailsResult![index].reps,
                            ));
                            debugPrintFullText('$index');
                          },
                          child: exerciseDetails(
                            onPressed: () {

                            },
                            exerciseImage: homeCubit.exerciseDetailsResult![index].exerciseModel.exercisePic,
                            exerciseName: homeCubit.exerciseDetailsResult![index].exerciseModel.exerciseName,
                            exerciseCategory: homeCubit.exerciseDetailsResult![index].exerciseModel.exerciseCategory,
                            reps: homeCubit.exerciseDetailsResult![index].reps,
                            rest: homeCubit.exerciseDetailsResult![index].rest.toInt(),
                            sets: homeCubit.exerciseDetailsResult![index].sets,
                            isExercisePlanDetails: true,
                          ),
                        ) :
                          Container();
                      },
                      itemCount: homeCubit.exerciseDetailsResult!.length,
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                  verticalSpace(4.h),
                  if(userId == ownerUserId)
                  myButton(
                    text: AppString.delete,
                    textOnly: true,
                    color: const Color.fromARGB(255, 255, 0, 0),
                    width: double.infinity,
                    radius: 40.h,
                    onPressed: ()
                    {
                      showDialog(context: context, builder: (context){
                        return DefaultDialog(
                          message: 'Are you sure to delete this plan',
                          pushButtonText: 'yes',
                          buttonColor: ColorsManager.error,
                          pushButtonVoidCallback: (){
                            homeCubit.deleteExercisePlan(DeleteExercisePlanParams(exercisePlanId!));
                          },
                        );
                      });
                    },
                  ),
                ],
              ) :
              Container(),
            );
          },
        ),
      ),
    );
  }
}
