import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/notifications_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetNotificationsUseCase extends UseCase<List<NotificationsEntity>,NoParams>{

  HomeBaseRepository homeBaseRepository;


  GetNotificationsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<NotificationsEntity>>> call(NoParams params) {
    return homeBaseRepository.getNotifications();
  }
}