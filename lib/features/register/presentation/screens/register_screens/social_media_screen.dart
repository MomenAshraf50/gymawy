import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/login/presentation/screens/login_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
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
          designToastDialog(context: context, toast: TOAST.success,text: 'Account created Successfully');
          debugPrintFullText(state.token);
          userPicRegister = null;
          genderRegister = '';
          countryRegister = '';
          governmentRegister = '';
          userNameRegister = '';
          firstNameRegister = '';
          lastNameRegister = '';
          fullNameRegister = '';
          ageRegister = '';
          emailRegister = '';
          bio = '';
          phoneRegister = '';
          passwordRegister = '';
          confirmPasswordRegister = '';
          fixedPriceRegister = 0;
          experienceRegister = 0;
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
        return state is RegisterLoadingState?const LoadingPage(): HideKeyboardPage(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: designApp,
              child: Column(
                children: [
                  verticalSpace(4.h),
                  Lottie.asset(Assets.images.lotti.social),
                  verticalSpace(4.h),
                  DefaultTextField(
                    controller: registerCubit.facebookController,
                    hint: AppString.facebook,
                    svgImg: Assets.images.svg.facebook,
                  ),
                  verticalSpace(1.h),
                  DefaultTextField(
                    controller: registerCubit.instagramController,
                    hint: AppString.instagram,
                    svgImg: Assets.images.svg.instagramSvgrepoCom,
                  ),
                  verticalSpace(1.h),
                  DefaultTextField(
                    controller: registerCubit.youtubeController,
                    hint: AppString.youTube,
                    svgImg: Assets.images.svg.youtubeSvgrepoCom,
                  ),
                  verticalSpace(1.h),
                  DefaultTextField(
                    controller: registerCubit.tiktokController,
                    hint: AppString.tiktok,
                    svgImg: Assets.images.svg.tiktok,
                  ),
                  verticalSpace(2.h),
                  DefaultButton(
                    elevation: 0.0,
                    textOnly: true,
                    color: ColorsManager.mainColor,
                    height: 3.h,
                    text: AppString.create,
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
                        experience: experienceRegister!,
                        bio: bio!,
                        age: ageRegister!,
                        city: cityRegister!,
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
                      // registerCubit.registerCoach(
                      //     email: emailRegister!,
                      //     password: passwordRegister!,
                      //     bio: '',
                      //     city: '',
                      //     confirmPassword: confirmPasswordRegister!,
                      //     country: countryRegister!,
                      //     firstName: firstNameRegister!,
                      //     fullName: fullNameRegister!,
                      //     gander: genderRegister!,
                      //     governorate: governmentRegister!,
                      //     lastName: lastNameRegister!,
                      //     phoneNumber: phoneRegister!,
                      //     profilePicture: userPicRegister!,
                      //     userName: userNameRegister!,
                      //     facebookLink: facebookLinkRegister!,
                      //     instagramLink: instagramLinkRegister!,
                      //     youtubeLink: youtubeLinkRegister!,
                      //     tiktokLink: tiktokLinkRegister!,
                      //     fixedPrice: fixedPriceRegister!
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
