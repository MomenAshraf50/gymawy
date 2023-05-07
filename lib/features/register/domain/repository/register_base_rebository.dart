// import 'package:dartz/dartz.dart';
// import 'package:gymawy/core/error/failures.dart';
// import '../entities/search_entity.dart';
// import '../usecase/register_usecase.dart';
//
// abstract class RegisterBaseRepository{
//
//   Future<Either<Failure,Register>> register(RegisterParameters registerParameters);
// }

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gymawy/features/register/domain/entities/register_entity.dart';

import '../../../../core/error/failures.dart';

abstract class RegisterBaseRepository {
  Future<Either<Failure, RegisterEntity>> register({
    required String userName,
    required String firstName,
    required String lastName,
    required String fullName,
    required String email,
    required File profilePicture,
    required String bio,
    required String phoneNumber,
    required String gander,
    required String country,
    required String governorate,
    required String city,
    required String password,
    required String confirmPassword,
    String? age,
    int? currentWeight,
    int? currentTall,
    int? bodyFat,
    int? fixedPrice,
    int? experience,
    String? facebookLink,
    String? instagramLink,
    String? youTubeLink,
    String? tikTokLink,
  });
}