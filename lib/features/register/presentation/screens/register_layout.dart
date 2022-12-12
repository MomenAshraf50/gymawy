import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterLayout extends StatelessWidget {
  const RegisterLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        RegisterCubit registerCubit = RegisterCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              prevPage: registerCubit.currentIndex <= 0 ? false : true,
              title: AppString.create_account,
              cubit: registerCubit,
              context: context),
          body: Column(
            children: [
              Expanded(child: SizedBox(
                height: 10.h,
                child: PageView.builder(
                  itemBuilder: (context, index) {
                    return registerCubit.isCoach ? registerCubit.pagesCoach[index] : registerCubit.pagesClint[index];
                  },
                  controller: registerCubit.pageController,
                  itemCount: registerCubit.isCoach ? registerCubit.pagesCoach.length : registerCubit.pagesClint.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    registerCubit.currentIndex = index;
                  },
                ),
              )),
              SizedBox(
                height: 3.h,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 10.h),
                  child: SmoothPageIndicator(
                    controller: registerCubit.pageController,
                    count: registerCubit.isCoach ? registerCubit.pagesCoach.length : registerCubit.pagesClint.length,
                    effect:const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotWidth: 10,
                      spacing: 5,
                      expansionFactor: 5,
                      dotHeight: 10,
                      activeDotColor:ColorsManager.mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
