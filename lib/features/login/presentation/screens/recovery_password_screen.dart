import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/widgets/myButton.dart';

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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: designApp,
                child: Column(
                  children: [
                    verticalSpace(5.h),
                    Row(
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            Assets.images.svg.arrow_back,
                          ),
                          onTap: ()
                          {
                            Navigator.pop(context);
                          },
                        ),
                        horizontalSpace(5.h),
                        const Expanded(
                          child: myText(
                            title: AppString.new_password,
                            style: Style.large,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w700,
                            align: TextAlign.center,
                          ),
                        ),

                      ],
                    ),
                    verticalSpace(5.h),
                    const myText(
                      title: AppString.new_password_title,
                      style: Style.medium,
                      align: TextAlign.center,
                    ),
                    verticalSpace(10.h),
                    myTextFill(
                      isPassword: loginCubit.showPassword,
                      svgImg: Assets.images.svg.lock,
                      controller: passwordController,
                      hint: AppString.password,
                      suffixIcon: IconButton(
                        icon: Icon(
                            loginCubit.visibilityShowPassword,
                            color: ColorsManager.iconColor,
                        ),
                        onPressed: (){
                          loginCubit.changePasswordVisibility();
                        },
                      ),
                    ),
                    myTextFill(
                      isPassword: loginCubit.showConfirmPassword,
                      svgImg: Assets.images.svg.lock,
                      controller: confirmPasswordController,
                      hint: AppString.confirm_password,
                      onChanged: (val) {},
                      suffixIcon: IconButton(
                        icon: Icon(
                            loginCubit.visibilityShowConfirmPassword
                        ),
                          color: ColorsManager.iconColor,
                          onPressed: (){
                          loginCubit.changeConfirmPasswordVisibility();
                        },
                      ),
                    ),
                    verticalSpace(20.h),
                    myButton(
                        elevation: 0.0,
                        textOnly: true,
                        color: ColorsManager.mainColor,
                        height: 3.h,
                        text: AppString.save,
                        textStyle: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w700,
                            fontSize: 30.rSp,
                            color: ColorsManager.white
                        ),
                        onPressed: passwordController.text.isNotEmpty &&  confirmPasswordController.text.isNotEmpty? null : ()
                        {

                        }),
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
