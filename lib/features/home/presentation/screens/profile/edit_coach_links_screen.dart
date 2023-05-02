import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';

import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../controller/home_cubit.dart';

class EditCoachLinksScreen extends StatelessWidget {
  EditCoachLinksScreen(
      {Key? key,
      required this.tiktokLink,
      required this.instagramLink,
      required this.facebookLink,
      required this.youtubeLink})
      : super(key: key);

  String youtubeLink;
  String facebookLink;
  String tiktokLink;
  String instagramLink;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.facebookLinkController.text = facebookLink;
    homeCubit.youtubeLinkController.text = youtubeLink;
    homeCubit.instagramLinkController.text = instagramLink;
    homeCubit.tiktokLinkController.text = tiktokLink;
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          homeCubit.profile(
              id: homeCubit.profileResults!.userInformation.userId);
          Navigator.pop(context);
          designToastDialog(
              context: context, toast: TOAST.success, text: 'Links Updated');
        }
        if(state is UpdateErrorState){
          designToastDialog(context: context, toast: TOAST.error,text: state.failure.toString());
        }
      },
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
                      state is UpdateLoadingState
                          ? const LoadingPage()
                          : Column(
                              children: [
                                DefaultTextField(
                                  controller: homeCubit.facebookLinkController,
                                  hint: AppString.facebookLink,
                                  svgImg: Assets.images.svg.facebook,
                                ),
                                DefaultTextField(
                                  controller: homeCubit.instagramLinkController,
                                  hint: AppString.instagramLink,
                                  svgImg: Assets.images.svg.instagramSvgrepoCom,
                                ),
                                DefaultTextField(
                                  controller: homeCubit.tiktokLinkController,
                                  hint: AppString.tiktokLink,
                                  svgImg: Assets.images.svg.tiktok_black,
                                ),
                                DefaultTextField(
                                  controller: homeCubit.youtubeLinkController,
                                  hint: AppString.youtubeLink,
                                  svgImg: Assets.images.svg.youtubeSvgrepoCom,
                                ),
                                DefaultButton(
                                    text: AppString.finish,
                                    onPressed: () {
                                      homeCubit.updateCoachSocialLinks(
                                        facebookLink:
                                        homeCubit.facebookLinkController.text,
                                        instagramLink: homeCubit.instagramLinkController.text,
                                        tiktokLink: homeCubit.tiktokLinkController.text,
                                        youtubeLink: homeCubit.youtubeLinkController.text,
                                      );
                                    }),
                              ],
                            ),
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
