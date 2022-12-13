import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
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
                        height: 28.rSp,
                        width: 28.rSp,
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
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 251, 239, 233),
                          borderRadius: BorderRadius.circular(10.rSp),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0.rSp),
                          child: Row(
                            children:  [
                              CircleAvatar(
                                radius: 33.rSp,
                                backgroundImage: const NetworkImage(
                                  'https://scontent-hbe1-1.xx.fbcdn.net/v/t39.30808-6/238882960_1176013169492391_5072941271790244082_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=jbg7MdAH1BYAX9hvBtG&tn=Gfqn9JTXHm2lEL0j&_nc_ht=scontent-hbe1-1.xx&oh=00_AfAyStoSibMMjqEycQ6BwFJdCs_JNM8pgFlhOKqTO2KJqw&oe=63941FBE',

                                ),
                              ),
                              horizontalSpace(20.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppString.resultSearchName,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  verticalSpace(10.h),
                                  Text(
                                    AppString.resultSearchType,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                  verticalSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      horizontalSpace(20.w),
                                      Icon(
                                        Icons.location_on,
                                        size: 15.rSp,
                                      ),
                                      Text(
                                        AppString.resultSearchLocation,
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'poppins',
                                        ),
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
