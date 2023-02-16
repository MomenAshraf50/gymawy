import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class UpdateSubscriptionStatusUseCase
    extends UseCase<CoachSubscriptionsEntity, UpdateSubscriptionStatusParams> {
  HomeBaseRepository homeBaseRepository;

  UpdateSubscriptionStatusUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, CoachSubscriptionsEntity>> call(
      UpdateSubscriptionStatusParams params) {
    return homeBaseRepository.updateSubscriptionStatus(params);
  }
}

class UpdateSubscriptionStatusParams extends Equatable {
  String status;
  int clientId;
  int subscriptionId;
  int coachId;

  UpdateSubscriptionStatusParams(
      {required this.status,
      required this.clientId,
      required this.coachId,
      required this.subscriptionId});

  @override
  List<Object?> get props => [
        status,
        clientId,
        coachId,
        subscriptionId,
      ];
}
