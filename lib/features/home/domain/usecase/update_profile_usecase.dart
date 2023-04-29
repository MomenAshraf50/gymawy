import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';

class UpdateProfile
    implements UseCase<ProfileEntity, UpdateProfileParams> {
  final HomeBaseRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(
      UpdateProfileParams params) async {
    return await repository.updateProfile(
      params: params,
    );
  }
}

class UpdateProfileParams extends Equatable {
  final String userName;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String bio;
  final String? goal;
  final double? fixedPrice;
  final double? currentWeight;
  final double? currentTall;
  final double? bodyFat;
  final String? password;

  const UpdateProfileParams({
    required this.email,
    required this.userName,
    this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.bio,
    this.fixedPrice,
    this.currentWeight,
    this.currentTall,
    this.bodyFat,
    this.goal
  });
  @override
  List<Object> get props => [
        userName,
        email,
        phone,
        firstName,
        bio,
      ];
}
