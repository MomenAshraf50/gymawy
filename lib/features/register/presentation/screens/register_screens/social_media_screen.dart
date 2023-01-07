import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/login/presentation/screens/login_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/register_cubit.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState)
        {
          navigateAndFinish(context, LoginScreen());
          debugPrintFullText(state.token);
          userPicRegister = null;
          genderRegister = '';
          bodyFatRegister = '';
          countryRegister = '';
          governmentRegister = '';
          userNameRegister = '';
          firstNameRegister = '';
          lastNameRegister = '';
          fullNameRegister = '';
          ageRegister = '';
          emailRegister = '';
          phoneRegister = '';
          passwordRegister = '';
          confirmPasswordRegister = '';
          currentTallRegister = 0;
          currentWeightRegister = 0;
          fixedPriceRegister = 0;
          facebookLinkRegister = '';
          instagramLinkRegister = '';
          youtubeLinkRegister = '';
          tiktokLinkRegister = '';
        }
        else if (state is RegisterErrorState){
          debugPrintFullText(state.failure);
          designToastDialog(
              context: context,
              toast: TOAST.error,
              text: state.failure
          );
        }
      },
      builder: (context, state) {
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
                  svgImg: Assets.images.svg.facebook,
                ),
                verticalSpace(1.h),
                myTextFill(
                  controller: registerCubit.instagramController,
                  hint: AppString.instagram,
                  svgImg: Assets.images.svg.instagramSvgrepoCom,
                ),
                verticalSpace(1.h),
                myTextFill(
                  controller: registerCubit.youtubeController,
                  hint: AppString.youTube,
                  svgImg: Assets.images.svg.youtubeSvgrepoCom,
                ),
                verticalSpace(1.h),
                myTextFill(
                  controller: registerCubit.tiktokController,
                  hint: AppString.tiktok,
                  svgImg: Assets.images.svg.tiktok,
                ),
                verticalSpace(2.h),
                myButton(
                  elevation: 0.0,
                  textOnly: true,
                  color: ColorsManager.mainColor,
                  height: 3.h,
                  text: AppString.next,
                  onPressed: () {
                    facebookLinkRegister =
                        registerCubit.facebookController.text;
                    instagramLinkRegister =
                        registerCubit.instagramController.text;
                    youtubeLinkRegister = registerCubit.youtubeController.text;
                    tiktokLinkRegister = registerCubit.tiktokController.text;
                    registerCubit.registerClient(
                      email: emailRegister!,
                      password: passwordRegister!,
                      bio: '',
                      city: '',
                      confirmPassword: confirmPasswordRegister!,
                      country: countryRegister!,
                      firstName: firstNameRegister!,
                      fullName: fullNameRegister!,
                      gander: genderRegister!,
                      governorate: governmentRegister!,
                      lastName: lastNameRegister!,
                      phoneNumber: phoneRegister!,
                      profilePicture: userPicRegister!,
                      userName: userNameRegister!,
                      fixedPrice: fixedPriceRegister!,
                      facebookLink: facebookLinkRegister!,
                      instagramLink: instagramLinkRegister!,
                      youTubeLink: youtubeLinkRegister!,
                      tikTokLink: tiktokLinkRegister!,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
