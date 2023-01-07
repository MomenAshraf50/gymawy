import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/log_in_entity.dart';
import '../../domain/repository/login_base_rebository.dart';
import '../data_source/login_remote_data_source.dart';


typedef Call = Future<LoginEntity> Function();

class LoginRepoImplementation extends LogInBaseRepository {
  final LogInBaseRemoteDataSource remoteDataSource;

  LoginRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, LoginEntity>> fetchData(
      Call mainMethod,
      ) async {
    try {
      final loginData = await mainMethod();
      return Right(loginData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        // error: e.error,
        // code: e.code,
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login(
      {
        required String userName,
        required String password
      }) async {
    return await fetchData(()
    {
      return remoteDataSource.logIn(
          userName: userName,
          password: password);
    });
  }
}