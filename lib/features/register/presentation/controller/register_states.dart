abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterChangeTypeState extends RegisterStates{}
class RegisterChangeModeState extends RegisterStates{}
class RegisterBottomChangedState extends RegisterStates{}
class RegisterChangePageState extends RegisterStates{}
class RegisterMatchPasswordState extends RegisterStates{}
class RegisterPasswordChangedState extends RegisterStates{}
class RegisterChangeMoneyState extends RegisterStates{}
class RegisterChangeDateFormatState extends RegisterStates{}
class RegisterChangeSelectedPageCreateAccountScreen extends RegisterStates{}
class RegisterImageSelectedState extends RegisterStates{}
class RegisterImagePickedSuccessState extends RegisterStates{}
class RegisterImagePickedErrorState extends RegisterStates{}
class RegisterChangeRadioButtonState extends RegisterStates{}
class RegisterGetCountryState extends RegisterStates{}
class RegisterGetCitiesState extends RegisterStates{}
class RegisterPageFatControllerState extends RegisterStates{}
class RegisterGetFatTextState extends RegisterStates{}


class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final String token;
  RegisterSuccessState({required this.token});
}

class RegisterErrorState extends RegisterStates {
  final String failure;
  RegisterErrorState({required this.failure});
}

class SetMarkerState extends RegisterStates{}
class GoToLocationState extends RegisterStates{}
class GetLocationIdState extends RegisterStates{}

// class RegisterCoachLoadingState extends RegisterStates {}
//
// class RegisterCoachSuccessState extends RegisterStates {
//   final String token;
//   RegisterCoachSuccessState({required this.token});
// }
//
// class RegisterCoachErrorState extends RegisterStates {
//   final String failure;
//   RegisterCoachErrorState({required this.failure});
// }



