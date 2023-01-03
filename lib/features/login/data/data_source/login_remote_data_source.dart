import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import 'package:gymawy/features/login/data/models/login_model.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';

abstract class LogInBaseRemoteDataSource {
  final DioHelper dioHelper;

  LogInBaseRemoteDataSource(this.dioHelper);

  Future<LogInModel> logIn(LogInParameters logInParameters);
}

class LogInRemoteDataSource extends LogInBaseRemoteDataSource {
  LogInRemoteDataSource(super.dioHelper);

  @override
  Future<LogInModel> logIn(LogInParameters logInParameters) async {
    final logInResponse = await dioHelper.post(url: logInEndPoint, data: {
      'username': logInParameters.email,
      'password': logInParameters.password
    });

    return LogInModel.fromJson(logInResponse.data);
  }
}
