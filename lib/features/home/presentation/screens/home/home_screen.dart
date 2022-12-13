import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';
import '../../controller/home_states.dart';

class HomeClientScreen extends StatelessWidget {
  const HomeClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: designApp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Assets.images.svg.profile,
                        width: 10.w,
                        height: 10.h,
                      ),
                      const Spacer(),
                      Stack(
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
                      )
                    ],
                  ),
                  verticalSpace(1.h),
                  myText(
                    title: AppString.helloClient,
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
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.rSp,
                                  color: Colors.grey.shade400),
                          iconPrefix: Icons.search,
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
                                    return AlertDialog(
                                      shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      title: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              homeCubit
                                                  .changeToCoachRadioButton();
                                            },
                                            child: SizedBox(
                                              height: 30.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppString.coaches,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            fontFamily:
                                                                'poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 10.h,
                                                    width: 10.w,
                                                    decoration: BoxDecoration(
                                                        color: homeCubit
                                                                .coachRadioButton
                                                            ? const Color
                                                                    .fromARGB(
                                                                255,
                                                                248,
                                                                96,
                                                                13)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          verticalSpace(10.h),
                                          Container(
                                            width: double.infinity,
                                            height: 1.h,
                                            color: Colors.grey.shade300,
                                          ),
                                          verticalSpace(10.h),
                                          InkWell(
                                            onTap: () {
                                              homeCubit
                                                  .changeToClientRadioButton();
                                            },
                                            child: SizedBox(
                                              height: 30.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppString.clients,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall!
                                                        .copyWith(
                                                            fontFamily:
                                                                'poppins',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 10.h,
                                                    width: 10.w,
                                                    decoration: BoxDecoration(
                                                        color: homeCubit
                                                                .clientRadioButton
                                                            ? const Color
                                                                    .fromARGB(
                                                                255,
                                                                248,
                                                                96,
                                                                13)
                                                            : Colors
                                                                .transparent,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        border: Border.all(
                                                            color:
                                                                Colors.grey)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                  verticalSpace(2.h),
                  const myText(
                    title: AppString.suggestions,
                    style: Style.extraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                  verticalSpace(1.h),
                  SizedBox(
                    height: 25.h,
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
                                    SvgPicture.asset(
                                      homeCubit.listSuggestions[index].img,
                                      height: 15.h,
                                    ),
                                    verticalSpace(1.h),
                                    myText(
                                      title: homeCubit
                                          .listSuggestions[index].title,
                                      style: Style.small,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            // if(index == 0){
                            //   navigateTo(context, const PlansScreen());
                            // }else if (index == 1){
                            //   navigateTo(context, const ExercisesScreen());
                            // }else{}
                          },
                        );
                      },
                      itemCount: homeCubit.listSuggestions.length,
                    ),
                  ),
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
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 24.h,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 248, 96, 13),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 4.h, 0, 3.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                  child: Text(
                                    AppString.daysNum,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 9.rSp,
                                        ),
                                  ),
                                ),
                              ),
                              verticalSpace(0.5.h),
                              myText(
                                title: AppString.fullBodyExercise,
                                style: Style.extraSmall,
                                fontSize: 12.rSp,
                              ),
                              verticalSpace(0.5.h),
                              myText(
                                title: AppString.level,
                                style: Style.extraSmall,
                                fontSize: 12.rSp,
                              ),
                              verticalSpace(0.5.h),
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
                      ),
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(50.w, 0, 0, 5.h),
                          child: SvgPicture.asset(
                            Assets.images.svg.client,
                            height: 20.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
