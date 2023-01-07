import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/register_entity.dart';
import '../repository/register_base_rebository.dart';

class RegisterUseCase
    implements UseCase<RegisterEntity, RegisterParams> {
  final RegisterBaseRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, RegisterEntity>> call(
      RegisterParams params) async {
    return await repository.register(
      userName: params.userName,
      firstName: params.firstName,
      lastName: params.lastName,
      fullName: params.fullName,
      password: params.password,
      confirmPassword: params.confirmPassword,
      email: params.email,
      phoneNumber: params.phoneNumber,
      bio: params.bio,
      gander: params.gander,
      profilePicture: params.profilePicture,
      country: params.country,
      governorate: params.governorate,
      city: params.city,
      age: params.age,
      currentWeight: params.currentWeight,
      currentTall: params.currentTall,
      bodyFat: params.bodyFat,
      fixedPrice: params.fixedPrice,
      facebookLink: params.facebookLink,
      instagramLink: params.instagramLink,
      youTubeLink: params.youTubeLink,
      tikTokLink: params.tikTokLink,
    );
  }
}

class RegisterParams extends Equatable {
  final String userName;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final File profilePicture;
  final String bio;
  final String phoneNumber;
  final String gander;
  final String country;
  final String governorate;
  final String city;
  final String password;
  final String confirmPassword;
  final String age;
  final int currentWeight;
  final int currentTall;
  final int bodyFat;
  final int fixedPrice;
  final String facebookLink;
  final String instagramLink;
  final String youTubeLink;
  final String tikTokLink;

  const RegisterParams({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profilePicture,
    required this.bio,
    required this.phoneNumber,
    required this.gander,
    required this.country,
    required this.governorate,
    required this.city,
    required this.password,
    required this.confirmPassword,
    required this.age,
    required this.currentWeight,
    required this.currentTall,
    required this.bodyFat,
    required this.fixedPrice,
    required this.facebookLink,
    required this.instagramLink,
    required this.youTubeLink,
    required this.tikTokLink,
  });

  @override
  List<Object> get props => [
    userName,
    firstName,
    lastName,
    fullName,
    password,
    confirmPassword,
    email,
    phoneNumber,
    bio,
    gander,
    profilePicture,
    country,
    governorate,
    city,
    age,
    currentWeight,
    currentTall,
    bodyFat,
    fixedPrice,
    facebookLink,
    instagramLink,
    youTubeLink,
    tikTokLink,
  ];
}
