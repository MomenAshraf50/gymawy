import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/network/local/cache_helper.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/cubit/state.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/presentation/screens/home_layout.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';
import 'package:gymawy/features/login/presentation/screens/forget_password_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/choose_your_type_screen.dart';
import '../../../../core/di/injection.dart';
import '../../../home/presentation/controller/home_cubit.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {});

    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            sl<CacheHelper>().put('token', state.loginEntity.token);
            sl<CacheHelper>().put('userId', state.loginEntity.userId);
            sl<CacheHelper>().put('isCoach', state.loginEntity.isTrainer);
            sl<CacheHelper>().put('email', state.loginEntity.email);

            userId = state.loginEntity.userId;
            token = state.loginEntity.token;
            isCoachLogin = state.loginEntity.isTrainer;
            homeCubit.profile(id: state.loginEntity.userId);
            navigateAndFinish(context, const MainScreen());
            debugPrintFullText(token!);
            homeCubit.notificationsSubscription(NotificationsSubscriptionParams(
                deviceToken: deviceToken!, userLoggedIn: true));
          }
          if (state is LoginErrorState) {
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
        },
        builder: (context, state) {
          LoginCubit loginCubit = LoginCubit.get(context);
          AppBloc appBloc = AppBloc.get(context);
          return state is LoginLoadingState
              ? const LoadingPage()
              : HideKeyboardPage(
            child: SafeArea(
              child: Form(
                key: formKey,
                child: HideKeyboardPage(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Padding(
                        padding: designApp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(Assets.images.svg.icon),
                            verticalSpace(5.h),
                            Text(
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
                            DefaultTextField(
                              isPassword: false,
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
                            BlocBuilder<AppBloc, AppState>(
                              builder: (context, state) {
                                return DefaultTextField(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  hint: AppString.password,
                                  isPassword: appBloc.showPassword,
                                  svgImg: Assets.images.svg.lock,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        appBloc.visibilityShowPassword),
                                    onPressed: () {
                                      debugPrintFullText(appBloc.showPassword
                                          .toString());
                                      appBloc.changePasswordVisibility();
                                    },
                                  ),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    navigateTo(context,
                                        const ForgetPasswordScreen());
                                  },
                                  child: DefaultText(
                                    title: AppString.forget_password,
                                    style: Style.extraSmall,
                                    fontSize: 15.rSp,
                                  )),
                            ),
                            verticalSpace(2.h),
                            DefaultButton(
                                elevation: 0.0,
                                textOnly: false,
                                iconWidget: svgImage(
                                  path: Assets.images.svg.login,
                                  color: ColorsManager.white,
                                ),
                                color: ColorsManager.mainColor,
                                height: 3.h,
                                text: AppString.login,
                                onPressed: () async {
                                  if (formKey.currentState!
                                      .validate()) {
                                    loginCubit.logIn(
                                        email: emailController.text,
                                        password:
                                        passwordController.text);
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: 'please fill ur data');
                                  }
                                }),
                            verticalSpace(4.h),
                            SizedBox(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 0.1.h,
                                      color: ColorsManager.darkGrey,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: const DefaultText(
                                        title: AppString.oR,
                                        style: Style.extraSmall,
                                      )),
                                  Expanded(
                                    child: Container(
                                      height: 0.1.h,
                                      color: ColorsManager.darkGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(2.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                svgImage(
                                  path: Assets
                                      .images.svg.facebbokBorder,
                                ),
                                horizontalSpace(20.w),
                                svgImage(
                                  path: Assets.images.svg.google,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                const DefaultText(
                                    title:
                                    AppString.dont_have_account,
                                    style: Style.extraSmall),
                                // space10Horizontal,
                                TextButton(
                                  onPressed: () {
                                    registerCubit.changePage(
                                        0, context);
                                    navigateTo(context,
                                        const ChooseYourTypeScreen());
                                  },
                                  child: const DefaultText(
                                    title: AppString.signUp,
                                    style: Style.extraSmall,
                                    color: ColorsManager.mainColor,
                                    fontWeight: FontWeight.w600,
                                  ),
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
            ),
          );
        },
      ),
    );
  }
}
