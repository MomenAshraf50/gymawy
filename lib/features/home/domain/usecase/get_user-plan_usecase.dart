import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/user_plan_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetUserPlanUseCase extends UseCase<List<UserPlanEntity>,NoParams> {

  HomeBaseRepository homeBaseRepository;

  GetUserPlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<UserPlanEntity>>> call(NoParams params) {
    return homeBaseRepository.getUserPlan();
  }
}
