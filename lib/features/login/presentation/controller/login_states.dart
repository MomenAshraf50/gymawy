
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';

abstract class LoginStates extends Equatable {}

class LoginInitialState extends LoginStates {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginStates {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginStates {
  LoginEntity loginEntity;


  LoginSuccessState({required this.loginEntity});

  @override
  List<Object?> get props => [loginEntity];
}

class LoginErrorState extends LoginStates {
  final String failure;

  LoginErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
}
