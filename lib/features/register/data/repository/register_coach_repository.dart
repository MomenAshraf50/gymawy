import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/exceptions.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/features/register/data/data_source/register_coach_remote_data_source.dart';
import 'package:gymawy/features/register/domain/repository/register_coach_base_rebository.dart';
import 'package:gymawy/features/register/domain/usecase/register_coach_usecase.dart';
import '../../domain/entities/register_coach_entity.dart';


class RegisterCoachRepository extends RegisterCoachBaseRepository {
  RegisterCoachBaseRemoteDataSource registerCoachBaseRemoteDataSource;

  RegisterCoachRepository(this.registerCoachBaseRemoteDataSource);

  @override
  Future<Either<Failure, RegisterCoach>> registerCoach(RegisterCoachParameters registerCoachParameters) async {
    final result = await registerCoachBaseRemoteDataSource.registerCoach(registerCoachParameters);

    try {
      return right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        message: failure.message, error: '', code: 100,
       // code: failure.code,
      ));
    }
  }
}
