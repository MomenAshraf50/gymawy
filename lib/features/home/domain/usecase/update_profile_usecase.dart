import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_update_base_repository.dart';

class UpdateProfile
    implements UseCase<UpdateEntity, UpdateProfileParams> {
  final HomeUpdateBaseRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, UpdateEntity>> call(
      UpdateProfileParams params) async {
    return await repository.updateProfile(
      params: params,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final bool isCoach;
  final String userName;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String fullName;
  final String bio;
  final String? goal;
  final double? fixedPrice;
  final double? currentWeight;
  final double? currentTall;
  final double? bodyFat;
  final String password;

  const UpdateProfileParams({
    required this.isCoach,
    required this.email,
    required this.userName,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.bio,
    this.goal,
    this.fixedPrice,
    this.currentWeight,
    this.currentTall,
    this.bodyFat
  });

  @override
  List<Object> get props => [
        userName,
        email,
        phone,
        firstName,
        lastName,
        fullName,
        bio,
        password,
      ];
}
