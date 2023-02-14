import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class MarkAsReadUseCase extends UseCase<void,MarkAsReadParams>{

  HomeBaseRepository homeBaseRepository;


  MarkAsReadUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(MarkAsReadParams params) {
    return homeBaseRepository.markAsRead(params);
  }
}

class MarkAsReadParams extends Equatable{
  int notificationId;

  MarkAsReadParams({required this.notificationId});

  @override
  List<Object?> get props => [notificationId];


}