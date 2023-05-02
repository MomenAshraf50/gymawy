import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_screen.dart';
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

    return BlocBuilder<HomeCubit, HomeStates>(
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
                                isNutritionPlan: tabIndex == 0 ? true: false,
                              ));
                        },
                        icon: Icons.search,
                        backgroundColor: ColorsManager.white,
                        iconColor: ColorsManager.black,
                      ),
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
                    DefaultText(
                      title: 'Nutrition Plan',
                      style: Style.small,
                    ),
                    DefaultText(
                      title: 'Exercise Plan',
                      style: Style.small,
                    ),
                  ]),
            ),
            body: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildPlanWidget(
                      context:context,
                      isNutrition: true
                  ),
                  buildPlanWidget(
                      context:context,
                      isNutrition: false
                  ),
                ]),
            floatingActionButton:isCoachLogin? FloatingActionButton(
              onPressed: (){
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
              child: const Icon(Icons.add,color: ColorsManager.white,),
            ):Container(),
          ),
        );
      },
    );
  }
}
