
abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String token;
  final int id;

  LoginSuccessState({required this.token,required this.id});
}

class LoginErrorState extends LoginStates {
  final String failure;

  LoginErrorState({required this.failure});
}
