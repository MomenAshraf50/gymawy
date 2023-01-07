import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';

class EditCoachLinksScreen extends StatelessWidget {
  const EditCoachLinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: HideKeyboardPage(
              child: SingleChildScrollView(
                child: Padding(
                  padding: designApp,
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DefaultBackButton(function: () {
                            Navigator.pop(context);
                          }),
                          horizontalSpace(2.h),
                          SvgPicture.asset(
                            Assets.images.svg.social,
                          )
                        ],
                      ),
                      verticalSpace(3.h),
                      Column(
                        children: [
                          myTextFill(
                            controller: homeCubit.facebookLinkController,
                            hint: AppString.facebookLink,
                            svgImg: Assets.images.svg.facebook,
                          ),
                          myTextFill(
                            controller: homeCubit.instagramLinkController,
                            hint: AppString.instagramLink,
                            svgImg: Assets.images.svg.instagramSvgrepoCom,
                          ),
                          myTextFill(
                            controller: homeCubit.tiktokLinkController,
                            hint: AppString.tiktokLink,
                            svgImg: Assets.images.svg.tiktok_black,
                          ),
                          myTextFill(
                            controller: homeCubit.youtubeLinkController,
                            hint: AppString.youtubeLink,
                            svgImg: Assets.images.svg.youtubeSvgrepoCom,
                          ),
                        ],
                      ),
                      myButton(text: AppString.finish, onPressed: () {
                        homeCubit.updateCoachSocialLinks(
                          facebookLink: 'facebookLink',
                          instagramLink: 'instagramLink',
                          tiktokLink: 'tiktokLink',
                          youtubeLink: 'youtubeLink',
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
