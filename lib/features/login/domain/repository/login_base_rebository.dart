import 'package:dartz/dartz.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';
import '../../../../core/error/failures.dart';

abstract class LogInBaseRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String userName,
    required String password,
  });
}
