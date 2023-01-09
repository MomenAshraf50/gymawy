import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/profile_entity.dart';
import '../repository/home_base_repository.dart';

class ProfileUseCase implements UseCase<ProfileEntity, ProfileParams> {
  final HomeBaseRepository repository;

  ProfileUseCase(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(
      ProfileParams params) async {
    return await repository.profile(
      id: params.id,
    );
  }
}

class ProfileParams extends Equatable {
  final String id;


  const ProfileParams({
    required this.id,
  });

  @override
  List<Object> get props => [
    id,
  ];
}
