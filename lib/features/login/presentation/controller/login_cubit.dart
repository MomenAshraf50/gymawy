import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';

import '../../../../core/error/failures.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase _logInUseCase;

  LoginCubit({required LoginUseCase logInUseCase})
      : _logInUseCase = logInUseCase,
        super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  void logIn({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    final result = await _logInUseCase(
        LoginParams(
            userName: email,
            password: password
        )
    );

    result.fold((failure) {
      emit(LoginErrorState(
          failure: mapFailureToMessage(failure)
      ));
    }, (data) {
      emit(LoginSuccessState(
        loginEntity: data
      ));
    });
  }
}
