import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/widgets/creat_account_widgets.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountScreen extends StatelessWidget {
   CreateAccountScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit =RegisterCubit.get(context);
    return Padding(
      padding: designApp,
      child: BlocBuilder<RegisterCubit, RegisterStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (registerCubit.isCoach)
                    buildRichText(AppString.hey_coach,context),
                  Text(
                    AppString.create_your_account,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                  ),
                  verticalSpace(3.h),
                  GestureDetector(
                      onTap:(){
                        print('object');
                        registerCubit.selectImage(context);
                      },
                      child: registerCubit.imageFile == null ?
                      svgImage(path: Assets.images.svg.group2584) :
                      CircleAvatar(
                        radius: 100.rSp,
                        backgroundImage: FileImage(registerCubit.imageFile!),
                      )),

                  verticalSpace(5.h),
                  myTextFill(
                      svgImg: Assets.images.svg.user,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      controller: registerCubit.userNameController,
                      hint: AppString.userName),
                  myTextFill(
                      svgImg: Assets.images.svg.user,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      controller: registerCubit.fullNameController,
                      hint: AppString.fullName),
                  myTextFill(
                    svgImg: Assets.images.svg.email,
                    validate: (String? value) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                      if (value.isEmpty) {
                        return 'email is required';
                      } else if (!emailValid) {
                        return 'Incorrect email format';
                      }
                    },
                    controller: registerCubit.emailController,
                    hint: AppString.email,
                  ),
                  myTextFill(
                      svgImg: Assets.images.svg.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      controller: registerCubit.phoneController,
                      hint: AppString.phone),
                  myTextFill(
                      isPassword: true,
                      svgImg: Assets.images.svg.lock,
                      onChanged: (val) {
                          registerCubit.onPasswordChanged(val!);
                      },
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      controller: registerCubit.passwordController,
                      hint: AppString.password),
                  myTextFill(
                      isPassword: true,
                      svgImg: Assets.images.svg.lock,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      onChanged: (val) {
                          registerCubit.matchPassword();
                      },
                      controller: registerCubit.confirmPasswordController,
                      hint: AppString.confirm_password),
                  Visibility(
                    visible: registerCubit.passwordController.text.isNotEmpty && !registerCubit.isPasswordValid(),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0) //                 <--- border radius here
                            ),
                            color: Colors.blue[50],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: validationRow(
                                    condition: registerCubit.isPasswordHasUpperAndLower,
                                    message: "Contains upper and lower case"),
                              ),
                              Container(
                                child: validationRow(
                                    condition: registerCubit.isPasswordHasSpecialCharacter,
                                    message: "Contains one special character"),
                              ),
                              Container(
                                child: validationRow(
                                    condition: registerCubit.isPasswordEightCharacters,
                                    message: "Contains at least 8 characters"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: registerCubit.isPasswordMach(),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10.0) //                 <--- border radius here
                            ),
                            color: Colors.blue[50],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: validationRow(
                                    condition: registerCubit.isPasswordNotMach,
                                    message: "password does not match"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (value) {
                      registerCubit.changeRadioButton();
                    },
                    activeColor: ColorsManager.mainColor,
                    title: Text(
                      AppString.dont_have_account,
                      style: Theme
                          .of(context)
                          .textTheme
                          .displaySmall,),
                    value: registerCubit.isAccept,
                  ),
                  verticalSpace(2.h),
                  myButton(
                      elevation: 0.0,
                      color: ColorsManager.mainColor,
                      height: 3.h,
                      text: AppString.next,
                      textStyle: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w300,
                          fontSize: 30.rSp,
                          color: ColorsManager.white
                      ),
                    onPressed: (){
                        registerCubit.isAccept?  registerCubit.nextPage(true,context):null;
                         } ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
