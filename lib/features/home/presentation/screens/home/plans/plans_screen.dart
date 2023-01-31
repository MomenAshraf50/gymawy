import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/meals.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/meal_schedule.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_details.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_meals_item.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plans_widget.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import 'add_plan.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    int tabIndex = 0;

    homeCubit.getPlan(
      isNutrition: true,
    );

    return SafeArea(child: BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return DefaultTabController(
          initialIndex: homeCubit.initialTabIndex,
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: designApp,
                child: defaultAppBar(
                    title: AppString.plans,
                    context: context,
                    actions: [
                      defaultActionButton(
                        onPressed: () {
                          navigateTo(
                              context,
                              SearchScreen(
                                plans: true,
                              ));
                        },
                        icon: Icons.search,
                        backgroundColor: ColorsManager.white,
                        iconColor: ColorsManager.black,
                      ),
                      horizontalSpace(5.w),
                      if (isCoachLogin == true)
                        defaultActionButton(
                            onPressed: () {
                              if (tabIndex == 0) {
                                navigateTo(
                                    context,
                                    AddPlan(
                                      isNutrition: true,
                                    ));
                              } else {
                                navigateTo(
                                    context,
                                    AddPlan(
                                      isNutrition: false,
                                    ));
                              }
                            },
                            backgroundColor: Colors.green,
                            icon: Icons.add)
                    ]),
              ),
              bottom: TabBar(
                  onTap: (index) {
                    debugPrintFullText(homeCubit.initialTabIndex.toString());
                    tabIndex = index;
                    homeCubit.getPlan(
                      isNutrition: index == 0 ? true : false,
                    );
                  },
                  indicatorColor: ColorsManager.mainColor,
                  tabs: const [
                    myText(
                      title: 'Nutrition Plan',
                      style: Style.small,
                    ),
                    myText(
                      title: 'Exercise Plan',
                      style: Style.small,
                    ),
                  ]),
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildPlanWidget(context),
                  buildPlanWidget(context),
                ]),
          ),
        );
      },
    ));
  }
}
