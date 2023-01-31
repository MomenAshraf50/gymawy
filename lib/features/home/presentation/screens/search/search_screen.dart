import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/clients_details_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_details.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_result_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';
import 'package:gymawy/features/home/presentation/widgets/filter_dialog.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';
import '../../widgets/build_exercise_item.dart';
import '../home/exercises/exercise_basic_data.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key, this.clientsScreen, this.plans, this.exercises})
      : super(key: key);
  bool? clientsScreen;
  bool? plans;
  bool? exercises;

  @override
  Widget build(BuildContext context) {
    constClientSearchVariable = clientsScreen;
    constPlanSearchVariable = plans;
    constExerciseSearchVariable = exercises;
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeStates>(
        builder: (context, state) {
          return Scaffold(
            body: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                clientsScreen = null;
                constClientSearchVariable = null;
                plans = null;
                constPlanSearchVariable = null;
                exercises = null;
                constExerciseSearchVariable = null;
                homeCubit.searchController.text = '';
                return false;
              },
              child: HideKeyboardPage(
                child: Padding(
                  padding: designApp,
                  child: Column(
                    children: [
                      if (clientsScreen != null ||
                          plans != null ||
                          exercises != null)
                        defaultAppBar(
                            title: clientsScreen != null
                                ? 'Search for clients'
                                : plans != null
                                    ? 'Search for plans'
                                    : exercises != null
                                        ? 'Search for exercises'
                                        : '',
                            context: context,
                            onPressed: () {
                              Navigator.pop(context);
                              clientsScreen = null;
                              constClientSearchVariable = null;
                              plans = null;
                              constPlanSearchVariable = null;
                              exercises = null;
                              constExerciseSearchVariable = null;
                              homeCubit.searchController.text = '';
                            }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: myTextFill(
                              controller: homeCubit.searchController,
                              hint: clientsScreen != null
                                  ? 'Search for clients'
                                  : plans != null
                                      ? 'Search for plans'
                                      : exercises != null
                                          ? 'Search for exercises'
                                          : AppString.search,
                              iconPrefix: Icons.search,
                              onChanged: (value) {
                                plans != null
                                    ? homeCubit.getPlan(
                                        searchPlan:
                                            homeCubit.searchController.text,
                                        isNutrition: false,
                                      )
                                    : exercises != null
                                        ? homeCubit.getExercise(
                                            searchExercise:
                                                homeCubit.searchController.text)
                                        : homeCubit.search(
                                            search: homeCubit
                                                .searchController.text);
                              },
                            ),
                          ),
                          horizontalSpace(2.w),
                          if (clientsScreen == null &&
                              plans == null &&
                              exercises == null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: InkWell(
                                child: SvgPicture.asset(
                                  Assets.images.svg.filterSearch,
                                  height: 4.h,
                                  width: 4.w,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BlocBuilder<HomeCubit, HomeStates>(
                                        builder: (context, state) {
                                          return FilterDialog(
                                            firstFilterTitle: AppString.coaches,
                                            secondFilterTitle:
                                                AppString.clients,
                                            onTapFirstChoice: () {
                                              homeCubit
                                                  .changeToFirstChoiceRadioButton();
                                            },
                                            onTapSecondChoice: () {
                                              homeCubit
                                                  .changeToSecondChoiceRadioButton();
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                      verticalSpace(1.h),
                      if (homeCubit.results != null &&
                              homeCubit.searchController.text.isNotEmpty ||
                          homeCubit.planResult != null &&
                              homeCubit.searchController.text.isNotEmpty)
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return plans != null
                                  ? InkWell(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            PlanDetails(
                                              exercisePlanId: homeCubit
                                                  .planResult![index]
                                                  .exercisePlanId,
                                              ownerUserId: homeCubit
                                                  .planResult![index].userId,
                                            ));
                                      },
                                      child: buildPlansItems(
                                        context,
                                        planTitle: homeCubit
                                            .planResult![index].planName,
                                        visibilityIcon: homeCubit
                                                    .planResult![index]
                                                    .planVisibility ==
                                                'public'
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        visibilityIconColor: homeCubit
                                                    .planResult![index]
                                                    .planVisibility ==
                                                'public'
                                            ? ColorsManager.green
                                            : ColorsManager.error,
                                      ),
                                    )
                                  : exercises != null
                                      ? InkWell(
                                          child: buildExercisesItems(
                                            exerciseImage: homeCubit
                                                .exerciseResult![index]
                                                .exercisePic,
                                            exerciseName: homeCubit
                                                .exerciseResult![index]
                                                .exerciseName,
                                            exerciseCategory: homeCubit
                                                .exerciseResult![index]
                                                .exerciseCategory,
                                          ),
                                          onTap: () {
                                            navigateTo(
                                                context,
                                                ExerciseBasicData(
                                                  exerciseEntity: homeCubit
                                                      .exerciseResult![index],
                                                ));
                                            debugPrintFullText('$index');
                                          },
                                        )
                                      : InkWell(
                                          onTap: () {
                                            if (clientsScreen == null) {
                                              navigateTo(
                                                  context,
                                                  SearchResultScreen(
                                                    userId: homeCubit
                                                        .results![index].userId,
                                                    name: homeCubit
                                                        .results![index]
                                                        .userName,
                                                    pic: homeCubit
                                                        .results![index]
                                                        .profilePicture,
                                                    location: homeCubit
                                                        .results![index]
                                                        .location,
                                                    bio: homeCubit
                                                        .results![index].bio,
                                                    verification: homeCubit
                                                        .results![index]
                                                        .verification,
                                                    facebookLink: homeCubit
                                                        .results![index]
                                                        .facebookLink,
                                                    fixedPrice: homeCubit
                                                        .results![index]
                                                        .fixedPrice,
                                                    instagramLink: homeCubit
                                                        .results![index]
                                                        .instagramLink,
                                                    tiktokLink: homeCubit
                                                        .results![index]
                                                        .tiktokLink,
                                                    youtubeLink: homeCubit
                                                        .results![index]
                                                        .youtubeLink,
                                                  ));
                                            }
                                            if (clientsScreen != null) {
                                              navigateTo(
                                                  context,
                                                  ClientDetailsScreen(
                                                    name: homeCubit
                                                        .results![index]
                                                        .userName,
                                                    address: homeCubit
                                                        .results![index]
                                                        .location,
                                                    age:
                                                        '${homeCubit.results![index].age}',
                                                    bodyFat:
                                                        '${homeCubit.results![index].bodyFat}',
                                                    goal: homeCubit
                                                        .results![index].goal,
                                                    img: homeCubit
                                                        .results![index]
                                                        .profilePicture,
                                                    tall:
                                                        '${homeCubit.results![index].currentTall}',
                                                    weight:
                                                        '${homeCubit.results![index].currentWeight}',
                                                  ));
                                            }
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 1.h),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 251, 239, 233),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.rSp),
                                              ),
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.all(10.0.rSp),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 33.rSp,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        homeCubit
                                                            .results![index]
                                                            .profilePicture!,
                                                      ),
                                                    ),
                                                    horizontalSpace(2.w),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        myText(
                                                          title: homeCubit
                                                              .results![index]
                                                              .userName!,
                                                          //AppString.resultSearchName,
                                                          style:
                                                              Style.extraSmall,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14.rSp,
                                                        ),
                                                        verticalSpace(0.5.h),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              Icons.location_on,
                                                              size: 15.rSp,
                                                            ),
                                                            myText(
                                                              title: homeCubit
                                                                  .results![
                                                                      index]
                                                                  .location!,
                                                              //AppString.resultSearchLocation,
                                                              style: Style
                                                                  .extraSmall,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 14.rSp,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                            },
                            physics: const BouncingScrollPhysics(),
                            itemCount: plans != null
                                ? homeCubit.planResult!.length
                                : exercises != null
                                    ? homeCubit.exerciseResult!.length
                                    : homeCubit.results!.length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
