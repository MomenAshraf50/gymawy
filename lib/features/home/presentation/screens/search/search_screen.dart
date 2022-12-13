import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: Column(
            children: [
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
                              fontSize: 14.rSp,
                              color: Colors.grey.shade400),
                      iconPrefix: Icons.search,
                    ),
                  ),
                  horizontalSpace(2.w),
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
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          homeCubit.changeToCoachRadioButton();
                                        },
                                        child: SizedBox(
                                          height: 3.h,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppString.coaches,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 1.h,
                                                width: 1.w,
                                                decoration: BoxDecoration(
                                                    color: homeCubit
                                                            .coachRadioButton
                                                        ? const Color.fromARGB(
                                                            255, 248, 96, 13)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      verticalSpace(1.h),
                                      Container(
                                        width: double.infinity,
                                        height: 1.h,
                                        color: Colors.grey.shade300,
                                      ),
                                      verticalSpace(1.h),
                                      InkWell(
                                        onTap: () {
                                          homeCubit.changeToClientRadioButton();
                                        },
                                        child: SizedBox(
                                          height: 3.h,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppString.clients,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(
                                                        fontFamily: 'poppins',
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              const Spacer(),
                                              Container(
                                                height: 1.h,
                                                width: 1.w,
                                                decoration: BoxDecoration(
                                                    color: homeCubit
                                                            .clientRadioButton
                                                        ? const Color.fromARGB(
                                                            255, 248, 96, 13)
                                                        : Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    border: Border.all(
                                                        color: Colors.grey)),
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
              verticalSpace(1.h),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
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
                                backgroundImage: const NetworkImage(
                                    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?w=740&t=st=1670936429~exp=1670937029~hmac=16901a75e36e3d716106b5589e760ec2c010ad9cd585cf47cf9e83d7790e939e'),
                              ),
                              horizontalSpace(2.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  myText(
                                    title: AppString.resultSearchName,
                                    style: Style.extraSmall,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.rSp,
                                  ),
                                  verticalSpace(0.5.h),
                                  myText(
                                    title: AppString.resultSearchType,
                                    style: Style.extraSmall,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.rSp,
                                  ),
                                  verticalSpace(0.5.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20.rSp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20.rSp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20.rSp,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20.rSp,
                                      ),
                                      horizontalSpace(4.w),
                                      Icon(
                                        Icons.location_on,
                                        size: 15.rSp,
                                      ),
                                      myText(
                                        title: AppString.resultSearchLocation,
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
                    );
                  },
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
