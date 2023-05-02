
import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable{}

class Empty extends AppState {
  @override
  List<Object?> get props => [];
}

class Loading extends AppState {
  @override
  List<Object?> get props => [];
}

class Loaded extends AppState {
  @override
  List<Object?> get props => [];
}

class ThemeLoaded extends AppState {
  @override
  List<Object?> get props => [];
}

class ThemeChanged extends AppState {
  @override
  List<Object?> get props => [];
}

class LanguageLoaded extends AppState {
  @override
  List<Object?> get props => [];
}

class ChangeLanguage extends AppState {
  @override
  List<Object?> get props => [];
}

class ConnectivityChanged extends AppState {
  @override
  List<Object?> get props => [];
}

class ConnectivityChangedError extends AppState {
  @override
  List<Object?> get props => [];
}

class ChangePasswordVisibilityState extends AppState{
  @override
  List<Object?> get props => [];
}
class ChangeConfirmPasswordVisibilityState extends AppState{
  @override
  List<Object?> get props => [];
}





