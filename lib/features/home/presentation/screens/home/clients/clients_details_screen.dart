import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_exercise_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_meal_screen.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../widgets/build_client_details_screen_items.dart';

class ClientDetailsScreen extends StatelessWidget {
  ClientDetailsScreen({Key? key}) : super(key: key);

  List<String> icons=
  [
    Assets.images.svg.completed_tasks,
    Assets.images.svg.battery,
    Assets.images.svg.goal,
    Assets.images.svg.calendar,
    Assets.images.svg.current_tall,
    Assets.images.svg.smartwatch,
    Assets.images.svg.body_fat,
  ];

  List<String> title =
  [
    AppString.completedDay,
    AppString.level,
    AppString.goals,
    AppString.plans,
    AppString.currentTall,
    AppString.currentWeight,
    AppString.bodyFat,
  ];

  List<String> titleResult =
  [
    '3',
    'Beginner',
    'Mass Gain',
    '2',
    '4',
    '90',
    '90',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              defaultAppBar(title: AppString.clientDetails, context: context),
              verticalSpace(2.h),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 50.rSp,
                            backgroundImage: const NetworkImage(AppString.networkImage),
                          ),
                          horizontalSpace(5.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myText(
                                title: AppString.userNameProfile,
                                style: Style.medium,
                                fontSize: 14.rSp,
                                fontWeight: FontWeight.w600,
                              ),
                              myText(
                                title: AppString.followersNumber,
                                style: Style.medium,
                                fontSize: 14.rSp,
                                fontWeight: FontWeight.w600,
                              ),
                              myText(
                                title: AppString.mail,
                                style: Style.extraSmall,
                                fontSize: 12.rSp,
                              ),
                              Row(
                                children: [
                                  Icon(
                                      Icons.location_on_outlined,
                                      size: 15.rSp,
                                  ),
                                  myText(
                                    title: AppString.address,
                                    style: Style.extraSmall,
                                    fontSize: 12.rSp,
                                  ),
                                ],
                              ),
                              myText(
                                title: AppString.age,
                                style: Style.extraSmall,
                                fontSize: 12.rSp,
                              ),
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(2.h),
                      ListView.builder(
                          itemBuilder: (context, index) {
                            return buildClientDetailsScreenItems(
                                icons: icons[index],
                                title: title[index],
                                titleResult: titleResult[index]
                            );
                          },
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: titleResult.length,
                      ),
                      Card(
                        color: const Color.fromARGB(255, 252, 251, 251),
                        elevation: 5,
                        margin: EdgeInsets.all(10.rSp),
                        child: Padding(
                          padding: EdgeInsets.all(15.rSp),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.images.svg.share,
                              ),
                              horizontalSpace(5.w),
                              myText(
                                  title: AppString.share,
                                  style: Style.medium,
                                  fontSize: 14.rSp,
                                  fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpace(2.h),
                      Row(
                        children: [
                          Expanded(
                              child: myButton(
                                  text: AppString.addMeal,
                                fontSize: 15.rSp,
                                  onPressed: () {
                                    navigateTo(context, const AddClientMealScreen());
                                  },
                              ),
                          ),
                          horizontalSpace(2.w),
                          Expanded(
                            child: myButton(
                              text: AppString.addExercise,
                              fontSize: 15.rSp,
                              onPressed: () {
                                navigateTo(context, const AddClientExerciseScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}