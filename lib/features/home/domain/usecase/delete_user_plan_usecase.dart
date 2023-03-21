import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteUserPlanUseCase extends UseCase<void,DeleteUserPlanParams>{

  HomeBaseRepository homeBaseRepository;

  DeleteUserPlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteUserPlanParams params) {
    return homeBaseRepository.deleteUserPlan(params);
  }
}

class DeleteUserPlanParams extends Equatable{

  int userPlanId;

  DeleteUserPlanParams({required this.userPlanId});

  @override
  List<Object?> get props => [userPlanId];


}