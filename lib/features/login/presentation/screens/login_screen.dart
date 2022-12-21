import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/cubit/state.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/presentation/screens/not_defiend/exercise_example.dart';
import 'package:gymawy/features/home/presentation/screens/not_defiend/meal_schedule.dart';
import 'package:gymawy/features/login/presentation/screens/forget_password_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/choose_your_type_screen.dart';

import '../../../home/presentation/screens/home_layout.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        //LoginCubit loginCubit = LoginCubit.get(context);
        AppBloc appBloc = AppBloc.get(context);
        return Scaffold(
          body: HideKeyboardPage(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: IconButton(
                            //     onPressed: ()
                            //     {
                            //       // if(AppBloc.get(context).isArabic == false)
                            //       // {
                            //       //   AppBloc.get(context).changeLanguage(code: 'en');
                            //       // }
                            //       // if(AppBloc.get(context).isArabic == true)
                            //       // {
                            //       //   AppBloc.get(context).changeLanguage(code: 'ar');
                            //       // }
                            //     },
                            //     icon: const Icon(
                            //       Icons.language_outlined,
                            //       color: ColorsManager.mainColor,
                            //     ),
                            //   ),
                            // ),
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
                              isPassword: false,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                                return null;
                              },
                              controller: appBloc.emailController,
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
                              controller: appBloc.passwordController,
                              hint: AppString.password,
                              isPassword: true,
                              svgImg: Assets.images.svg.lock,
                              suffixIcon: IconButton(
                                icon: Icon(appBloc.visibilityShowPassword),
                                onPressed: (){
                                  appBloc.changePasswordVisibility();
                                },
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    navigateTo(context, const ForgetPasswordScreen());
                                  },
                                  child: myText(title: AppString.forget_password, style: Style.extraSmall,fontSize: 15.rSp,)),
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
                                  navigateAndFinish(context, MainScreen());
                                  //navigateAndFinish(context, WorkoutTrackerScreen());
                                  //navigateAndFinish(context, const MealScheduleScreen());
                                   //navigateTo(context, PinPage());
                                   navigateTo(context, const ExerciseExampleScreen());

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
                                      child: const myText(title:AppString.oR,style: Style.extraSmall,)),
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
                                const myText(title: AppString.dont_have_account, style: Style.extraSmall),
                                // space10Horizontal,
                                TextButton(
                                    onPressed: () {
                                      registerCubit.changePage(0,context);
                                      navigateTo(context,  const ChooseYourTypeScreen());
                                    },
                                    child: const myText(title: AppString.signUp, style: Style.extraSmall,color: ColorsManager.mainColor,fontWeight: FontWeight.w600,),
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
          ),
        );
      },
    );
  }
}
