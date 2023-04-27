import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_details.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';

Widget buildPlanWidget({
  context,
  required bool isNutrition,
}){
  HomeCubit homeCubit = HomeCubit.get(context);
  return Padding(
    padding: designApp,
    child: Column(
      children: [
        BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              return homeCubit.planResult != null?
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      InkWell(
                        child: buildPlansItems(
                          context,
                          planTitle: homeCubit.planResult![index].planName,
                          visibilityIcon: homeCubit.planResult![index].planVisibility == 'public'
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          visibilityIconColor: homeCubit.planResult![index].planVisibility == 'public'
                              ? ColorsManager.green
                              : ColorsManager.error,
                        ),
                        onTap: () {
                          navigateTo(
                              context,
                              PlanDetails(
                                planId: isNutrition == true ? homeCubit.planResult![index].planId :homeCubit.planResult![index].planId,
                                ownerUserId: homeCubit.planResult![index].makerInformation.userId,
                                planVisibility: homeCubit.planResult![index].planVisibility,
                                planName: homeCubit.planResult![index].planName,
                                isNutrition: isNutrition,
                              ));
                          debugPrintFullText('$index');
                          debugPrintFullText('$isNutrition');
                        },
                      ),
                  itemCount: homeCubit.planResult!.length,
                  physics: const BouncingScrollPhysics(),
                ),
              ):const LoadingPage();
            },
          ),
      ],
    ),
  );
}