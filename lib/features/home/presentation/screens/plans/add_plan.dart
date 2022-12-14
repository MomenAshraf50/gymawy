import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/myTextFill.dart';

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultBackButton(function: () {
                        Navigator.pop(context);
                      },
                      ),
                      const Expanded(
                          child: Center(
                              child: myText(
                                title: AppString.addPlan,
                                style: Style.large,
                                fontFamily: 'poppins',
                              )
                          )
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      myTextFill(
                        controller: homeCubit.nameOfPlanController,
                        hint: AppString.nameOfPlan,
                        hintStyle: Theme
                            .of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.rSp,
                            color: Colors.grey,
                            fontFamily: 'poppins'
                        ),
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
                            Text(
                              AppString.visibility,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                  color: Colors.grey,
                                  fontFamily: 'poppins'
                              ),
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
