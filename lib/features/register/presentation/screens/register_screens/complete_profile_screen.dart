// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:gymawy/core/util/resources/appString.dart';
// import 'package:gymawy/core/util/resources/assets.gen.dart';
// import 'package:gymawy/core/util/resources/colors_manager.dart';
// import 'package:gymawy/core/util/resources/constants_manager.dart';
// import 'package:gymawy/core/util/resources/extensions_manager.dart';
// import 'package:gymawy/core/util/widgets/default%20dialog.dart';
// import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
// import 'package:gymawy/core/util/widgets/list_title_container.dart';
// import 'package:gymawy/core/util/widgets/loadingPage.dart';
// import 'package:gymawy/core/util/widgets/default_button.dart';
// import 'package:gymawy/core/util/widgets/default_text.dart';
// import 'package:gymawy/core/util/widgets/default_text_field.dart';
// import 'package:gymawy/core/util/widgets/my_icon_button.dart';
// import 'package:gymawy/features/login/presentation/screens/login_screen.dart';
// import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
// import 'package:gymawy/features/register/presentation/controller/register_states.dart';
//
// class CompleteProfileScreen extends StatelessWidget {
//   CompleteProfileScreen({
//     Key? key,
//   }) : super(key: key);
//
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     debugPrintFullText(emailRegister!);
//     debugPrintFullText(passwordRegister!);
//     debugPrintFullText(confirmPasswordRegister!);
//     debugPrintFullText(ageRegister!);
//     debugPrintFullText(firstNameRegister!);
//     debugPrintFullText(fullNameRegister!);
//     debugPrintFullText(lastNameRegister!);
//     debugPrintFullText(phoneRegister!);
//     debugPrintFullText(userPicRegister!.toString());
//     debugPrintFullText(currentWeightRegister.toString());
//     debugPrintFullText(currentTallRegister!.toString());
//
//     RegisterCubit registerCubit = RegisterCubit.get(context);
//
//
//     return FutureBuilder(
//       future: registerCubit.readJson(context),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const LoadingPage();
//         } else {
//           return BlocConsumer<RegisterCubit, RegisterStates>(
//             listener: (context, state) {
//               if (state is RegisterSuccessState) {
//                 navigateAndFinish(context, LoginScreen());
//                 debugPrintFullText(state.token);
//                 userPicRegister = null;
//                 genderRegister = '';
//                 bio = '';
//                 countryRegister = '';
//                 governmentRegister = '';
//                 userNameRegister = '';
//                 firstNameRegister = '';
//                 lastNameRegister = '';
//                 fullNameRegister = '';
//                 ageRegister = '';
//                 emailRegister = '';
//                 phoneRegister = '';
//                 passwordRegister = '';
//                 confirmPasswordRegister = '';
//               }
//               if (state is RegisterErrorState) {
//                 debugPrintFullText(state.failure);
//                 designToastDialog(
//                     context: context, toast: TOAST.error, text: state.failure);
//               }
//             },
//             builder: (context, state) {
//               if (state is RegisterLoadingState) {
//                 return const LoadingPage();
//               } else {
//                 return HideKeyboardPage(
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     child: Form(
//                       key: formKey,
//                       child: Center(
//                         child: Padding(
//                           padding: designApp,
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 svgImage(
//                                     path: Assets.images.svg.couch,
//                                     height: 25.h),
//                                 verticalSpace(2.h),
//                                 const DefaultText(
//                                     title: AppString.lets_complate,
//                                     style: Style.large),
//                                 verticalSpace(2.h),
//                                 const DefaultText(
//                                     title: AppString.will_help,
//                                     style: Style.small),
//                                 verticalSpace(2.h),
//                                 myListTitle(
//                                   onClick: () {
//                                     showCupertinoModalPopup(
//                                         context: context,
//                                         builder: (BuildContext builder) {
//                                           return Container(
//                                             height: 5.h,
//                                             color: Theme.of(context)
//                                                 .scaffoldBackgroundColor,
//                                             child: CupertinoDatePicker(
//                                               mode:
//                                                   CupertinoDatePickerMode.date,
//                                               onDateTimeChanged: (value) {
//                                                 registerCubit.dataOfBirth.text =
//                                                     registerCubit
//                                                         .changeDateFormat(
//                                                             value);
//                                               },
//                                               initialDateTime: DateTime.now(),
//                                               minimumYear: 2000,
//                                               maximumYear: 3000,
//                                             ),
//                                           );
//                                         });
//                                   },
//                                   title: registerCubit.dataOfBirth.text.isEmpty
//                                       ? AppString.date_of_brith
//                                       : registerCubit.dataOfBirth.text,
//                                   svgImg: Assets.images.svg.date,
//                                 ),
//
//                                 verticalSpace(2.h),
//
//                                 DefaultTextField(
//                                   svgImg: Assets.images.svg.user,
//                                   validate: (String? value) {
//                                     if (value!.isEmpty) {
//                                       return 'isEmpty';
//                                     }
//                                     return null;
//                                   },
//                                   controller: registerCubit.bioController,
//                                   hint: AppString.bio,
//                                 ),
//
//                                 Row(
//                                   children: [
//                                     if (countryRegister == null ||
//                                         countryRegister == '')
//                                       Expanded(
//                                         child: CustomDropdown.search(
//                                           hintText: AppString.select_country,
//                                           items: registerCubit.listCountry,
//                                           hintStyle: const TextStyle(
//                                               fontFamily: 'english',
//                                               color: Colors.black),
//                                           listItemStyle: const TextStyle(
//                                               fontFamily: 'english',
//                                               color: Colors.black),
//                                           selectedStyle: const TextStyle(
//                                               fontFamily: 'english',
//                                               color: Colors.black),
//                                           controller:
//                                               registerCubit.countryController,
//                                           onChanged: (value) {
//                                             registerCubit.changeCity = false;
//                                             registerCubit.getCities(value);
//                                           },
//                                         ),
//                                       ),
//                                     if (countryRegister != null &&
//                                         countryRegister != '')
//                                       Expanded(
//                                           child: DefaultText(
//                                               title:
//                                                   '$countryRegister - $governmentRegister - $cityRegister',
//                                               style: Style.extraSmall)),
//                                     DefaultIconButton(
//                                         icon: const Icon(
//                                             Icons.add_location_alt_outlined),
//                                         onPressed: () {
//                                           registerCubit.getPermission();
//                                           if (registerCubit
//                                                   .locationPermission &&
//                                               registerCubit
//                                                   .locationServiceEnabled) {
//                                             registerCubit
//                                                 .getLocation()
//                                                 .then((value) {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return DefaultDialog(
//                                                     message:
//                                                         'This is your Location $countryRegister - $governmentRegister - $cityRegister ',
//                                                     pushButtonText: 'Yes',
//                                                     height: 22.h,
//                                                     pushButtonVoidCallback: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                   );
//                                                 },
//                                               );
//                                             });
//                                           } else {
//                                             designToastDialog(
//                                                 context: context,
//                                                 toast: TOAST.warning,
//                                                 text:
//                                                     'Please enable Location Service or allow Location Permission');
//                                           }
//                                         }),
//                                   ],
//                                 ),
//                                 verticalSpace(1.h),
//                                 if (registerCubit.listCity.isNotEmpty)
//                                   CustomDropdown.search(
//                                     hintText: AppString.select_city,
//                                     hintStyle: const TextStyle(
//                                         fontFamily: 'english',
//                                         color: Colors.black),
//                                     selectedStyle: const TextStyle(
//                                         fontFamily: 'english',
//                                         color: Colors.black),
//                                     listItemStyle: const TextStyle(
//                                         fontFamily: 'english',
//                                         color: Colors.black),
//                                     items: registerCubit.listCity,
//                                     controller: registerCubit.cityController,
//                                     onChanged: (value) {
//                                       registerCubit.changeCity = true;
//                                     },
//                                   ),
//                                 verticalSpace(2.h),
//                                 DefaultButton(
//                                     elevation: 0.0,
//                                     iconWidget: svgImage(
//                                       path: Assets.images.svg.login,
//                                       color: ColorsManager.white,
//                                     ),
//                                     color: ColorsManager.mainColor,
//                                     height: 3.h,
//                                     text: isCoachRegister
//                                         ? AppString.next
//                                         : AppString.create,
//                                     onPressed: () {
//                                       if(formKey.currentState!.validate() && registerCubit.genderController.text.isNotEmpty && countryRegister != null){
//                                         if(countryRegister!.isNotEmpty){
//                                           genderRegister =
//                                               registerCubit.genderController.text;
//                                           if (registerCubit.isCoach) {
//                                             fixedPriceRegister = int.parse(
//                                                 registerCubit.pricePerMonth.text);
//                                             experienceRegister = int.parse(registerCubit.experienceController.text);
//
//                                           }
//                                           // if (!isCoachRegister) {
//                                           //   registerCubit.registerClient(
//                                           //     email: emailRegister!,
//                                           //     password: passwordRegister!,
//                                           //     age: ageRegister!,
//                                           //     confirmPassword:
//                                           //     confirmPasswordRegister!,
//                                           //     firstName: firstNameRegister!,
//                                           //     gander: genderRegister!,
//                                           //     lastName: lastNameRegister!,
//                                           //     phoneNumber: phoneRegister!,
//                                           //     profilePicture: userPicRegister!,
//                                           //     userName: userNameRegister!,
//                                           //   );
//                                           // } else {
//                                           //   registerCubit.nextPage(true, context);
//                                           // }
//                                         }
//                                       }else{
//                                         designToastDialog(context: context, toast: TOAST.warning,text: 'Please complete your data');
//                                       }
//                                     }),
//                               ]),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           );
//         }
//       },
//     );
//   }
//
//   bool isInteger(num value) => value is int || value == value.roundToDouble();
//
//   bool isCompleteData(context) {
//     RegisterCubit registerCubit = RegisterCubit.get(context);
//     return
//         registerCubit.dataOfBirth.text.isEmpty &&
//         registerCubit.genderController.text.isNotEmpty &&
//         registerCubit.currencyController.text.isNotEmpty;
//   }
// }
