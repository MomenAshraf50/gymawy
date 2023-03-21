import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/user_plan_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class UserPlanUseCase extends UseCase<UserPlanEntity,UserPlanParams> {

  HomeBaseRepository homeBaseRepository;


  UserPlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, UserPlanEntity>> call(UserPlanParams params) {
    return homeBaseRepository.userPlan(params);
  }
}

class UserPlanParams extends Equatable {

  bool isUpdate;
  int clientId;
  int? exercisePlanId;
  int? nutritionPlanId;

  UserPlanParams(
      {required this.isUpdate,required this.clientId,  this.exercisePlanId,  this.nutritionPlanId,});

  @override
  List<Object?> get props => [isUpdate,clientId,exercisePlanId,nutritionPlanId];


}