import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myElevatedButton.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/register_cubit.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: designApp,
        child: Column(
          children: [
            verticalSpace(4.h),
            Lottie.asset(Assets.images.lotti.social),
            verticalSpace(4.h),
            myTextFill(
              controller: registerCubit.facebookController,
              hint: AppString.facebook,
              svgImg: Assets.images.svg.facebook,),
            verticalSpace(1.h),

            myTextFill(
              controller: registerCubit.instagramController,
              hint: AppString.instagram,
              svgImg: Assets.images.svg.instagramSvgrepoCom,),
            verticalSpace(1.h),

            myTextFill(
              controller: registerCubit.youtubeController,
              hint: AppString.youTube,
              svgImg: Assets.images.svg.youtubeSvgrepoCom,),
            verticalSpace(2.h),
            myButton(
              elevation: 0.0,
              textOnly: true,
              color: ColorsManager.mainColor,
              height: 3.h,
              text: AppString.next,
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
