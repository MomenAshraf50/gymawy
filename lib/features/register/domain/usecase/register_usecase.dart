import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import '../entities/register_entity.dart';
import '../repository/register_base_rebository.dart';

class RegisterUseCase extends UseCase<Register, RegisterParameters> {
  RegisterBaseRepository registerBaseRepository;

  RegisterUseCase(this.registerBaseRepository);

  @override
  Future<Either<Failure, Register>> call(RegisterParameters params) async {
    return await registerBaseRepository.register(params);
  }
}

class RegisterParameters extends Equatable {
  String userName;
  String firstName;
  String lastName;
  String fullName;
  String email;
  File profilePicture;
  String bio;
  String phoneNumber;
  String gander;
  String country;
  String governorate;
  String city;
  String password;
  String confirmPassword;
  String age;
  String currentWeight;
  String currentTall;
  String bodyFat;

  RegisterParameters(
    this.email,
    this.password,
    this.bodyFat,
    this.currentWeight,
    this.currentTall,
    this.age,
    this.bio,
    this.city,
    this.confirmPassword,
    this.country,
    this.firstName,
    this.fullName,
    this.gander,
    this.governorate,
    this.lastName,
    this.phoneNumber,
    this.profilePicture,
    this.userName,
  );

  @override
  List<Object?> get props => [
    email,
    password,
    bodyFat,
    currentWeight,
    currentTall,
    age,
    bio,
    city,
    confirmPassword,
    country,
    firstName,
    fullName,
    gander,
    governorate,
    lastName,
    phoneNumber,
    profilePicture,
    userName,
  ];
}
