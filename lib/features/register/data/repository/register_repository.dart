import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/exceptions.dart';
import 'package:gymawy/core/error/failures.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repository/register_base_rebository.dart';
import '../../domain/usecase/register_usecase.dart';
import '../data_source/register_remote_data_source.dart';

class RegisterRepository extends RegisterBaseRepository {
  RegisterBaseRemoteDataSource registerBaseRemoteDataSource;

  RegisterRepository(this.registerBaseRemoteDataSource);

  @override
  Future<Either<Failure, Register>> register(RegisterParameters registerParameters) async {
    final result = await registerBaseRemoteDataSource.register(registerParameters);

    try {
      return right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.message, error: '', code: 100,
      //  code: failure.code,
      ));
    }
  }
}
