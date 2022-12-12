import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/address_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/complete_profile_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/create_account_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/goal_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/select_fat_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/social_media_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isCoach = false;

  int currentNavIndex = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isMoneyEmpty = true;

  Future selectType({required bool isCoach}) async {
    this.isCoach = isCoach;
    emit(RegisterChangeTypeState());
  }

  List<Widget> pagesClint = [
    CreateAccountScreen(),
    CompleteProfileScreen(),
    AddressPage(),
    const SelectFatScreen(),
     GoalScreen(),
  ];

  List<Widget> pagesCoach = [
    CreateAccountScreen(),
    CompleteProfileScreen(),
    AddressPage(),
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


}