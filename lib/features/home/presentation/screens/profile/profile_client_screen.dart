import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_exercise_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_meal_screen.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../controller/home_cubit.dart';
import '../../widgets/build_client_details_screen_items.dart';
import 'edit_profile.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({Key? key}) : super(key: key);

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

  // List<String> titleResult =
  // [
  //   '3',
  //   'Beginner',
  //   'Mass Gain',
  //   '2',
  //   '4',
  //   '90',
  //   '90',
  // ];



  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
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
                            backgroundImage: NetworkImage(
                                //AppString.networkImage
                              homeCubit.profileResults!.userInformation.profilePicture
                            ),
                          ),
                          horizontalSpace(2.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40.w,
                                    child: myText(
                                      title:
                                      //'0000000000000000000000000000000000000',
                                      '${homeCubit.profileResults!.userInformation.firstName} ${homeCubit.profileResults!.userInformation.lastName}',
                                      //AppString.userNameProfile,
                                      style: Style.medium,
                                      fontSize: 14.rSp,
                                      fontWeight: FontWeight.w600,
                                      maxLines: 1,
                                    ),
                                  ),
                                  horizontalSpace(2.w),
                                  CircleAvatar(
                                    radius: 20.rSp,
                                    backgroundColor: ColorsManager.mainColor,
                                    child: Center(
                                      child: IconButton(
                                          onPressed: ()
                                          {
                                            navigateTo(context, EditProfileScreen(
                                              userName: homeCubit.profileResults!.userInformation.userName,
                                              email: homeCubit.profileResults!.userInformation.email,
                                              firstName: homeCubit.profileResults!.userInformation.firstName,
                                              lastName: homeCubit.profileResults!.userInformation.lastName,
                                              phone: homeCubit.profileResults!.userInformation.phoneNumber,
                                              bio: homeCubit.profileResults!.userInformation.bio,
                                            ));
                                          },
                                          icon: const Icon(Icons.edit,color: ColorsManager.white,)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              myText(
                                title: AppString.followersNumber,
                                style: Style.medium,
                                fontSize: 14.rSp,
                                fontWeight: FontWeight.w600,
                              ),
                              // myText(
                              //   title: homeCubit.profileResults!.email,
                              //   //AppString.mail,
                              //   style: Style.extraSmall,
                              //   fontSize: 12.rSp,
                              // ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 15.rSp,
                                  ),
                                  myText(
                                    title: homeCubit.profileResults!.userInformation.governorate,
                                    //AppString.address,
                                    style: Style.extraSmall,
                                    fontSize: 12.rSp,
                                  ),
                                ],
                              ),
                              myText(
                                title: '${homeCubit.profileResults!.userInformation.age} Years old',
                                //AppString.age,
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
                              titleResult:
                              [
                                '3',
                                'Beginner',
                                homeCubit.profileResults!.goal!,
                                '2',
                                '${homeCubit.profileResults!.currentTall!}',
                                '${homeCubit.profileResults!.currentWeight!}',
                                '${homeCubit.profileResults!.bodyFat!}',
                              ]
                              [index],
                          );
                        },
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: title.length,
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