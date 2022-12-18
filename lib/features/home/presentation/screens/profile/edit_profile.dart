import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/cubit/state.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);

    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return HideKeyboardPage(
              child: Padding(
                padding: EdgeInsets.all(20.0.rSp),
                child: Column(
                  children: [
                    defaultAppBar(
                        title: AppString.editYourProfile, context: context),
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              myTextFill(
                                controller: homeCubit.usernameController,
                                hint: AppString.userName,
                                svgImg: Assets.images.svg.user,
                              ),
                              myTextFill(
                                controller: homeCubit.fullNameController,
                                hint: AppString.fullName,
                                svgImg: Assets.images.svg.user,
                              ),
                              myTextFill(
                                controller: homeCubit.emailController,
                                hint: AppString.email,
                                svgImg: Assets.images.svg.email,
                                type: TextInputType.emailAddress,
                              ),
                              myTextFill(
                                controller: homeCubit.phoneController,
                                hint: AppString.phone,
                                svgImg: Assets.images.svg.phone,
                                type: TextInputType.phone,
                              ),
                              myTextFill(
                                controller: homeCubit.passwordController,
                                hint: AppString.password,
                                svgImg: Assets.images.svg.lock,
                                type: TextInputType.visiblePassword,
                                isPassword: appBloc.showPassword,
                                suffixIcon: IconButton(onPressed:(){
                                  appBloc.changePasswordVisibility();
                                }, icon: Icon(appBloc.visibilityShowPassword)),
                              ),
                              myTextFill(
                                controller: homeCubit.confirmPasswordController,
                                hint: AppString.confirm_password,
                                svgImg: Assets.images.svg.lock,
                                type: TextInputType.visiblePassword,
                                isPassword: appBloc.showConfirmPassword,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                      appBloc.visibilityShowConfirmPassword),
                                  onPressed: () {
                                    appBloc.changeConfirmPasswordVisibility();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    myButton(text: AppString.finish, onPressed: () {})
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
