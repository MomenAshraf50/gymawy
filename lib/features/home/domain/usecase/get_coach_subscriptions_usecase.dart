import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetCoachSubscriptionsUseCase extends UseCase<List<CoachSubscriptionsEntity>,NoParams>{

  HomeBaseRepository homeBaseRepository;


  GetCoachSubscriptionsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<CoachSubscriptionsEntity>>> call(NoParams params) {
    return homeBaseRepository.getCoachSubscriptions();
  }
}

