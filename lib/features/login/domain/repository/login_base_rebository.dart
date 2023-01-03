import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';

import '../usecase/log_in_usecase.dart';

abstract class LogInBaseRepository{

  Future<Either<Failure,LogIn>> logIn(LogInParameters logInParameters);
}