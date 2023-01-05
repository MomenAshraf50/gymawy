import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import '../entities/register_coach_entity.dart';
import '../entities/register_entity.dart';
import '../repository/register_base_rebository.dart';
import '../repository/register_coach_base_rebository.dart';

class RegisterCoachUseCase
    extends UseCase<RegisterCoach, RegisterCoachParameters> {
  RegisterCoachBaseRepository registerCoachBaseRepository;

  RegisterCoachUseCase(this.registerCoachBaseRepository);

  @override
  Future<Either<Failure, RegisterCoach>> call(
      RegisterCoachParameters params) async {
    return await registerCoachBaseRepository.registerCoach(params);
  }
}

class RegisterCoachParameters extends Equatable {
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
  String facebookLink;
  String instagramLink;
  String youtubeLink;
  String tiktokLink;
  int fixedPrice;

  RegisterCoachParameters(
      this.email,
      this.password,
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
      this.facebookLink,
      this.fixedPrice,
      this.instagramLink,
      this.tiktokLink,
      this.youtubeLink);

  @override
  List<Object?> get props => [
        email,
        password,
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
        facebookLink,
        instagramLink,
        tiktokLink,
        youtubeLink,
        fixedPrice,
      ];
}
