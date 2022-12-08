import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData visibilityShowPassword = Icons.visibility_outlined;
  bool showPassword = true;

  void changePasswordVisibility(){
    showPassword = !showPassword;
    visibilityShowPassword = showPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }

  IconData visibilityShowConfirmPassword = Icons.visibility_outlined;
  bool showConfirmPassword = true;
  void changeConfirmPasswordVisibility(){
    showConfirmPassword = !showConfirmPassword;
    visibilityShowConfirmPassword = showConfirmPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());
  }
}