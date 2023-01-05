import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import '../entities/register_entity.dart';
import '../usecase/register_usecase.dart';

abstract class RegisterBaseRepository{

  Future<Either<Failure,Register>> register(RegisterParameters registerParameters);
}