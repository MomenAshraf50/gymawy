import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/register/presentation/widgets/creat_account_widgets.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../controller/home_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({
    Key? key,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.bio,
    this.price,
  }) : super(key: key);

  String userName;
  String firstName;
  String lastName;
  String email;
  String phone;
  double? price;
  String bio;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    homeCubit.usernameController.text = userName;
    homeCubit.firstNameController.text = firstName;
    homeCubit.lastNameController.text = lastName;
    homeCubit.phoneController.text = phone;
    homeCubit.emailController.text = email;
    if (isCoachLogin) {
      homeCubit.fixedPriceController.text = price!.toString();
    }
    homeCubit.bioController.text = bio;

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is UpdateSuccessState) {
          homeCubit.profile(id: homeCubit.profileResults!.userInformation.userId);
          Navigator.pop(context);
          designToastDialog(
              context: context, toast: TOAST.success, text: 'Profile Updated');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SafeArea(
            child: Scaffold(
              body: state is UpdateLoadingState
                  ? const LoadingPage()
                  : HideKeyboardPage(
                      child: Padding(
                        padding: EdgeInsets.all(20.0.rSp),
                        child: Column(
                          children: [
                            defaultAppBar(
                                title: AppString.editYourProfile,
                                context: context),
                            Expanded(
                              child: Center(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      DefaultTextField(
                                        controller:
                                            homeCubit.usernameController,
                                        hint: AppString.userName,
                                        svgImg: Assets.images.svg.user,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field can\'t be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: DefaultTextField(
                                              controller:
                                                  homeCubit.firstNameController,
                                              hint: AppString.firstName,
                                              svgImg: Assets.images.svg.user,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field can\'t be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          horizontalSpace(5.w),
                                          Expanded(
                                            child: DefaultTextField(
                                              controller:
                                                  homeCubit.lastNameController,
                                              hint: AppString.lastName,
                                              svgImg: Assets.images.svg.user,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field can\'t be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (isCoachLogin)
                                        DefaultTextField(
                                          controller:
                                              homeCubit.fixedPriceController,
                                          hint: AppString.price_of_month,
                                          svgImg: Assets
                                              .images.svg.dollarSignSvgrepoCom,
                                        ),
                                      DefaultTextField(
                                        controller: homeCubit.emailController,
                                        hint: AppString.email,
                                        svgImg: Assets.images.svg.email,
                                        type: TextInputType.emailAddress,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field can\'t be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      DefaultTextField(
                                        controller: homeCubit.bioController,
                                        hint: AppString.bio,
                                        svgImg: Assets.images.svg.user,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field can\'t be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      DefaultTextField(
                                        controller: homeCubit.phoneController,
                                        hint: AppString.phone,
                                        svgImg: Assets.images.svg.phone,
                                        type: TextInputType.phone,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field can\'t be empty';
                                          }
                                          return null;
                                        },
                                      ),
                                      DefaultTextField(
                                        controller:
                                            homeCubit.passwordController,
                                        hint: AppString.password,
                                        svgImg: Assets.images.svg.lock,
                                        type: TextInputType.visiblePassword,
                                        onChanged: (value) {
                                          homeCubit.onPasswordChanged(value!);
                                        },
                                        isPassword: appBloc.showPassword,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              appBloc
                                                  .changePasswordVisibility();
                                            },
                                            icon: Icon(appBloc
                                                .visibilityShowPassword)),
                                      ),
                                      DefaultTextField(
                                        controller:
                                            homeCubit.confirmPasswordController,
                                        hint: AppString.confirm_password,
                                        svgImg: Assets.images.svg.lock,
                                        type: TextInputType.visiblePassword,
                                        onChanged: (value) {
                                          homeCubit.matchPassword();
                                        },
                                        isPassword: appBloc.showConfirmPassword,
                                        suffixIcon: IconButton(
                                          icon: Icon(appBloc
                                              .visibilityShowConfirmPassword),
                                          onPressed: () {
                                            appBloc
                                                .changeConfirmPasswordVisibility();
                                          },
                                        ),
                                      ),
                                      Visibility(
                                        visible: homeCubit.passwordController
                                                .text.isNotEmpty &&
                                            !homeCubit.isPasswordValid(),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        10.0) //                 <--- border radius here
                                                    ),
                                                color: Colors.blue[50],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: validationRow(
                                                        condition: homeCubit
                                                            .isPasswordHasUpperAndLower,
                                                        message:
                                                            "Contains upper and lower case"),
                                                  ),
                                                  Container(
                                                    child: validationRow(
                                                        condition: homeCubit
                                                            .isPasswordHasSpecialCharacter,
                                                        message:
                                                            "Contains one special character"),
                                                  ),
                                                  Container(
                                                    child: validationRow(
                                                        condition: homeCubit
                                                            .isPasswordEightCharacters,
                                                        message:
                                                            "Contains at least 8 characters"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: homeCubit
                                                .confirmPasswordController
                                                .text
                                                .isNotEmpty &&
                                            !homeCubit.isPasswordMach(),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius
                                                        .all(
                                                    Radius.circular(
                                                        10.0) //                 <--- border radius here
                                                    ),
                                                color: Colors.blue[50],
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: validationRow(
                                                        condition: homeCubit
                                                            .isPasswordMatch,
                                                        message:
                                                            "password does not match"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      verticalSpace(2.h),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            myButton(
                                text: AppString.finish,
                                onPressed: () {
                                  debugPrintFullText(
                                      homeCubit.isPasswordMach().toString());
                                  if (formKey.currentState!.validate()) {
                                    if (homeCubit
                                            .passwordController.text.isEmpty &&
                                        homeCubit.confirmPasswordController.text
                                            .isEmpty) {
                                      homeCubit.updateProfile(
                                        userName:
                                            homeCubit.usernameController.text,
                                        email: homeCubit.emailController.text,
                                        phone: homeCubit.phoneController.text,
                                        firstName:
                                            homeCubit.firstNameController.text,
                                        lastName:
                                        homeCubit.lastNameController.text,
                                        fixedPrice: double.parse(homeCubit
                                            .fixedPriceController.text),
                                        bio: homeCubit.bioController.text,
                                      );
                                    } else if (homeCubit.isPasswordMach()) {
                                      homeCubit.updateProfile(
                                        userName:
                                            homeCubit.usernameController.text,
                                        email: homeCubit.emailController.text,
                                        password:
                                            homeCubit.passwordController.text,
                                        phone: homeCubit.phoneController.text,
                                        firstName:
                                            homeCubit.firstNameController.text,
                                        lastName:
                                        homeCubit.lastNameController.text,
                                        fixedPrice: double.parse(homeCubit
                                            .fixedPriceController.text),
                                        bio: homeCubit.bioController.text,
                                      );
                                    }
                                  }
                                })
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
