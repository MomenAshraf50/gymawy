import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/data/models/add_nutrition_details_model.dart';
import 'package:gymawy/features/home/domain/entities/add_nutrition_entity.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';
import '../../../../domain/entities/add_nutrition_details_entity.dart';

class NutritionBasicData extends StatelessWidget {
  NutritionBasicData({
    Key? key,
    this.nutritionEntity,
    this.details,
  }) : super(key: key);

  AddNutritionEntity? nutritionEntity;
  bool? details;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is DeleteNutritionSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          homeCubit.getNutrition();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      end: AlignmentDirectional.bottomEnd,
                      begin: AlignmentDirectional.topStart,
                      colors: [
                        Color.fromARGB(255, 255, 192, 147),
                        ColorsManager.mainColor,
                        ColorsManager.mainColor,
                      ],
                    )),
                    child: Column(
                      children: [
                        defaultAppBar(
                            title: nutritionEntity!.nutritionName!,
                            fontColor: ColorsManager.white,
                            context: context,
                            color: Colors.transparent,
                            actions: [
                              if (userId ==
                                  nutritionEntity!.userInformation.userId)
                                Padding(
                                  padding: EdgeInsets.only(right: 3.w),
                                  child: defaultActionButton(
                                      onPressed: () {
                                        navigateTo(
                                            context,
                                            AddNutrition(
                                              nutritionEntity: nutritionEntity,
                                            ));
                                      },
                                      icon: Icons.edit,
                                      backgroundColor: ColorsManager.white,
                                      iconColor: ColorsManager.darkGrey),
                                ),
                            ]),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.all(20.rSp),
                            child: Center(
                                child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.rSp),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        nutritionEntity!.nutritionPic!,
                                      ))),
                            )),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorsManager.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.rSp),
                                topRight: Radius.circular(40.rSp),
                              ),
                            ),
                            child: Padding(
                              padding: designApp,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalSpace(2.h),
                                    DefaultText(
                                      title:
                                          nutritionEntity!.nutritionCategory!,
                                      style: Style.small,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    verticalSpace(0.5.h),
                                    DefaultText(
                                      title:
                                          'by ${nutritionEntity!.userInformation.userName}',
                                      style: Style.extraSmall,
                                    ),
                                    verticalSpace(2.h),
                                    const DefaultText(
                                      title: 'Nutrition',
                                      style: Style.small,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    verticalSpace(3.h),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      child: Padding(
                                        padding:  EdgeInsets.all(10.rSp),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    Assets.images.svg.calories),
                                                horizontalSpace(0.5.w),
                                                DefaultText(
                                                  title:
                                                      '${nutritionEntity!.nutritionCalories}k Cal',
                                                  style: Style.extraSmall,
                                                  fontSize: 10.rSp,
                                                ),
                                              ],
                                            ),
                                            horizontalSpace(4.w),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    Assets.images.svg.fat),
                                                horizontalSpace(0.5.w),
                                                DefaultText(
                                                  title:
                                                      '${nutritionEntity!.nutritionFat}g fats',
                                                  style: Style.extraSmall,
                                                  fontSize: 10.rSp,
                                                ),
                                              ],
                                            ),
                                            horizontalSpace(4.w),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    Assets.images.svg.protein),
                                                horizontalSpace(0.5.w),
                                                DefaultText(
                                                  title:
                                                      '${nutritionEntity!.nutritionProtein}g proteins',
                                                  style: Style.extraSmall,
                                                  fontSize: 10.rSp,
                                                ),
                                              ],
                                            ),
                                            horizontalSpace(4.w),
                                            Row(
                                              children: [
                                            SvgPicture.asset(
                                                Assets.images.svg.rice),
                                            horizontalSpace(0.5.w),
                                            DefaultText(
                                              title:
                                                  '${nutritionEntity!.nutritionCarb}g carb',
                                              style: Style.extraSmall,
                                              fontSize: 10.rSp,
                                            ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    verticalSpace(1.h),
                                    ExpansionTile(
                                      tilePadding: EdgeInsets.zero,
                                      title: const DefaultText(
                                        title: 'Components',
                                        style: Style.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 1.h),
                                              child: Row(
                                                children: [
                                                  // Expanded(
                                                  //     child: myText(
                                                  //         title: '${index + 1}',
                                                  //         style: Style.small)),
                                                  // horizontalSpace(2.w),
                                                  Expanded(
                                                      child: DefaultText(
                                                          title: nutritionEntity!
                                                              .nutritionComponent!
                                                              .keys
                                                              .toList()[index],
                                                          style: Style.small)),
                                                  Expanded(
                                                      child: DefaultText(
                                                          title: nutritionEntity!
                                                              .nutritionComponent!
                                                              .values
                                                              .toList()[index],
                                                          style: Style.small)),
                                                ],
                                              ),
                                            );
                                          },
                                          itemCount: nutritionEntity!
                                              .nutritionComponent!.values
                                              .toList()
                                              .length,
                                        )
                                      ],
                                    ),
                                    if (nutritionEntity!
                                            .nutritionHowToPrepare !=
                                        null)
                                      const DefaultText(
                                        title: 'How to prepare',
                                        style: Style.small,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    if (nutritionEntity!
                                            .nutritionHowToPrepare !=
                                        null)
                                      verticalSpace(2.h),
                                    if (nutritionEntity!
                                            .nutritionHowToPrepare !=
                                        null)
                                      DefaultText(
                                        title: nutritionEntity!
                                            .nutritionHowToPrepare!,
                                        style: Style.extraSmall,
                                      ),
                                    verticalSpace(4.h),
                                    if (userId! ==
                                        nutritionEntity!.userInformation.userId)
                                      DefaultButton(
                                        text: AppString.delete,
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DefaultDialog(
                                                  message:
                                                      'Are you sure to delete this Nutrition',
                                                  pushButtonText: 'yes',
                                                  buttonColor:
                                                      ColorsManager.error,
                                                  pushButtonVoidCallback: () {
                                                    homeCubit.deleteNutrition(
                                                        DeleteNutritionParams(
                                                            nutritionEntity!
                                                                .nutritionId!));
                                                  },
                                                );
                                              });
                                        },
                                        color: ColorsManager.redPrimary,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
