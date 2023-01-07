import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/login/data/models/login_model.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
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
    context
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
        token: data.token
      ));
    });
  }
}
