import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/screens/home_layout.dart';
import 'package:gymawy/features/login/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2),() {
      navigateAndFinish(context, token != null ? const MainScreen() : LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {


    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: ScreenSizes.screenHeight,
            child: SvgPicture.asset(
              Assets.images.svg.background,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.images.svg.icon,
                  color: Colors.white,
                ),
                DefaultText(
                  title: AppString.gymAwy ,
                  style: Style.headLarge,
                  fontFamily: 'splash',
                  color: Colors.white,
                  fontSize: 100.rSp,
                ),
                verticalSpace(5.h),
                const DefaultText(
                  title: AppString.no_pain_no_gain ,
                  style: Style.medium,
                  fontFamily: 'splash',
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}
