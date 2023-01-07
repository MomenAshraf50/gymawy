import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/set_your_location.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/loadingPage.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../controller/register_cubit.dart';
import '../../controller/register_states.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key,

  }) : super(key: key);


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
    debugPrintFullText(genderRegister!);
    debugPrintFullText(currentWeightRegister.toString());
    debugPrintFullText(currentTallRegister!.toString());
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return FutureBuilder(
      future: registerCubit.readJson(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingPage(),
          );
        } else {
          return BlocBuilder<RegisterCubit,RegisterStates>(
            builder: (context, state) {
              return Padding(
                // Padding(
                padding: designApp,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      svgImage(path: Assets.images.svg.location),
                      Align(
                        alignment: Alignment.centerRight,
                        child: DefaultIconButton(
                            icon: const Icon(Icons.add_location_alt_outlined),
                            onPressed: ()
                            {
                              navigateTo(context,  SetYourLocation());
                            }
                        ),
                      ),
                      verticalSpace(5.h),
                      CustomDropdown.search(
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
                      verticalSpace(5.h),
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
                      verticalSpace(5.h),

                      myButton(
                          elevation: 0.0,
                          color: ColorsManager.mainColor,
                          height: 3.h,
                          text: AppString.next,
                          onPressed: () {
                            countryRegister = registerCubit.countryController.text;
                            governmentRegister = registerCubit.cityController.text;
                            registerCubit.changeCity ? registerCubit.nextPage(true, context) : null;
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
