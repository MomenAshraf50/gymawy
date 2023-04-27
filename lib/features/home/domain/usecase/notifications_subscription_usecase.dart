import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class NotificationsSubscriptionUseCase extends UseCase<void,NotificationsSubscriptionParams>{

  HomeBaseRepository homeBaseRepository;


  NotificationsSubscriptionUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(NotificationsSubscriptionParams params) {
    return homeBaseRepository.notificationSubscription(params);
  }
}

class NotificationsSubscriptionParams extends Equatable{

  String deviceToken;
  bool userLoggedIn;


  NotificationsSubscriptionParams({required this.deviceToken, required this.userLoggedIn});

  @override
  List<Object?> get props => [deviceToken,userLoggedIn];

}