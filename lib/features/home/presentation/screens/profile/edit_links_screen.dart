import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myElevatedButton.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';

class EditLinksScreen extends StatelessWidget {
  const EditLinksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: DefaultBackButton(function: () {
                        Navigator.pop(context);
                      }),
                    ),
                    horizontalSpace(20),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: SvgPicture.asset(
                        Assets.images.svg.social,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                ),
              ),
              myElevatedButton(text: AppString.finish, onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
