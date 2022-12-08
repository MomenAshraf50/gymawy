import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';
import 'package:gymawy/features/login/presentation/screens/forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: designApp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(30.h),
                    SvgPicture.asset(Assets.images.svg.icon),
                    verticalSpace(30.h),
                    Text(
                      AppString.welcome_gymawy,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(
                        fontFamily: 'splash',
                        fontWeight: FontWeight.w400,
                        fontSize: 30.h,
                      ),
                    ),
                    verticalSpace(30.h),
                    myTextFill(
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                        return null;
                      },
                      controller: emailController,
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
                      controller: passwordController,
                      hint: AppString.password,
                      isPassword: true,
                      svgImg: Assets.images.svg.lock,
                      suffixIcon: IconButton(icon: Icon(
                          loginCubit.visibilityShowPassword),
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
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                    verticalSpace(20.h),
                    myButton(
                        elevation: 0.0,
                        textOnly: false,
                        iconWidget: svgImage(
                          path: Assets.images.svg.login,
                          color: Colors.white,
                        ),
                        height: 0.09.rSp,
                        text: AppString.login,
                        onPressed: () {
                          // navigateAndFinish(context, const MainScreen());
                          // navigateTo(context, PinPage());
                        }),
                    verticalSpace(20.h),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              style: const TextStyle(
                                  color: ColorsManager.iconColor),
                              'ـ' * 50),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: const Text(AppString.oR)),
                          Text(
                              style: const TextStyle(
                                  color: ColorsManager.iconColor),
                              'ـ' * 50),
                        ],
                      ),
                    ),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // navigateTo(context, AddressPage());
                          },
                          child: svgImage(
                            path: Assets.images.svg.facebbokBorder,
                          ),
                        ),
                        horizontalSpace(20.w),
                        svgImage(
                          path: Assets.images.svg.google,
                        ),
                      ],
                    ),
                    verticalSpace(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppString.dont_have_account,
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall!),
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
                                    .displaySmall!
                                    .copyWith(
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
                                  fontWeight: FontWeight.bold,
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
