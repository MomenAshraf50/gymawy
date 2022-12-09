import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';
import 'package:gymawy/features/login/presentation/screens/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSizes.screenHeight = MediaQuery.of(context).size.height;
    ScreenSizes.screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);
        return Scaffold(
          body: Form(
            key: formKey,
            child: HideKeyboardPage(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Padding(
                    padding: designApp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: ()
                            {
                              if(AppBloc.get(context).isArabic == false)
                              {
                                AppBloc.get(context).changeLanguage(code: 'en');
                              }
                              if(AppBloc.get(context).isArabic == true)
                              {
                                AppBloc.get(context).changeLanguage(code: 'ar');
                              }
                            },
                            icon: const Icon(
                              Icons.language_outlined,
                              color: ColorsManager.mainColor,
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                            Assets.images.svg.icon
                        ),
                        verticalSpace(5.h),
                        Text(
                           // 'appTranslation().gymawy',
                          AppString.welcome_gymawy,
                          style: Theme
                              .of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                            fontFamily: 'splash',
                            fontWeight: FontWeight.w400,
                            fontSize: 30.rSp,
                          ),
                        ),
                        verticalSpace(5.h),
                        myTextFill(
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                            return null;
                          },
                          controller: loginCubit.emailController,
                          hint: AppString.email,
                          svgImg: Assets.images.svg.email,
                        ),
                        myTextFill(
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'isEmpty';
                            }
                            return null;
                          },
                          controller: loginCubit.passwordController,
                          hint: AppString.password,
                          isPassword: loginCubit.showPassword,
                          svgImg: Assets.images.svg.lock,
                          suffixIcon: IconButton(icon: Icon(
                              loginCubit.visibilityShowPassword,
                              color: ColorsManager.iconColor
                          ),
                            onPressed: () {
                              loginCubit.changePasswordVisibility();
                            },
                          ),

                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {
                                navigateTo(context, const ForgetPasswordScreen());
                              },
                              child: Text(AppString.forget_password,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'poppins',
                                    fontSize: 15.rSp
                                  ))),
                        ),
                        verticalSpace(2.h),
                        myButton(
                            elevation: 0.0,
                            textOnly: false,
                            iconWidget: svgImage(
                              path: Assets.images.svg.login,
                              color: ColorsManager.white,
                            ),
                            color: ColorsManager.mainColor,
                            height: 3.h,
                            text: AppString.login,
                            textStyle: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: 30.rSp,
                              color: ColorsManager.white
                            ),
                            onPressed: () {
                              if(formKey.currentState!.validate())
                              {
                                debugPrintFullText('validate success');
                              }
                              else
                              {
                                designToastDialog(
                                    context: context,
                                    toast: TOAST.warning,
                                    text: 'please fill ur data');
                              }
                              // navigateAndFinish(context, const MainScreen());
                              // navigateTo(context, PinPage());
                            }),
                        verticalSpace(5.h),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 0.1.h,
                                  color: ColorsManager.darkGrey,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: const Text(AppString.oR)),
                              Expanded(
                                child: Container(
                                  height: 0.1.h,
                                  color: ColorsManager.darkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            svgImage(
                              path: Assets.images.svg.facebbokBorder,
                            ),
                            horizontalSpace(20.w),
                            svgImage(
                              path: Assets.images.svg.google,
                            ),
                          ],
                        ),
                        verticalSpace(5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppString.dont_have_account,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displaySmall!.copyWith(
                                  fontSize: 15.rSp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'poppins'
                                )
                            ),
                            // space10Horizontal,
                            TextButton(
                                onPressed: () {
                                  // cubit.changePage(0,context);
                                  //navigateTo(context, const SelectTypePage());
                                },
                                child: Text(AppString.signUp,
                                    style: Theme
                                    .of(context)
                                    .textTheme
                                    .displaySmall!.copyWith(
                                    fontSize: 15.rSp,
                                    fontWeight: FontWeight.w700,
                                    color: ColorsManager.mainColor,
                                    fontFamily: 'poppins'
                                )
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
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
