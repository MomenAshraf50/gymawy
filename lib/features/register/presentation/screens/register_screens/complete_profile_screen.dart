import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/list_title_container.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
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
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return HideKeyboardPage(
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
                        svgImage(path: Assets.images.svg.couch),
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
                        verticalSpace(2.h),
                        myButton(
                            elevation: 0.0,
                            iconWidget: svgImage(
                              path: Assets.images.svg.login,
                              color: ColorsManager.white,
                            ),
                            color: ColorsManager.mainColor,
                            height: 3.h,
                            text: AppString.next,
                            onPressed: () {
                              genderRegister = registerCubit.genderController.text[0];
                              if(registerCubit.isCoach){
                                fixedPriceRegister =  int.parse(registerCubit.pricePerMonth.text);
                              }
                              registerCubit.nextPage(true, context);
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

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  bool isCompleteData(context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return isMoneyEmpty &&
        registerCubit.dataOfBirth.text.isEmpty &&
        registerCubit.genderController.text.isNotEmpty &&
        registerCubit.currencyController.text.isNotEmpty;
  }
}
