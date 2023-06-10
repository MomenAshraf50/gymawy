import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/trainer_profile_entity.dart';
import '../repository/home_base_repository.dart';

class ProfileTrainerUseCase implements UseCase<ProfileTrainerEntity, ProfileTrainerParams> {
  final HomeBaseRepository repository;

  ProfileTrainerUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileTrainerEntity>> call(
      ProfileTrainerParams params) async {
    return await repository.profileTrainer(
        id: params.id,
    );
  }
}

class ProfileTrainerParams extends Equatable {
  final int id;


  const ProfileTrainerParams({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}
