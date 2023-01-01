import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_type.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/meal_schedule.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';
import 'package:gymawy/features/home/presentation/widgets/filter_dialog.dart';
import 'add_plan.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return SafeArea(
      child:Scaffold(
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
                                  navigateTo(context, const AddPlan());
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      InkWell(
                        child: buildPlansItems(context),
                        onTap: () {
                          navigateTo(context, const PlanType());
                          debugPrintFullText('$index');
                        },
                      ),
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      )

      );

  }
}
