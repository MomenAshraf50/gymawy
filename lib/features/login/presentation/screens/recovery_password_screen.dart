import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  const RecoveryPasswordScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();


    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {},
      builder: (context, state) {
        LoginCubit loginCubit = LoginCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(
              title: AppString.new_password, context: context),
          body: Center(
            child: Padding(
              padding: designApp,
              child: Column(
                children: [
                  verticalSpace(10.h),
                  const myText(
                    title: AppString.new_password_title,
                    style: Style.medium,
                    align: TextAlign.center,
                  ),
                  verticalSpace(30.h),
                  myTextFill(
                    isPassword: true,
                    svgImg: Assets.images.svg.lock,
                    controller: passwordController,
                    hint: AppString.password,
                    suffixIcon: IconButton(
                      icon: Icon(loginCubit.visibilityShowPassword),
                      onPressed: (){
                        loginCubit.changePasswordVisibility();
                      },
                    ),
                  ),
                  myTextFill(
                    isPassword: true,
                    svgImg: Assets.images.svg.lock,
                    controller: confirmPasswordController,
                    hint: AppString.confirm_password,
                    onChanged: (val) {},
                    suffixIcon: IconButton(
                      icon: Icon(loginCubit.visibilityShowConfirmPassword),
                      onPressed: (){
                        loginCubit.changeConfirmPasswordVisibility();
                      },
                    ),
                  ),
                  myElevatedButton(
                      text: AppString.save,
                      onPressed: () {})
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
