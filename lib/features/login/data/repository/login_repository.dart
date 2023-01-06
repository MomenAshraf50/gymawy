import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/exceptions.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/features/login/data/data_source/login_remote_data_source.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
import 'package:gymawy/features/login/domain/repository/login_base_rebository.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';

class LoginRepository extends LogInBaseRepository {
  LogInBaseRemoteDataSource logInBaseRemoteDataSource;

  LoginRepository(this.logInBaseRemoteDataSource);

  @override
  Future<Either<Failure, LogIn>> logIn(LogInParameters logInParameters) async {
    final result = await logInBaseRemoteDataSource.logIn(logInParameters);

    try {
      return right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.message,
       // code: failure.code,
      ));
    }
  }
}
