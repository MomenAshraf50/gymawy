import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/list_title_container.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/core/util/widgets/my_icon_button.dart';
import 'package:gymawy/features/login/presentation/screens/login_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({
    Key? key,
  }) : super(key: key);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  bool isMoneyEmpty = false;

  static const List<String> gender = [
    'Male',
    'Female',
  ];

  static const List<String> currency = [
    'EGP',
    // 'SAR',
    'USD',
    // 'EUR',
  ];

  @override
  Widget build(BuildContext context) {
    debugPrintFullText(emailRegister!);
    debugPrintFullText(passwordRegister!);
    debugPrintFullText(confirmPasswordRegister!);
    debugPrintFullText(ageRegister!);
    debugPrintFullText(firstNameRegister!);
    debugPrintFullText(fullNameRegister!);
    debugPrintFullText(lastNameRegister!);
    debugPrintFullText(phoneRegister!);
    debugPrintFullText(userPicRegister!.toString());
    debugPrintFullText(currentWeightRegister.toString());
    debugPrintFullText(currentTallRegister!.toString());

    RegisterCubit registerCubit = RegisterCubit.get(context);

    return FutureBuilder(
      future: registerCubit.readJson(context),
      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return const LoadingPage();
        }else{
          return BlocConsumer<RegisterCubit, RegisterStates>(
            listener: (context, state) {
              if(state is RegisterSuccessState){
                navigateAndFinish(context, LoginScreen());
                debugPrintFullText(state.token);
                userPicRegister = null;
                genderRegister = '';
                bio = '';
                countryRegister = '';
                governmentRegister = '';
                userNameRegister = '';
                firstNameRegister = '';
                lastNameRegister = '';
                fullNameRegister = '';
                ageRegister = '';
                emailRegister = '';
                phoneRegister = '';
                passwordRegister = '';
                confirmPasswordRegister = '';
              }
              if (state is RegisterErrorState){
                debugPrintFullText(state.failure);
                designToastDialog(
                    context: context,
                    toast: TOAST.error,
                    text: state.failure
                );
              }
            },
            builder: (context, state) {
              return state is RegisterLoadingState? const LoadingPage(): HideKeyboardPage(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Padding(
                        padding: designApp,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              svgImage(path: Assets.images.svg.couch,height: 25.h),
                              verticalSpace(2.h),
                              const myText(
                                  title: AppString.lets_complate, style: Style.large),
                              verticalSpace(2.h),
                              const myText(
                                  title: AppString.will_help, style: Style.small),
                              verticalSpace(2.h),
                              myListTitle(
                                onClick: () {
                                  showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext builder) {
                                        return Container(
                                          height: 5.h,
                                          color:
                                          Theme.of(context).scaffoldBackgroundColor,
                                          child: CupertinoDatePicker(
                                            mode: CupertinoDatePickerMode.date,
                                            onDateTimeChanged: (value) {
                                              registerCubit.dataOfBirth.text = registerCubit.changeDateFormat( value);
                                            },
                                            initialDateTime: DateTime.now(),
                                            minimumYear: 2000,
                                            maximumYear: 3000,
                                          ),
                                        );
                                      });
                                },
                                title: registerCubit.dataOfBirth.text.isEmpty
                                    ? AppString.date_of_brith
                                    : registerCubit.dataOfBirth.text,
                                svgImg: Assets.images.svg.date,
                              ),
                              verticalSpace(2.h),
                              if(registerCubit.isCoach)
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: myTextFill(
                                        svgImg: Assets.images.svg.dollarSignSvgrepoCom,
                                        controller: registerCubit.pricePerMonth,
                                        hint: AppString.price_of_month,
                                        type: TextInputType.number,
                                        onChanged: (value) {
                                          if (value!.isEmpty) {
                                            isMoneyEmpty = registerCubit.changeMoney(true);
                                          } else {
                                            isMoneyEmpty =registerCubit.changeMoney(false);
                                          }
                                        },
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'isEmpty';
                                          } else if (isInteger(int.parse(value))) {
                                            return 'isInteger';
                                          }
                                        },
                                      ),
                                    ),
                                    horizontalSpace(3.w),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        width: 5.w,
                                        height: 5.h,
                                        margin: const EdgeInsets.only(bottom: 16),
                                        child: CustomDropdown(
                                          hintText: 'EGP',
                                          hintStyle: const TextStyle(
                                              fontFamily: 'english',
                                              color: Colors.black
                                          ),
                                          listItemStyle: const TextStyle(
                                              fontFamily: 'english',
                                              color: Colors.black
                                          ),
                                          fillColor: ColorsManager.textFieldColor,
                                          items: currency,
                                          controller: registerCubit.currencyController,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              CustomDropdown(
                                fillColor: ColorsManager.textFieldColor,
                                hintText: AppString.choose_gender,
                                hintStyle: const TextStyle(
                                    fontFamily: 'english',
                                    color: Colors.black
                                ),
                                selectedStyle: Theme.of(context).textTheme.displaySmall,
                                listItemStyle: const TextStyle(
                                    fontFamily: 'english',
                                    color: Colors.black
                                ),
                                items: gender,
                                controller: registerCubit.genderController,
                                excludeSelected: false,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomDropdown.search(
                                      hintText: AppString.select_country,
                                      items: registerCubit.listCountry,
                                      hintStyle: const TextStyle(
                                          fontFamily: 'english',
                                          color: Colors.black
                                      ),
                                      listItemStyle: const TextStyle(
                                          fontFamily: 'english',
                                          color: Colors.black
                                      ),
                                      selectedStyle: const TextStyle(
                                          fontFamily: 'english',
                                          color: Colors.black
                                      ),
                                      controller: registerCubit.countryController,
                                      onChanged: (value) {
                                        registerCubit.changeCity = false;
                                        registerCubit.getCities(value);
                                      },
                                    ),
                                  ),
                                  DefaultIconButton(
                                      icon: const Icon(Icons.add_location_alt_outlined),
                                      onPressed: ()
                                      {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DefaultDialog(
                                              message: '$currentCountry - $currentCity - $currentGovernment ',
                                              pushButtonText: 'Okay',
                                              height: 22.h,
                                              pushButtonVoidCallback: (){
                                                countryRegister = currentCountry;
                                                governmentRegister = currentGovernment;
                                                cityRegister = currentCity;
                                                currentCountry != null && currentGovernment != null && currentCity != null?
                                                Navigator.pop(context) : null;
                                              },
                                            );
                                          },
                                        );
                                      }
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              if (registerCubit.listCity.isNotEmpty)
                                CustomDropdown.search(
                                  hintText: AppString.select_city,
                                  hintStyle: const TextStyle(
                                      fontFamily: 'english',
                                      color: Colors.black
                                  ),
                                  selectedStyle: const TextStyle(
                                      fontFamily: 'english',
                                      color: Colors.black
                                  ),
                                  listItemStyle: const TextStyle(
                                      fontFamily: 'english',
                                      color: Colors.black
                                  ),
                                  items: registerCubit.listCity,
                                  controller: registerCubit.cityController,
                                  onChanged: (value) {
                                    registerCubit.changeCity = true;
                                  },
                                ),
                              verticalSpace(2.h),
                              myButton(
                                  elevation: 0.0,
                                  iconWidget: svgImage(
                                    path: Assets.images.svg.login,
                                    color: ColorsManager.white,
                                  ),
                                  color: ColorsManager.mainColor,
                                  height: 3.h,
                                  text: isCoachRegister ? AppString.next:AppString.create,
                                  onPressed: () {
                                    genderRegister = registerCubit.genderController.text;
                                    if(registerCubit.isCoach){
                                      fixedPriceRegister =  int.parse(registerCubit.pricePerMonth.text);
                                    }
                                    if(!isCoachRegister){
                                      registerCubit.registerClient(
                                        email: emailRegister!,
                                        password: passwordRegister!,
                                        age: ageRegister!,
                                        bio: bio!,
                                        city: cityRegister!,
                                        confirmPassword: confirmPasswordRegister!,
                                        country: countryRegister!,
                                        firstName: firstNameRegister!,
                                        fullName: fullNameRegister!,
                                        gander: genderRegister!,
                                        governorate: governmentRegister!,
                                        lastName: lastNameRegister!,
                                        phoneNumber: phoneRegister!,
                                        profilePicture: userPicRegister!,
                                        userName: userNameRegister!,
                                      );
                                    }else{
                                      registerCubit.nextPage(true, context);
                                    }
                                                             }),
                            ]),
                      ),
                    ),
                  ),
                ),

              );
            },
          );
        }
      },
    );
  }

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  bool isCompleteData(context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return isMoneyEmpty &&
        registerCubit.dataOfBirth.text.isEmpty &&
        registerCubit.genderController.text.isNotEmpty &&
        registerCubit.currencyController.text.isNotEmpty;
  }
}
