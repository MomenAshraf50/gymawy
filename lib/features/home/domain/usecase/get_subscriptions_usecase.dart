import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetSubscriptionUseCase extends UseCase<List<SubscriptionRequestEntity>,GetSubscriptionsRequestsParams>{

  HomeBaseRepository homeBaseRepository;


  GetSubscriptionUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<SubscriptionRequestEntity>>> call(GetSubscriptionsRequestsParams params) {
    return homeBaseRepository.getSubscriptionRequests(params);
  }
}

class GetSubscriptionsRequestsParams extends Equatable{
  String? requestState;
  int? subscriptionRequestId;

  GetSubscriptionsRequestsParams({this.requestState,this.subscriptionRequestId});

  @override
  List<Object?> get props => [requestState,subscriptionRequestId];


}