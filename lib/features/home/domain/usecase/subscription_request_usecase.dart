import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class SubscriptionRequestUseCase extends UseCase<SubscriptionRequestEntity,SubscriptionRequestParams> {

  HomeBaseRepository homeBaseRepository;


  SubscriptionRequestUseCase(this.homeBaseRepository);


  @override
  Future<Either<Failure, SubscriptionRequestEntity>> call(SubscriptionRequestParams params) {
    return homeBaseRepository.subscriptionRequest(params);
  }
}


class SubscriptionRequestParams extends Equatable {

  int? coachId;
  String? startDate;
  String? endDate;
  bool isUpdate;
  int? subscriptionRequest;
  String? status;


  SubscriptionRequestParams(
      {this.coachId, this.startDate, this.endDate,required this.isUpdate , this.subscriptionRequest, this.status});

  @override
  List<Object?> get props => [coachId, startDate, endDate, isUpdate, subscriptionRequest,status];
}