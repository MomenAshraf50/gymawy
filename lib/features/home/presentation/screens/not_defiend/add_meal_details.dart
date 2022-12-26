import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/text_field.dart';
import '../../controller/home_cubit.dart';

class AddMealDetails extends StatelessWidget {
  AddMealDetails({
    Key? key,
    required this.mealType
  }) : super(key: key);

  String mealType ;
  @override
  Widget build(BuildContext context) {
    TextEditingController mealNameController = TextEditingController();
    TextEditingController dayAndTimeController = TextEditingController();
    TextEditingController caloriesController = TextEditingController();
    TextEditingController fatController = TextEditingController();
    TextEditingController proteinController = TextEditingController();
    TextEditingController carbohydrateController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    HomeCubit homeCubit = HomeCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: designApp,
        child: Column(
          children: [
            defaultAppBar(
                title: mealType,
                context: context
            ),
            verticalSpace(5.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        homeCubit.selectMealImage(context);
                      },
                      child: SizedBox(
                        height: 140.rSp,
                        width: 180.rSp,
                        child: homeCubit.mealImageFile == null
                            ? SvgPicture.asset(Assets.images.svg.addMeal)
                            : CircleAvatar(
                          backgroundImage:
                          FileImage(homeCubit.mealImageFile!),
                        ),
                      ),
                    ),
                    textField(
                        controller: mealNameController,
                        label: AppString.nameOfMeal
                    ),
                    textField(
                        controller: dayAndTimeController,
                        label: AppString.dayAndTime
                    ),
                    textField(
                        controller: caloriesController,
                        label: AppString.calories
                    ),
                    textField(
                        controller: fatController,
                        label: AppString.fat
                    ),
                    textField(
                        controller: proteinController,
                        label: AppString.protein
                    ),
                    textField(
                        controller: carbohydrateController,
                        label: AppString.carbohydrate
                    ),
                    textField(
                        controller: descriptionController,
                        label: AppString.description
                    ),
                    verticalSpace(3.h),
                    myButton(
                      text: AppString.done,
                      onPressed: ()
                      {

                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
