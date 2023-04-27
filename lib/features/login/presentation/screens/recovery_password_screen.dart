import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/cubit/state.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/widgets/myButton.dart';

class RecoveryPasswordScreen extends StatelessWidget {
  const RecoveryPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();

    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return Scaffold(
          body: HideKeyboardPage(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: designApp,
                  child: Column(
                    children: [
                      defaultAppBar(
                          title: AppString.new_password, context: context),
                      verticalSpace(5.h),
                      const myText(
                        title: AppString.new_password_title,
                        style: Style.medium,
                        maxLines: 3,
                        align: TextAlign.center,
                      ),
                      verticalSpace(10.h),
                      DefaultTextField(
                        showSuffix: true,
                        svgImg: Assets.images.svg.lock,
                        controller: passwordController,
                        isPassword: appBloc.showPassword,
                        hint: AppString.password,
                        suffixIcon: IconButton(
                          icon: Icon(appBloc.visibilityShowPassword),
                          onPressed: () {
                            appBloc.changePasswordVisibility();
                          },
                        ),
                      ),
                      DefaultTextField(
                        svgImg: Assets.images.svg.lock,
                        controller: confirmPasswordController,
                        isPassword: appBloc.showConfirmPassword,
                        hint: AppString.confirm_password,
                        suffixIcon: IconButton(
                          icon: Icon(appBloc.visibilityShowConfirmPassword),
                          onPressed: () {
                            appBloc.changeConfirmPasswordVisibility();
                          },
                        ),
                        onChanged: (val) {},
                      ),
                      verticalSpace(20.h),
                      myButton(
                          elevation: 0.0,
                          textOnly: true,
                          color: ColorsManager.mainColor,
                          height: 3.h,
                          text: AppString.save,
                          onPressed: passwordController.text.isNotEmpty &&
                                  confirmPasswordController.text.isNotEmpty
                              ? null
                              : () {}),
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
