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
              child: Column(
                children: [
                  defaultAppBar(
                    title: AppString.planType,
                    context: context,
                    actions: [
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
                      itemBuilder: (context, index) => InkWell(
                        child: buildPlansTypeItems(),
                        onTap: () {
                          navigateTo(context, const ExerciseType());
                          debugPrintFullText('$index');
                        },
                      ),
                      itemCount: 10,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
