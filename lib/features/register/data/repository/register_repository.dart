import 'dart:io';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/repository/register_base_rebository.dart';
import '../data_source/register_remote_data_source.dart';

typedef Call = Future<RegisterEntity> Function();

class RegisterRepoImplementation extends RegisterBaseRepository {
  final RegisterBaseRemoteDataSource remoteDataSource;

  RegisterRepoImplementation({
    required this.remoteDataSource,
  });

  Future<Either<Failure, RegisterEntity>> fetchData(
      Call mainMethod,
      ) async {
    try {
      final registerData = await mainMethod();
      return Right(registerData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, RegisterEntity>> register(
      {
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
        String? facebookLink,
        String? instagramLink,
        String? youTubeLink,
        String? tikTokLink,
      }) async {
    return await fetchData(()
    {
      return remoteDataSource.register(
        userName: userName,
        password: password,
        confirmPassword: confirmPassword,
        firstName: firstName,
        fullName: fullName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        age: age,
        bio: bio,
        bodyFat: bodyFat,
        city: city,
        country: country,
        currentTall: currentTall,
        currentWeight: currentWeight,
        gander: gander,
        governorate: governorate,
        profilePicture: profilePicture,
        facebookLink: facebookLink,
        fixedPrice: fixedPrice,
        instagramLink: instagramLink,
        tikTokLink: tikTokLink,
        youTubeLink: youTubeLink,
      );
    });
  }
}

