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
import 'package:gymawy/features/home/presentation/screens/home/plans/plans_screen.dart';

class AddPlan extends StatelessWidget {
  const AddPlan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              return Column(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                  homeCubit.isVisibilityPlanIcon! ?
                                  Assets.images.svg.visibility_false : Assets
                                      .images.svg.visibility_true
                              ),
                              onTap: () {
                                homeCubit.visibilityPlan();
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5.h),
                    child: myButton(
                      text: AppString.next,
                      textOnly: true,
                      onPressed: () {
                        navigateAndFinish(context,const PlansScreen());
                      },

                    ),
                  )

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
