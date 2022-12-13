import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../core/util/resources/appString.dart';
import '../controller/home_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
            body: homeCubit.widgets.elementAt(homeCubit.currentNavIndex),
            bottomNavigationBar: Container(
              height: 8.h,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(18.rSp),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black.withOpacity(.1),
                    )
                  ]
              ),
              margin: EdgeInsetsDirectional.only(bottom:20.rSp,start: 20.rSp,end: 20.rSp),
              child: SafeArea(
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[300]!,
                  gap: 2,
                  activeColor: const Color.fromARGB(255, 248, 96, 13),
                  iconSize: 30.rSp,
                  padding: EdgeInsets.symmetric( horizontal: 5.w),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[300]!,
                  color: Colors.black,
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: AppString.home,
                    ),
                    GButton(
                      icon: Icons.search,
                      text: AppString.searchMain,
                    ),
                    GButton(
                      icon: Icons.settings,
                      text: AppString.settings,
                    ),
                    GButton(
                      icon: Icons.person,
                      text: AppString.profile,
                    ),
                  ],
                  selectedIndex: homeCubit.currentNavIndex,
                  onTabChange: (index)
                  {
                    homeCubit.changeNavBottomScreens(index);
                  },
                ),
              ),
            )
        );
      },
    );
  }
}
