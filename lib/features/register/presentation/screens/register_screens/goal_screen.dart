import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/goal_data_static.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/widgets/build_goal_design.dart';

class GoalScreen extends StatelessWidget {
  GoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5.h
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.only(
              end: 15.0,
              start: 15.0,
              top: 15.0,
            ),
            child: myText(
              title: AppString.what_is_goal,
              style: Style.large,
              align: TextAlign.center,
            ),
          ),
          verticalSpace(1.h),
          const myText(
              title: AppString.i_will_help_us_to_choose_a_best_program,
              style: Style.medium,
              align: TextAlign.center),
          verticalSpace(3.h),
          BlocBuilder<RegisterCubit, RegisterStates>(
            builder: (context, state) {
              return Expanded(
                child: PageView.builder(
                  controller: PageController(
                    initialPage: registerCubit.selectedPage,
                    viewportFraction: 0.7,
                    keepPage: true,
                  ),
                  allowImplicitScrolling: true,
                  pageSnapping: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          registerCubit.changeSelectedPage(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildDesign(
                              index: index,
                              model: registerCubit.listGoal[index],
                              context: context,
                              selected:  registerCubit.selectedPage),
                        ));
                  },
                  itemCount:  registerCubit.listGoal.length,
                ),
              );
            },
          ),
          verticalSpace(2.h),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 15.0,
              start: 15.0,
              top: 15.0,
            ),
            child: myButton(
              elevation: 0.0,
              textOnly: true,
              color: ColorsManager.mainColor,
              height: 3.h,
              text: AppString.next,
              onPressed: () {

              },
            ),
          ),
        ],
      ),
    );
  }
}
