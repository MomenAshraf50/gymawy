import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String failure;

  LoginErrorState(this.failure);
}
