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
      gander: params.gander,
      userName: params.userName,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
      confirmPassword: params.confirmPassword,
      email: params.email,
      phoneNumber: params.phoneNumber,
      profilePicture: params.profilePicture,
      age: params.age,
      fixedPrice: params.fixedPrice,
      experience: params.experience,
      city: params.city,
      country: params.country,
    );
  }
}

class RegisterParams extends Equatable {
  final String userName;
  final String firstName;
  final String lastName;
  final String email;
  final File profilePicture;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String age;
  final String gander;
  final String city;
  final String country;
  final int? fixedPrice;
  final int? experience;


  const  RegisterParams({
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profilePicture,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.age,
    required this.gander,
    required this.city,
    required this.country,
     this.fixedPrice,
     this.experience,
  });

  @override
  List<Object> get props => [
    userName,
    firstName,
    lastName,
    password,
    confirmPassword,
    email,
    phoneNumber,
    profilePicture,
    age,
    gander,
    city,
    country
  ];
}
