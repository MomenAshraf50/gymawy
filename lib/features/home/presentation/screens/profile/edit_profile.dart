import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myElevatedButton.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/myTextFill.dart';
import '../../controller/home_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20.0.rSp),
          child: Column(
            children: [
              Row(
                children: [
                  DefaultBackButton(function: (){
                    Navigator.pop(context);
                  },),
                  horizontalSpace(1.h),
                  const myText(
                    title: AppString.editYourProfile,
                    style: Style.medium,
                    fontWeight: FontWeight.bold,
                  )
                ],
              ),
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
                          isPassword: true,
                          suffixIcon: const Icon(Icons.visibility),
                        ),
                        myTextFill(
                          controller: homeCubit.confirmPasswordController,
                          hint: AppString.confirm_password,
                          svgImg: Assets.images.svg.lock,
                          type: TextInputType.visiblePassword,
                          isPassword: true,
                          suffixIcon: const Icon(Icons.visibility),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              myButton(text: AppString.finish, onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
