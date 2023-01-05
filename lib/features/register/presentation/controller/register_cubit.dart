import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/register/domain/entities/register_coach_entity.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/address_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/complete_profile_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/create_account_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/goal_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/select_fat_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/social_media_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/goal_data_static.dart';
import '../../../../core/util/widgets/myText.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/usecase/register_coach_usecase.dart';
import '../../domain/usecase/register_usecase.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  final RegisterUseCase _registerUseCase;
  final RegisterCoachUseCase _registerCoachUseCase;
  RegisterCubit({required RegisterUseCase registerUseCase,required RegisterCoachUseCase registerCoachUseCase })
      : _registerUseCase = registerUseCase, _registerCoachUseCase = registerCoachUseCase,
        super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isCoach = false;

  int currentNavIndex = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController pricePerMonth = TextEditingController();
  TextEditingController dataOfBirth = TextEditingController();
  TextEditingController currentWeightController = TextEditingController();
  TextEditingController currentTallController = TextEditingController();

  bool isMoneyEmpty = true;


  Future selectType({required bool isCoach}) async {
    this.isCoach = isCoach;
    emit(RegisterChangeTypeState());
  }
 late List<Widget> pagesClint = [
     CreateAccountScreen(),
     CompleteProfileScreen(),
     const AddressScreen(),
     const SelectFatScreen(),
     const GoalScreen(),
  ];

  late List<Widget> pagesCoach = [
    CreateAccountScreen(),
    CompleteProfileScreen(),
    const AddressScreen(),
    const SocialMediaScreen(),
  ];

  int selectedPage = 0;
  int currentIndex = 0;
  PageController pageController = PageController();
  void bottomChanged(
      int index,
      context
      ){
    currentNavIndex = index;
    pageController.jumpToPage(index);
    emit(RegisterBottomChangedState());
  }

  Future<void> nextPage(bool isNext,BuildContext context) async {
    isNext ? currentIndex++ : currentIndex--;
    await changePage(currentIndex,context);
    emit(RegisterChangePageState());
  }

  Future<void> changePage(int index,BuildContext context) async {
    currentIndex = index;
    if (index >= 0) {
      if (pageController.hasClients) {
        await pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease);
      }
    } else {
      Navigator.pop(context);
    }
    emit(RegisterChangePageState());
  }

  bool isPasswordEightCharacters = false;
  bool isPasswordHasSpecialCharacter = false;
  bool isPasswordHasUpperAndLower = false;
  bool isPasswordNotMach = false;

  matchPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      isPasswordNotMach = true;
    } else {
      isPasswordNotMach = false;
    }
    emit(RegisterMatchPasswordState());
  }

  onPasswordChanged(String password) {
    final upperLower = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
    final specialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    isPasswordEightCharacters = false;
    if (password.length >= 8) isPasswordEightCharacters = true;

    isPasswordHasUpperAndLower = false;
    if (upperLower.hasMatch(password)) isPasswordHasUpperAndLower = true;

    isPasswordHasSpecialCharacter = false;
    if (specialCharacter.hasMatch(password)) {
      isPasswordHasSpecialCharacter = true;
    }
    emit(RegisterPasswordChangedState());
  }

  bool isPasswordValid() {
    return isPasswordEightCharacters &&
        isPasswordHasSpecialCharacter &&
        isPasswordHasUpperAndLower;
  }

  bool isPasswordMach() {
    return passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        !isPasswordNotMach;
  }

  String changeDateFormat(DateTime value){
    emit(RegisterChangeDateFormatState());
    return DateFormat.yMMMd().format(value);
  }

  bool changeMoney(bool isEmpty){
    if(isEmpty){
      emit(RegisterChangeMoneyState());
      return false;
    }else{
      emit(RegisterChangeMoneyState());
      return true;
    }

  }
  void changeSelectedPage(int index){
    selectedPage = index;
    emit(RegisterChangeSelectedPageCreateAccountScreen());
  }

  File? imageFile;

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        emit(RegisterImagePickedSuccessState());
      }
    } catch (e) {
      designToastDialog(context: context, toast: TOAST.error);
      emit(RegisterImagePickedErrorState());
    }
    return image;
  }

  void selectImage(context) async {
    imageFile = await pickImageFromGallery(context);
    emit(RegisterImageSelectedState());
  }

  bool isAccept = false;

  void changeRadioButton(){
    isAccept = !isAccept;
    emit(RegisterChangeRadioButtonState());
}

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<String> listCountry = [];
  List<String> listCity = [];
  dynamic myData;
  bool changeCity = false;


  Future<void> readJson(context) async {
    var snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/new_json.json');
    myData = await json.decode(snapshot);
    myData.keys.forEach((key) {
      listCountry.add(key);
    });
    emit(RegisterGetCountryState());
  }

  Future<void> getCities(String txt) async {
    listCity.clear();
    await myData[txt].forEach((element) {
      listCity.add(element);
    });
    cityController.text = '';
    emit(RegisterGetCitiesState());
  }

  double fatValue = 0;

  List<String> listFat = [
    Assets.images.fat.fat1,
    Assets.images.fat.fat2,
    Assets.images.fat.fat3,
    Assets.images.fat.fat4,
    Assets.images.fat.fat5,
  ];

  void changeFatValue(double fat){
    fatValue = fat;
    emit(RegisterGetFatTextState());
  }

  PageController pageFatController = PageController(viewportFraction: 1/2,);
  Future<void> changeFatPage(index) async {
    await pageFatController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease);
    emit(RegisterPageFatControllerState());
  }

  myText getText(int val) {
    switch (val) {
      case 0:
        emit(RegisterGetFatTextState());
        return const myText(title:'3 - 7 ', style: Style.medium);
      case 1:
        emit(RegisterGetFatTextState());
        return const myText(title:'8 - 16', style: Style.medium);
      case 2:
        emit(RegisterGetFatTextState());
        return const myText(title:'17 - 24', style: Style.medium);
      case 3:
        emit(RegisterGetFatTextState());
        return const myText(title:'24 - 32', style: Style.medium);
      case 4:
        emit(RegisterGetFatTextState());
        return const myText(title:'32+', style: Style.medium);
      default:
        return const myText(title:'', style: Style.medium);
    }

  }

  int selected = 0;

  List<GoalDataStatic> listGoal = [
    GoalDataStatic(
      body: AppString.lean_tone_title,
      title: AppString.lean_tone,
      img: Assets.images.lotti.coach,
    ),
    GoalDataStatic(
      body: AppString.lose_title,
      title: AppString.lose,
      img: Assets.images.lotti.running,
    ),
    GoalDataStatic(
      body: AppString.improve_title,
      title: AppString.improve,
      img: Assets.images.lotti.jumpRope,
    ),
  ];



  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController  = TextEditingController();
  TextEditingController youtubeController  = TextEditingController();
  TextEditingController tiktokController  = TextEditingController();


  Register? registerModel;
  void registerClient({
    required String email,
    required String password,
    required int bodyFat,
    required int currentWeight,
    required int currentTall,
    required String age,
    required String bio,
    required String city,
    required String confirmPassword,
    required String country,
    required String firstName,
    required String fullName,
    required String gander,
    required String governorate,
    required String lastName,
    required String phoneNumber,
    required File profilePicture,
    required String userName,
    context
  }) async {
    emit(RegisterLoadingState());

    final result = await _registerUseCase(RegisterParameters(
      email,
      password,
      bodyFat,
      currentWeight,
      currentTall,
      age,
      bio,
      city,
      confirmPassword,
      country,
      firstName,
      fullName,
      gander,
      governorate,
      lastName,
      phoneNumber,
      profilePicture,
      userName,
    ));

    result.fold((failure) {
      emit(RegisterErrorState(
          failure: failure.toString()
      ));
      debugPrintFullText('Error is ----------------------------- ${failure.toString()}');
    }, (data) {
      registerModel = data;

      emit(RegisterSuccessState(
          token: registerModel!.token
      ));
      imageFile = null;
      emailController.text = '';
      currentTallController.text = '';
      currentWeightController.text = '';
      dataOfBirth.text = '';
      pricePerMonth.text = '';
      currencyController.text = '';
      genderController.text = '';
      confirmPasswordController.text = '';
      passwordController.text = '';
      phoneController.text = '';
      userAgeController.text = '';
      fullNameController.text = '';
      userLastNameController.text = '';
      userFirstNameController.text = '';
      userNameController.text = '';
    });
  }


  RegisterCoach? registerCoachModel;
  void registerCoach({
    required String email,
    required String password,
    required String bio,
    required String city,
    required String confirmPassword,
    required String country,
    required String firstName,
    required String fullName,
    required String gander,
    required String governorate,
    required String lastName,
    required String phoneNumber,
    required File profilePicture,
    required String userName,
    required String facebookLink,
    required String instagramLink,
    required String youtubeLink,
    required String tiktokLink,
    required int fixedPrice,
    context
  }) async {
    emit(RegisterLoadingState());

    final result = await _registerCoachUseCase(RegisterCoachParameters(
        email,
        password,
        bio,
        city,
        confirmPassword,
        country,
        firstName,
        fullName,
        gander,
        governorate,
        lastName,
        phoneNumber,
        profilePicture,
        userName,
        facebookLink,
        fixedPrice,
        instagramLink,
        youtubeLink,
        tiktokLink
    ));

    result.fold((failure) {
      emit(RegisterCoachErrorState(
          failure: failure.toString()
      ));
      debugPrintFullText('Error is ----------------------------- ${failure.toString()}');
    }, (data) {
      registerCoachModel = data;
      emit(RegisterCoachSuccessState(
          token: registerModel!.token
      ));
      imageFile = null;
      emailController.text = '';
      currentTallController.text = '';
      currentWeightController.text = '';
      dataOfBirth.text = '';
      pricePerMonth.text = '';
      currencyController.text = '';
      genderController.text = '';
      confirmPasswordController.text = '';
      passwordController.text = '';
      phoneController.text = '';
      userAgeController.text = '';
      fullNameController.text = '';
      userLastNameController.text = '';
      userFirstNameController.text = '';
      userNameController.text = '';
    });
  }



}