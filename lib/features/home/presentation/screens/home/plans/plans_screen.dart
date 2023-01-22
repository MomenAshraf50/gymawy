import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/meal_schedule.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_details.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';
import 'package:gymawy/features/home/presentation/widgets/filter_dialog.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import 'add_plan.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getExercisePlan();
    return SafeArea(
      child:BlocBuilder<HomeCubit,HomeStates>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: designApp,
              child: Column(
                children: [
                  defaultAppBar(
                      title: AppString.plans, context: context, actions: [
                    defaultActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocBuilder<HomeCubit, HomeStates>(
                                builder: (context, state) {
                                  return FilterDialog(
                                    firstFilterTitle: AppString.exercises,
                                    secondFilterTitle: AppString.diet,
                                    onTapFirstChoice: (){
                                      homeCubit.changeToFirstChoiceRadioButton();
                                      navigateTo(context,  AddPlan());
                                    },
                                    onTapSecondChoice: (){
                                      homeCubit.changeToSecondChoiceRadioButton();
                                      navigateTo(context, const MealScheduleScreen());
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.green,
                        icon: Icons.add)
                  ]),
                  if(homeCubit.exercisePlanResult != null)
                  BlocBuilder<HomeCubit,HomeStates>(
                    builder: (context, state) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) =>
                              InkWell(
                                child: buildPlansItems(
                                  context,
                                  planTitle: homeCubit.exercisePlanResult![index].exercisePlanName,
                                  visibilityIcon: homeCubit.exercisePlanResult![index].exercisePlanVisibility == 'public' ?
                                  Icons.visibility_outlined : Icons.visibility_off_outlined,
                                  visibilityIconColor: homeCubit.exercisePlanResult![index].exercisePlanVisibility == 'public' ?
                                  ColorsManager.green : ColorsManager.error,
                                ),
                                onTap: () {
                                   navigateTo(context, PlanDetails(
                                       exercisePlanId: homeCubit.exercisePlanResult![index].exercisePlanId,
                                   ));
                                   debugPrintFullText('$index');
                                },
                                onLongPress: ()
                                {
                                  navigateTo(context, AddPlan(
                                    exercisePlanId: homeCubit.exercisePlanResult![index].exercisePlanId,
                                    exercisePlanName: homeCubit.exercisePlanResult![index].exercisePlanName,
                                    exercisePlanVisibility: homeCubit.exercisePlanResult![index].exercisePlanVisibility,
                                  ));
                                },
                              ),
                          itemCount: homeCubit.exercisePlanResult!.length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
