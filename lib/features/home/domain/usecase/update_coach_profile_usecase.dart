import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_update_base_repository.dart';

class UpdateCoachProfile
    implements UseCase<UpdateCoachEntity, UpdateCoachProfileParams> {
  final HomeUpdateBaseRepository repository;

  UpdateCoachProfile(this.repository);

  @override
  Future<Either<Failure, UpdateCoachEntity>> call(
      UpdateCoachProfileParams params) async {
    return await repository.updateCoachProfile(
      params: params,
    );
  }
}

class UpdateCoachProfileParams extends Equatable {
  final String userName;
  final String email;
  final String? phone;
  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final double fixedPrice;
  final String password;

  const UpdateCoachProfileParams({
    required this.email,
    required this.userName,
    required this.password,
    this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.bio,
    required this.fixedPrice,
  });

  @override
  List<Object> get props => [
        userName,
        email,
        //phone,
        firstName,
        lastName,
        fullName,
        bio,
        fixedPrice,
        password,
      ];
}
