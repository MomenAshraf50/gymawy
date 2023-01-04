import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LogInUseCase _logInUseCase;

  LoginCubit({required LogInUseCase logInUseCase})
      : _logInUseCase = logInUseCase,
        super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LogIn? logInModel;
  String? loginErrorMessege;
  void logIn({
    required String email,
    required String password,
    context
  }) async {
    emit(LoginLoadingState());

    final result = await _logInUseCase(LogInParameters(email, password));

    result.fold((failure) {
      emit(LoginErrorState());
      debugPrintFullText('Error is ----------------------------- ${failure.toString()}');
      loginErrorMessege = failure.toString();
    }, (data) {
      logInModel = data;
      emit(LoginSuccessState(
        token: logInModel!.token
      ));
    });
  }
}
