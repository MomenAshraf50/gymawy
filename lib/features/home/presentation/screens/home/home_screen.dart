import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/di/injection.dart';
import 'package:gymawy/core/network/local/cache_helper.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/features/home/presentation/screens/home/client_progress/client_progress_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/exercises_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plans_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/workout_tracker/workout_tracker.dart';
import 'package:gymawy/features/home/presentation/widgets/filter_dialog.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/loadingPage.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_states.dart';
import '../search/search_result_screen.dart';
import '../settings/notifications_screen.dart';
import 'clients/clients_screen.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {
          if(homeCubit.profileResults != null){
            sl<CacheHelper>().put('userName', homeCubit.profileResults!.userName);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: homeCubit.profileResults == null ?
            const Center(
                child: LoadingPage()
            ) :
            HideKeyboardPage(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Padding(
                    padding: designApp,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 50.rSp,
                              backgroundImage:
                              NetworkImage(
                                // 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='
                                  homeCubit.profileResults!.profilePicture
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                navigateTo(context, const NotificationsScreen());
                              },
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  SvgPicture.asset(
                                    Assets.images.svg.notifications,
                                    width: 3.w,
                                    height: 4.h,
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 4.w,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(7.rSp)),
                                    child: Center(
                                      child: Text(AppString.notificationsNum,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge!
                                              .copyWith(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.rSp,
                                              color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        verticalSpace(1.h),
                        myText(
                          title: '${AppString.helloClient}${homeCubit.profileResults!.fullName},',
                          style: Style.small,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.rSp,
                        ),
                        verticalSpace(1.h),
                        myText(
                          title: AppString.ready,
                          style: Style.small,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.rSp,
                        ),
                        verticalSpace(4.h),

                        /// will change this raw
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: myTextFill(
                                controller: homeCubit.searchController,
                                hint: AppString.search,
                                iconPrefix: Icons.search,
                                onChanged: (value)
                                {
                                  homeCubit.search(
                                      search: homeCubit.searchController.text
                                  );
                                },
                              ),
                            ),
                            horizontalSpace(1.w),
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
                                            secondFilterTitle: AppString.clients,
                                            onTapFirstChoice: (){
                                              homeCubit.changeToFirstChoiceRadioButton();
                                            },
                                            onTapSecondChoice: (){
                                              homeCubit.changeToSecondChoiceRadioButton();
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
                        if(homeCubit.results != null && homeCubit.searchController.text.isNotEmpty)
                          SizedBox(
                            height: 20.h,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    isCoachFilter == false?
                                    navigateTo(context, SearchResultScreen(
                                      userId: homeCubit.results![index].userId,
                                      name: homeCubit.results![index].userName,
                                      pic: homeCubit.results![index].profilePicture,
                                      location: homeCubit.results![index].location,
                                      bio: homeCubit.results![index].bio,
                                      age: homeCubit.results![index].age,
                                      currentWeight: homeCubit.results![index].currentWeight,
                                      currentTall: homeCubit.results![index].currentTall,
                                      bodyFat: homeCubit.results![index].bodyFat,
                                      goal: homeCubit.results![index].goal,
                                    )) :
                                    navigateTo(context, SearchResultScreen(
                                      userId: homeCubit.results![index].userId,
                                      name: homeCubit.results![index].userName,
                                      pic: homeCubit.results![index].profilePicture,
                                      location: homeCubit.results![index].location,
                                      fixedPrice: homeCubit.results![index].fixedPrice,
                                      facebookLink: homeCubit.results![index].facebookLink,
                                      instagramLink: homeCubit.results![index].instagramLink,
                                      youtubeLink: homeCubit.results![index].youtubeLink,
                                      tiktokLink: homeCubit.results![index].tiktokLink,
                                      verification: homeCubit.results![index].verification,
                                    ))
                                    ;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 1.h),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 251, 239, 233),
                                        borderRadius: BorderRadius.circular(10.rSp),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.rSp),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 33.rSp,
                                              backgroundImage: NetworkImage(
                                                  homeCubit.results![index].profilePicture!
                                              ),
                                            ),
                                            horizontalSpace(2.w),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                myText(
                                                  title: homeCubit.results![index].userName!,
                                                  //AppString.resultSearchName,
                                                  style: Style.extraSmall,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.rSp,
                                                ),
                                                // verticalSpace(0.5.h),
                                                // myText(
                                                //   title: AppString.resultSearchType,
                                                //   style: Style.extraSmall,
                                                //   fontWeight: FontWeight.w400,
                                                //   fontSize: 14.rSp,
                                                // ),
                                                verticalSpace(0.5.h),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    // Icon(
                                                    //   Icons.star,
                                                    //   color: Colors.yellow,
                                                    //   size: 20.rSp,
                                                    // ),
                                                    // Icon(
                                                    //   Icons.star,
                                                    //   color: Colors.yellow,
                                                    //   size: 20.rSp,
                                                    // ),
                                                    // Icon(
                                                    //   Icons.star,
                                                    //   color: Colors.yellow,
                                                    //   size: 20.rSp,
                                                    // ),
                                                    // Icon(
                                                    //   Icons.star,
                                                    //   color: Colors.yellow,
                                                    //   size: 20.rSp,
                                                    // ),
                                                    // horizontalSpace(4.w),
                                                    Icon(
                                                      Icons.location_on,
                                                      size: 15.rSp,
                                                    ),
                                                    myText(
                                                      title: homeCubit.results![index].location!,
                                                      //AppString.resultSearchLocation,
                                                      style: Style.extraSmall,
                                                      fontWeight: FontWeight.w400,
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
                              itemCount: homeCubit.results!.length,
                            ),
                          ),
                        verticalSpace(2.h),
                        const myText(
                          title: AppString.suggestions,
                          style: Style.extraSmall,
                          fontWeight: FontWeight.w600,
                        ),
                        verticalSpace(1.h),
                        SizedBox(
                          height: 21.h,
                          child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padEnds: false,
                            controller: PageController(
                              initialPage: homeCubit.selected,
                              viewportFraction: 0.45,
                              keepPage: true,
                            ),
                            allowImplicitScrolling: true,
                            pageSnapping: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                  child: Container(
                                    margin: EdgeInsets.all(9.rSp),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        // selected == index ?
                                        BoxShadow(
                                          color: ColorsManager.mainColor,
                                          spreadRadius: 0,
                                          blurRadius: 8,
                                        )
                                        // : const BoxShadow(),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      // border: Border.all(color: Colors.orange),
                                      gradient: const LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                        colors: [
                                          ColorsManager.whiteColor,
                                          ColorsManager.whiteColor,
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.rSp),
                                      child: Column(
                                        children: [
                                          index == 3 || index == 4
                                              ? Lottie.asset(
                                              Assets.images.lotti.dumbble,
                                              height: 11.h)
                                              : SvgPicture.asset(
                                            homeCubit
                                                .listSuggestions[index].img,
                                              height: 11.h
                                          ),
                                          verticalSpace(2.h),
                                          myText(
                                            title: homeCubit
                                                .listSuggestions[index].title,
                                            style: Style.extraSmall,
                                            color: Colors.black,
                                            fontSize: 12.rSp,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  if (index == 0) {
                                    navigateTo(context, const PlansScreen());
                                  } else if (index == 1) {
                                    navigateTo(context, ExercisesScreen(isAddExercise: false,));
                                  } else if (index == 2) {
                                    navigateTo(context, ClientsScreen(
                                      clientVariable: 'test',
                                    ));
                                  } else if (index == 3){
                                    navigateTo(context, const ProgressScreen());
                                  }else{
                                    navigateTo(context, const WorkoutTrackerScreen());
                                  }
                                },
                              );
                            },
                            itemCount: homeCubit.listSuggestions.length,
                          ),
                        ),
                        if(isCoachLogin == false)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace(2.h),
                              const myText(
                                title: AppString.todaySession,
                                style: Style.extraSmall,
                                fontWeight: FontWeight.w600,
                              ),
                              verticalSpace(0.5.h),
                              myText(
                                title: AppString.doNotMiss,
                                style: Style.extraSmall,
                                fontSize: 12.rSp,
                              ),
                              verticalSpace(0.5.h),
                              Stack(
                                children: [
                                  SizedBox(
                                      height: 24.h,
                                      child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Image.asset(
                                            Assets.images.svg.cardWithGirl,
                                          ))),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5.w, 8.5.h, 0, 0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 3.h,
                                          width: 15.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 252, 183, 146),
                                              borderRadius: BorderRadius.circular(15)),
                                          child: Center(
                                              child: myText(
                                                title: AppString.daysNum,
                                                style: Style.extraSmall,
                                                fontSize: 9.rSp,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ),
                                        verticalSpace(0.5.h),
                                        myText(
                                          title: AppString.fullBodyExercise,
                                          style: Style.extraSmall,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.rSp,
                                        ),
                                        myText(
                                          title: AppString.level,
                                          style: Style.extraSmall,
                                          fontSize: 12.rSp,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 3.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 252, 183, 146),
                                                  borderRadius:
                                                  BorderRadius.circular(15)),
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        Assets.images.svg.clock),
                                                    horizontalSpace(1.w),
                                                    myText(
                                                      title: AppString.clock,
                                                      style: Style.extraSmall,
                                                      fontSize: 12.rSp,
                                                      letterSpacing: 0.5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            horizontalSpace(0.5.w),
                                            Container(
                                              height: 3.h,
                                              width: 20.w,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 252, 183, 146),
                                                  borderRadius:
                                                  BorderRadius.circular(15)),
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        Assets.images.svg.fire),
                                                    horizontalSpace(1.w),
                                                    myText(
                                                      title: AppString.cal,
                                                      style: Style.extraSmall,
                                                      fontSize: 12.rSp,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        verticalSpace(1.h),
                                        InkWell(
                                          child: Container(
                                            height: 3.h,
                                            width: 41.w,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 0, 173, 199),
                                                borderRadius: BorderRadius.circular(15)),
                                            child: Center(
                                              child: myText(
                                                title: AppString.startNow,
                                                style: Style.extraSmall,
                                                fontSize: 12.rSp,
                                              ),
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
