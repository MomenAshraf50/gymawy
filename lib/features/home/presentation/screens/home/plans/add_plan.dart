import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/add_exercise.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plans_screen.dart';

import '../../../../../../core/util/widgets/hideKeyboard.dart';


class AddPlan extends StatelessWidget {
   AddPlan({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: designApp,
            child: BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {
                if(state is AddExercisePlanSuccessState)
                {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: 'Exercise Plan Added Successfully');
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: HideKeyboardPage(
                    child: Column(
                      children: [
                        defaultAppBar(
                            title: AppString.addPlan,
                            context: context,
                          onPressed: ()
                          {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        ),
                        verticalSpace(20.h),
                        myTextFill(
                          controller: homeCubit.nameOfPlanController,
                          hint: AppString.nameOfPlan,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                          },

                        ),
                        verticalSpace(5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              myText(
                                title: AppString.visibility,
                                style: Style.extraSmall,
                                fontWeight: FontWeight.w700,
                                fontSize: 12.rSp,
                              ),
                              const Spacer(),
                              InkWell(
                                child: SvgPicture.asset(
                                    homeCubit.isVisibilityPlanIcon! ?Assets.images.svg.visibility_true
                                        : Assets.images.svg.visibility_false
                                ),
                                onTap: () {
                                  homeCubit.visibilityPlan();
                                },
                              ),

                            ],
                          ),
                        ),
                        verticalSpace(30.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5.h),
                          child: myButton(
                            text: AppString.done,
                            onPressed: () {
                              debugPrintFullText('plan name ======================${homeCubit.nameOfPlanController.text}' );
                              debugPrintFullText('plan visibility ======================${homeCubit.visibilityExerciseValue!}' );
                              if(formKey.currentState!.validate())
                              {
                                homeCubit.addExercisePlan(
                                    exercisePlanName: homeCubit.nameOfPlanController.text,
                                    exercisePlanVisibility: homeCubit.visibilityExerciseValue!
                                );
                              }
                              // navigateAndFinish(context,const PlansScreen());
                             // Navigator.pop(context);
                            },

                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
