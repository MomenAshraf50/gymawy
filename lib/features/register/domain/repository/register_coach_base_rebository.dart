import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import '../entities/register_coach_entity.dart';
import '../entities/register_entity.dart';
import '../usecase/register_coach_usecase.dart';
import '../usecase/register_usecase.dart';

abstract class RegisterCoachBaseRepository{

  Future<Either<Failure,RegisterCoach>> registerCoach(RegisterCoachParameters registerCoachParameters);
}