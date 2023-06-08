import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/domain/usecase/get_body_measurements_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_exercise_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/add_meal_screen.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../domain/entities/body_measurements_entity.dart';
import '../../../../domain/entities/coach_subscriptions_entity.dart';
import '../../../widgets/build_client_details_screen_items.dart';

class ClientDetailsScreen extends StatelessWidget {
  ClientDetailsScreen({
    Key? key,
    required this.clientId,
    required this.index,
    this.result

  }) : super(key: key);
  int clientId;
  int index;
  List<CoachSubscriptionsEntity>? result;
  List<String> icons =
  [
    //Assets.images.svg.completed_tasks,
   // Assets.images.svg.battery,
    Assets.images.svg.goal,
   // Assets.images.svg.calendar,
    Assets.images.svg.current_tall,
    Assets.images.svg.smartwatch,
    Assets.images.svg.body_fat,
  ];

  List<String> title =
  [
    //AppString.completedDay,
    // AppString.level,
    AppString.goals,
    //AppString.plans,
    AppString.currentTall,
    AppString.currentWeight,
    AppString.bodyFat,
  ];
  
  


  // List<String> values = [
  //   '${result![index].clientInformation.}'
  // ]


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    homeCubit.getBodyMeasurements(GetBodyMeasurementsParams(userName: result![index].clientInformation.userName));




    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

        if(state is GetBodyMeasurementsSuccessState)
        {
          List<BodyMeasurementsEntity>? results = state.bodyMeasurementsEntity;
          List<String> titleResult =
          [
            results![index].goal,
            '${results[index].tall}',
            '${results[index].weight}',
            '${results[index].bodyFat}',
          ];

          homeCubit.bodyMeasurementResults = titleResult;

        }

      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: designApp,
              child: Column(
                children: [
                  defaultAppBar(
                      title: AppString.clientDetails,
                      context: context
                  ),
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
                                backgroundImage: NetworkImage(
                                    //AppString.networkImage
                                  result![index].clientInformation.profilePicture
                                ),
                              ),
                              horizontalSpace(5.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultText(
                                    title: result![index].clientInformation.userName,
                                    //AppString.userNameProfile,
                                    style: Style.medium,
                                    fontSize: 14.rSp,
                                    fontWeight: FontWeight.w600,
                                  ),

                                  // myText(
                                  //   title: AppString.mail,
                                  //   style: Style.extraSmall,
                                  //   fontSize: 12.rSp,
                                  // ),
                                  verticalSpace(1.h),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 15.rSp,
                                      ),
                                      DefaultText(
                                        title:
                                        //AppString.address,
                                        result![index].clientInformation.governorate,
                                        style: Style.extraSmall,
                                        fontSize: 12.rSp,
                                      ),
                                    ],
                                  ),
                                  verticalSpace(1.h),
                                  DefaultText(
                                    title:
                                    //AppString.age,
                                   '${result![index].clientInformation.age}',
                                    style: Style.extraSmall,
                                    fontSize: 12.rSp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          verticalSpace(2.h),
                          if( homeCubit.bodyMeasurementResults != null)
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return buildClientDetailsScreenItems(
                                  icons: icons[index],
                                  title: title[index],
                                  titleResult: homeCubit.bodyMeasurementResults![index]
                              );
                            },
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeCubit.bodyMeasurementResults!.length,
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
                                  DefaultText(
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
                                child: DefaultButton(
                                  text: AppString.addMeal,
                                  fontSize: 15.rSp,
                                  onPressed: () {
                                    navigateTo(
                                        context, const AddClientMealScreen());
                                  },
                                ),
                              ),
                              horizontalSpace(2.w),
                              Expanded(
                                child: DefaultButton(
                                  text: AppString.addExercise,
                                  fontSize: 15.rSp,
                                  onPressed: () {
                                    navigateTo(context,
                                        const AddClientExerciseScreen());
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
      },
    );
  }
}