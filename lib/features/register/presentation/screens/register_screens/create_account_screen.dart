import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/widgets/creat_account_widgets.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return HideKeyboardPage(
      child: Padding(
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
                      const DefaultText(
                        title: AppString.hey_coach,
                        style: Style.small,
                        fontWeight: FontWeight.bold,
                      ),
                    const DefaultText(
                      title: AppString.create_your_account,
                      style: Style.small,
                      fontWeight: FontWeight.bold,
                    ),
                    verticalSpace(3.h),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        registerCubit.imageFile == null
                            ? svgImage(path: Assets.images.svg.group2584,height: 16.h,width: 16.w)
                            : CircleAvatar(
                                radius: 70.rSp,
                                backgroundImage:
                                    FileImage(registerCubit.imageFile!),
                              ),
                        defaultActionButton(
                          backgroundColor: ColorsManager.mainColor,
                          icon: Icons.add,
                          onPressed: (){
                            registerCubit.selectImage(context);
                          }
                        ),
                      ],
                    ),
                    verticalSpace(5.h),
                    DefaultTextField(
                        svgImg: Assets.images.svg.user,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'isEmpty';
                          }
                        },
                        controller: registerCubit.userNameController,
                        hint: AppString.userName,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: DefaultTextField(
                              svgImg: Assets.images.svg.user,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                              },
                              controller: registerCubit.userFirstNameController,
                              hint: AppString.firstName,
                          ),
                        ),
                        horizontalSpace(5.w),
                        Expanded(
                          child: DefaultTextField(
                              svgImg: Assets.images.svg.user,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                              },
                              controller: registerCubit.userLastNameController,
                              hint: AppString.lastName,
                          ),
                        ),
                      ],
                    ),
                    DefaultTextField(
                        svgImg: Assets.images.svg.age,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'isEmpty';
                          }
                        },
                        controller: registerCubit.userAgeController,
                        hint: AppString.userAge,
                        type: TextInputType.number,
                    ),

                    DefaultTextField(
                      svgImg: Assets.images.svg.email,
                      validate: (String? value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'email is required';
                        } else if (!emailValid) {
                          return 'Incorrect email format';
                        }
                      },
                      controller: registerCubit.emailController,
                      hint: AppString.email,
                    ),
                    DefaultTextField(
                      svgImg: Assets.images.svg.user,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                      },
                      controller: registerCubit.bioController,
                      hint: AppString.bio,
                    ),
                    DefaultTextField(
                        svgImg: Assets.images.svg.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'isEmpty';
                          }
                        },
                        controller: registerCubit.phoneController,
                        hint: AppString.phone,
                        type: TextInputType.number,
                    ),
                    DefaultTextField(
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
                    DefaultTextField(
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
                      visible: registerCubit.passwordController.text.isNotEmpty &&
                          !registerCubit.isPasswordValid(),
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
                                  Radius.circular(
                                      10.0) //                 <--- border radius here
                                  ),
                              color: Colors.blue[50],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: validationRow(
                                      condition: registerCubit
                                          .isPasswordHasUpperAndLower,
                                      message: "Contains upper and lower case"),
                                ),
                                Container(
                                  child: validationRow(
                                      condition: registerCubit
                                          .isPasswordHasSpecialCharacter,
                                      message: "Contains one special character"),
                                ),
                                Container(
                                  child: validationRow(
                                      condition:
                                          registerCubit.isPasswordEightCharacters,
                                      message: "Contains at least 8 characters"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !registerCubit.isPasswordMach(),
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
                                  Radius.circular(
                                      10.0) //                 <--- border radius here
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
                    verticalSpace(2.h),
                    DefaultButton(
                        elevation: 0.0,
                        color: ColorsManager.mainColor,
                        height: 3.h,
                        text: AppString.next,
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            if(registerCubit.imageFile != null && registerCubit.isPasswordValid()){
                              registerCubit.nextPage(true, context,);
                              userPicRegister= registerCubit.imageFile;
                              userNameRegister = registerCubit.userNameController.text;
                              firstNameRegister = registerCubit.userFirstNameController.text;
                              lastNameRegister = registerCubit.userLastNameController.text;
                              fullNameRegister = '${registerCubit.userFirstNameController.text} ${registerCubit.userLastNameController.text}';
                              ageRegister = registerCubit.userAgeController.text;
                              emailRegister = registerCubit.emailController.text;
                              phoneRegister = registerCubit.phoneController.text;
                              passwordRegister = registerCubit.passwordController.text;
                              confirmPasswordRegister = registerCubit.confirmPasswordController.text;
                              bio = registerCubit.bioController.text;
                            }else{
                              designToastDialog(
                                  context: context,
                                  toast: TOAST.error,
                                  text: 'Please complete your data'
                              );
                            }
                          }
                        }),
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
