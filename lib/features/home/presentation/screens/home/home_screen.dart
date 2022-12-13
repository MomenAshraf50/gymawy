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
                        width: 80,
                        height: 80,
                      ),
                      const Spacer(),
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          SvgPicture.asset(
                            Assets.images.svg.notifications,
                            width: 25.w,
                            height: 30.h,
                          ),
                          Container(
                            height: 17.h,
                            width: 20.w,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(7.rSp)
                            ),
                            child: Center(
                              child: Text(
                                  AppString.notificationsNum,
                                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.rSp,
                                      color: Colors.white
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  verticalSpace(10.h),
                  Text(
                    AppString.helloClient,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 23.rSp,
                    ),
                  ),
                  verticalSpace(10.h),
                  Text(
                    AppString.ready,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 10.rSp,
                    ),
                  ),
                  verticalSpace(10.h),
                  /// will change this raw
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: myTextFill(
                          controller: homeCubit.searchController,
                          hint: AppString.search,
                          hintStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 10.rSp,
                              color: Colors.grey.shade400
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 15.rSp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      horizontalSpace(10.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: InkWell(
                          child: SvgPicture.asset(
                            Assets.images.svg.filterSearch,
                            height: 28.h,
                            width: 28.w,
                          ),
                          onTap: ()
                          {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return BlocBuilder<HomeCubit,HomeStates>(
                                  builder: (context, state) {
                                    return AlertDialog(
                                      shape: BeveledRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      title: Column(
                                        children: [
                                          InkWell(
                                            onTap: ()
                                            {
                                              homeCubit.changeToCoachRadioButton();
                                            },
                                            child: SizedBox(
                                              height: 30.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppString.coaches,
                                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                        fontFamily: 'poppins',
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 10.h,
                                                    width: 10.w,
                                                    decoration: BoxDecoration(
                                                        color: homeCubit.coachRadioButton? const Color.fromARGB(255, 248, 96, 13) :
                                                        Colors.transparent,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: Colors.grey)
                                                    ),
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
                                            onTap: ()
                                            {
                                              homeCubit.changeToClientRadioButton();
                                            },
                                            child: SizedBox(
                                              height: 30.h,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    AppString.clients,
                                                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                                                        fontFamily: 'poppins',
                                                        fontWeight: FontWeight.w400
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 10.h,
                                                    width: 10.w,
                                                    decoration: BoxDecoration(
                                                        color: homeCubit.clientRadioButton? const Color.fromARGB(255, 248, 96, 13) :
                                                        Colors.transparent,
                                                        borderRadius: BorderRadius.circular(5),
                                                        border: Border.all(color: Colors.grey)
                                                    ),
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
                  verticalSpace(10.h),
                  Text(
                    AppString.suggestions,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.rSp,
                    ),
                  ),
                  verticalSpace(10.h),
                  SizedBox(
                    height: 220.h,
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
                          child: Container(
                            margin: EdgeInsets.all(9.rSp),
                            decoration: BoxDecoration(
                              boxShadow: [
                                // selected == index ?
                                BoxShadow(
                                  color: Theme.of(context).primaryColor,
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
                                    height: 150.h,
                                  ),
                                  verticalSpace(10.h),
                                  myText(
                                    title: homeCubit.listSuggestions[index].title,
                                    style:Style.small,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),

                                ],
                              ),
                            ),
                          ),
                          onTap: ()
                          {
                            // if(index == 0){
                            //   navigateTo(context, const PlansScreen());
                            // }else if (index == 1){
                            //   navigateTo(context, const ExercisesScreen());
                            // }else{}
                          },
                        );
                      },
                      itemCount:  homeCubit.listSuggestions.length ,
                    ),
                  ),
                  verticalSpace(10.h),
                  Text(
                    AppString.todaySession,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 16.rSp,
                    ),
                  ),
                  verticalSpace(10.h),
                  Text(
                    AppString.doNotMiss,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 6.rSp,
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.h,
                        decoration:  const BoxDecoration(
                          color: Color.fromARGB(255, 248, 96, 13),
                          borderRadius: BorderRadius.all(Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 7.h, 0, 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30.h,
                                width: 70.w,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 252, 183, 146),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Center(
                                  child: Text(
                                    AppString.daysNum,
                                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 9.rSp,
                                    ),
                                  ),
                                ),
                              ),
                              verticalSpace(10.h),
                              Text(
                                AppString.fullBodyExercise,
                                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.rSp,
                                ),
                              ),
                              verticalSpace(10.h),
                              Text(
                                AppString.level,
                                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 6.rSp,
                                ),
                              ),
                              verticalSpace(10.h),
                              Row(
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 252, 183, 146),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset( Assets.images.svg.clock),
                                          horizontalSpace(10.w),
                                          Text(
                                            AppString.clock,
                                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.rSp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(10.w),
                                  Container(
                                    height: 30.h,
                                    width: 70.w,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 252, 183, 146),
                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset( Assets.images.svg.fire),
                                          horizontalSpace(10.w),
                                          Text(
                                            AppString.cal,
                                            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 9.rSp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10.h),
                              InkWell(
                                child: Container(
                                  height: 30.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 0, 173, 199),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppString.startNow,
                                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.rSp,
                                          color: const Color.fromARGB(255, 255, 255, 255)
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: ()
                                {

                                },
                              ),
                            ],
                          ),
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            90.w,
                            0,
                            0,
                            20.h
                        ),
                        child: SvgPicture.asset(
                          Assets.images.svg.client_section,
                          height: 250,
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}
