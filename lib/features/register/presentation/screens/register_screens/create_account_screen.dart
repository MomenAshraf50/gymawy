import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

import '../../../../../core/util/widgets/default dialog.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../../../login/presentation/screens/login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  bool isMoneyEmpty = false;
  static const List<String> currency = [
    'EGP',
    // 'SAR',
    'USD',
    // 'EUR',
  ];
  static const List<String> gender = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return HideKeyboardPage(
      child: Padding(
        padding: designApp,
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState)
            {
              navigateAndFinish(context, LoginScreen());

              // registerCubit.nextPage(
              //   true,
              //   context,
              // );

              designToastDialog(context: context, toast: TOAST.success,text: 'Account created Successfully');
              debugPrintFullText(state.token);
            }
            else if (state is RegisterErrorState){
              debugPrintFullText(state.failure);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
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
                            ? svgImage(
                                path: Assets.images.svg.group2584,
                                height: 16.h,
                                width: 16.w)
                            : CircleAvatar(
                                radius: 70.rSp,
                                backgroundImage:
                                    FileImage(registerCubit.imageFile!),
                              ),
                        defaultActionButton(
                            backgroundColor: ColorsManager.mainColor,
                            icon: Icons.add,
                            onPressed: () {
                              registerCubit.selectImage(context);
                            }),
                      ],
                    ),
                    verticalSpace(5.h),
                    DefaultTextField(
                      svgImg: Assets.images.svg.user,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                        return null;
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
                              return null;
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
                              return null;
                            },
                            controller: registerCubit.userLastNameController,
                            hint: AppString.lastName,
                          ),
                        ),
                      ],
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
                        return null;
                      },
                      controller: registerCubit.emailController,
                      hint: AppString.email,
                    ),


                    Row(
                      children: [
                        SvgPicture.asset(Assets.images.svg.age,width: 5.w, height: 3.h,),
                        horizontalSpace(5.w),
                        Expanded(
                          child: DefaultTextField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'isEmpty';
                              }
                              return null;
                            },
                            controller: registerCubit.userAgeYearController,
                            hint: 'Year',
                            type: TextInputType.number,
                          ),
                        ),
                        horizontalSpace(5.w),
                        Expanded(
                          child: DefaultTextField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'isEmpty';
                              }
                              return null;
                            },
                            controller: registerCubit.userAgeMonthController,
                            hint: 'Month',
                            type: TextInputType.number,
                          ),
                        ),
                        horizontalSpace(5.w),
                        Expanded(
                          child: DefaultTextField(
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'isEmpty';
                              }
                              return null;
                            },
                            controller: registerCubit.userAgeDayController,
                            hint: 'Day',
                            type: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    CustomDropdown(
                      fillColor: ColorsManager.textFieldColor,
                      hintText: AppString.choose_gender,
                      hintStyle: const TextStyle(
                          fontFamily: 'english',
                          color: Colors.black),
                      selectedStyle:
                      Theme.of(context).textTheme.displaySmall,
                      listItemStyle: const TextStyle(
                          fontFamily: 'english',
                          color: Colors.black),
                      items: gender,
                      controller: registerCubit.genderController,
                      excludeSelected: false,
                    ),
                    verticalSpace(2.h),

                    DefaultTextField(
                      svgImg: Assets.images.svg.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'isEmpty';
                        }
                        return null;
                      },
                      controller: registerCubit.phoneController,
                      hint: AppString.phone,
                      type: TextInputType.number,
                    ),

                    Row(
                      children: [
                        if (countryRegister == null ||
                            countryRegister == '')
                          Expanded(
                            child: CustomDropdown.search(
                              hintText: AppString.select_country,
                              items: registerCubit.listCountry,
                              hintStyle: const TextStyle(
                                  fontFamily: 'english',
                                  color: Colors.black),
                              listItemStyle: const TextStyle(
                                  fontFamily: 'english',
                                  color: Colors.black),
                              selectedStyle: const TextStyle(
                                  fontFamily: 'english',
                                  color: Colors.black),
                              controller:
                              registerCubit.countryController,
                              onChanged: (value) {
                                registerCubit.changeCity = false;
                                registerCubit.getCities(value);
                              },
                            ),
                          ),
                        if (countryRegister != null &&
                            countryRegister != '')
                          Expanded(
                              child: DefaultText(
                                  title:
                                  '$countryRegister - $governmentRegister - $cityRegister',
                                  style: Style.extraSmall)),
                        DefaultIconButton(
                            icon: const Icon(
                                Icons.add_location_alt_outlined),
                            onPressed: () {
                              registerCubit.getPermission();
                              if (registerCubit
                                  .locationPermission &&
                                  registerCubit
                                      .locationServiceEnabled) {
                                registerCubit
                                    .getLocation()
                                    .then((value) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return DefaultDialog(
                                        message:
                                        'This is your Location $countryRegister - $governmentRegister - $cityRegister ',
                                        pushButtonText: 'Yes',
                                        height: 22.h,
                                        pushButtonVoidCallback: () {
                                          Navigator.pop(context);
                                        },
                                      );
                                    },
                                  );
                                });
                              } else {
                                designToastDialog(
                                    context: context,
                                    toast: TOAST.warning,
                                    text:
                                    'Please enable Location Service or allow Location Permission');
                              }
                            }),
                      ],
                    ),
                    verticalSpace(1.h),
                    if (registerCubit.listCity.isNotEmpty)
                      CustomDropdown.search(
                        hintText: AppString.select_city,
                        hintStyle: const TextStyle(
                            fontFamily: 'english',
                            color: Colors.black),
                        selectedStyle: const TextStyle(
                            fontFamily: 'english',
                            color: Colors.black),
                        listItemStyle: const TextStyle(
                            fontFamily: 'english',
                            color: Colors.black),
                        items: registerCubit.listCity,
                        controller: registerCubit.cityController,
                        onChanged: (value) {
                          registerCubit.changeCity = true;
                        },
                      ),
                    verticalSpace(2.h),
                    if (registerCubit.isCoach)
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DefaultTextField(
                              svgImg: Assets
                                  .images.svg.dollarSignSvgrepoCom,
                              controller:
                              registerCubit.pricePerMonth,
                              hint: AppString.price_of_month,
                              type: TextInputType.number,
                              onChanged: (value) {
                                if (value!.isEmpty) {
                                  isMoneyEmpty = registerCubit
                                      .changeMoney(true);
                                } else {
                                  isMoneyEmpty = registerCubit
                                      .changeMoney(false);
                                }
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                                return null;
                              },
                            ),
                          ),
                          horizontalSpace(3.w),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 5.w,
                              height: 5.h,
                              margin:
                              const EdgeInsets.only(bottom: 16),
                              child: CustomDropdown(
                                hintText: 'EGP',
                                hintStyle: const TextStyle(
                                    fontFamily: 'english',
                                    color: Colors.black),
                                listItemStyle: const TextStyle(
                                    fontFamily: 'english',
                                    color: Colors.black),
                                fillColor: ColorsManager.textFieldColor,
                                items: currency,
                                controller: registerCubit.currencyController,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if(registerCubit.isCoach)
                      DefaultTextField(
                        controller:
                        registerCubit.experienceController,
                        hint: AppString.experience,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'isEmpty';
                          }
                          return null;
                        },
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
                          return null;
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
                          return null;
                        },
                        onChanged: (val) {
                          registerCubit.matchPassword();
                        },
                        controller: registerCubit.confirmPasswordController,
                        hint: AppString.confirm_password),





                    Visibility(
                      visible:
                          registerCubit.passwordController.text.isNotEmpty &&
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
                                      message:
                                          "Contains one special character"),
                                ),
                                Container(
                                  child: validationRow(
                                      condition: registerCubit
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
                      visible: registerCubit
                              .confirmPasswordController.text.isNotEmpty &&
                          !registerCubit.isPasswordMach(),
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
                                      condition:
                                          registerCubit.isPasswordNotMach,
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
                        text: AppString.create,
                        onPressed: () {
                          if(registerCubit.imageFile != null){
                            if (formKey.currentState!.validate()) {


                              if (registerCubit.isPasswordValid()) {

                                registerCubit.isCoach ?
                                registerCubit.registerClient(
                                  email: registerCubit.emailController.text,
                                  password: registerCubit.passwordController.text,
                                  experience: int.parse(registerCubit.experienceController.text),
                                  age: '${registerCubit.userAgeYearController.text}-${registerCubit.userAgeMonthController.text}-${registerCubit.userAgeDayController.text}',
                                  confirmPassword: registerCubit.confirmPasswordController.text,
                                  firstName: registerCubit.userFirstNameController.text,
                                  lastName: registerCubit.userLastNameController.text,
                                  phoneNumber: registerCubit.phoneController.text,
                                  profilePicture: registerCubit.imageFile!,
                                  userName: registerCubit.userNameController.text,
                                  fixedPrice: int.parse(registerCubit.pricePerMonth.text),
                                  gander: registerCubit.genderController.text,
                                  country: registerCubit.countryController.text,
                                  city: registerCubit.cityController.text,
                                ) :
                                registerCubit.registerClient(
                                  email: registerCubit.emailController.text,
                                  password: registerCubit.passwordController.text,
                                  age: '${registerCubit.userAgeYearController.text}-${registerCubit.userAgeMonthController.text}-${registerCubit.userAgeDayController.text}',
                                  confirmPassword: registerCubit.confirmPasswordController.text,
                                  firstName: registerCubit.userFirstNameController.text,
                                  lastName: registerCubit.userLastNameController.text,
                                  phoneNumber: registerCubit.phoneController.text,
                                  profilePicture: registerCubit.imageFile!,
                                  userName: registerCubit.userNameController.text,
                                  gander: registerCubit.genderController.text,
                                  country: registerCubit.countryController.text,
                                  city: registerCubit.cityController.text,
                                );



                                // userPicRegister = registerCubit.imageFile;
                                // userNameRegister = registerCubit.userNameController.text;
                                // firstNameRegister = registerCubit.userFirstNameController.text;
                                // lastNameRegister = registerCubit.userLastNameController.text;
                                // fullNameRegister = '${registerCubit.userFirstNameController.text} ${registerCubit.userLastNameController.text}';
                                // ageRegister = '${registerCubit.userAgeYearController.text}-${registerCubit.userAgeMonthController.text}-${registerCubit.userAgeDayController.text}';
                                // emailRegister = registerCubit.emailController.text;
                                // phoneRegister = registerCubit.phoneController.text;
                                // passwordRegister = registerCubit.passwordController.text;
                                // confirmPasswordRegister = registerCubit.confirmPasswordController.text;
                                // bio = registerCubit.bioController.text;
                              } else {
                                designToastDialog(
                                    context: context,
                                    toast: TOAST.error,
                                    text: 'Please complete your data');
                              }
                            }
                          }else {
                            designToastDialog(context: context, toast: TOAST.warning,text: 'Please select profile picture');
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
