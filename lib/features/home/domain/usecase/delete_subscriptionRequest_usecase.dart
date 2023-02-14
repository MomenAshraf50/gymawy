import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteSubscriptionRequestUseCase extends UseCase<void,DeleteSubscriptionRequestParams>{

  HomeBaseRepository homeBaseRepository;


  DeleteSubscriptionRequestUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteSubscriptionRequestParams params) {
    return homeBaseRepository.deleteSubscriptionRequest(params);
  }
}

class DeleteSubscriptionRequestParams extends Equatable{

  int? subscriptionRequestId;


  DeleteSubscriptionRequestParams(this.subscriptionRequestId);

  @override
  List<Object?> get props => [
    subscriptionRequestId,
  ];

}