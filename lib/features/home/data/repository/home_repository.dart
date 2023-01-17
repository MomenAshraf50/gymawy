
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymawy/features/home/data/data_source/home_remote_data_source.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/certificate_entity.dart';

typedef Call = Future<UpdateEntity> Function();
typedef CallSearch = Future<List<SearchEntity>> Function();
typedef CallProfile = Future<ProfileEntity> Function();
typedef CallCertification = Future<CertificateEntity> Function();
typedef CallGetCertification = Future<List<CertificateEntity>> Function();
typedef CallDeleteCertification = Future<void> Function();
typedef CallAddExercise= Future<AddExerciseEntity> Function();
typedef CallGetExercise = Future<List<AddExerciseEntity>> Function();


class HomeRepository extends HomeBaseRepository {
  final HomeBaseDataSource remoteDataSource;

  HomeRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, UpdateEntity>> fetchData(
    Call mainMethod,

  ) async {
    try {
      final coachData = await mainMethod();
      return Right(coachData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, UpdateEntity>> updateProfile(
      {required UpdateProfileParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateProfile(params: params);
    });
  }

  @override
  Future<Either<Failure, UpdateEntity>> updateProfilePicture(
      {required UpdateProfilePictureParams params}) async{
    return await fetchData(() {
      return remoteDataSource.updateProfilePicture(params: params);
    });
  }

  @override
  Future<Either<Failure, UpdateEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params}) async{
    return await fetchData(() {
      return remoteDataSource.updateCoachSocialLinks(params: params);
    });
  }


  Future<Either<Failure, List<SearchEntity>>> fetchSearch(
      CallSearch mainMethod,
      ) async {
    try {
      final searchData = await mainMethod();
      return Right(searchData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> search({
    required String search,
  }) async {
    return await fetchSearch(() {
      return remoteDataSource.search(
          search: search
      );
    });
  }




  Future<Either<Failure, ProfileEntity>> fetchProfile(
      CallProfile mainMethod,
      ) async {
    try {
      final profileData = await mainMethod();
      return Right(profileData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> profile({
    required String id,
  }) async {
    return await fetchProfile(() {
      return remoteDataSource.profile(
          id: id
      );
    });
  }



  Future<Either<Failure, CertificateEntity>> fetchCertificate(
      CallCertification mainMethod,
      ) async {
    try {
      final certificateData = await mainMethod();
      return Right(certificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CertificateEntity>> certificate({
    required String id,
    required String certificateName,
    required FilePickerResult certificateFile,
    required String certificateDate,
  }) async {
    return await fetchCertificate(() {
      return remoteDataSource.certificate(
          id: id,
          certificateName:certificateName,
          certificateFile:certificateFile,
          certificateDate:certificateDate,
      );
    });
  }

  Future<Either<Failure,List<CertificateEntity>>> fetchGetCertificate(
      CallGetCertification mainMethod,
      ) async {
    try {
      final certificateData = await mainMethod();
      return Right(certificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<CertificateEntity>>> getCertificate(GetCertificateParams params)async {
    return await fetchGetCertificate((){
      return remoteDataSource.getCertificate(params);
    });
  }

  Future<Either<Failure,void>> fetchDeleteCertificate(
      CallDeleteCertification mainMethod,
      ) async {
    try {
      final deleteCertificateData = await mainMethod();
      return Right(deleteCertificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCertificate(
      {
    required String certificateId,
  })async {
    return await fetchDeleteCertificate((){
      return remoteDataSource.deleteCertificate(
        certificateId: certificateId
      );
    });
  }

  @override
  Future<Either<Failure, CertificateEntity>> updateCertificate(UpdateCertificateParams params) {
    return fetchCertificate((){
      return remoteDataSource.updateCertificate(params);
    });
  }

  Future<Either<Failure, AddExerciseEntity>> fetchAddExercise(
      CallAddExercise mainMethod,
      ) async {
    try {
      final addExerciseData = await mainMethod();
      return Right(addExerciseData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddExerciseEntity>> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,


  }) async {
    return await fetchAddExercise(() {
      return remoteDataSource.addExercise(
        exerciseName: exerciseName,
        exerciseCategory: exerciseCategory,
        exerciseVisibility: exerciseVisibility,
        exercisePic: exercisePic,
        exerciseVideo: exerciseVideo,
        context: context,
      );
    });
  }


  Future<Either<Failure,List<AddExerciseEntity>>> fetchGetExercise(
      CallGetExercise mainMethod,
      ) async {
    try {
      final exerciseData = await mainMethod();
      return Right(exerciseData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<AddExerciseEntity>>> getExercise(GetExerciseParams params)async {
    return await fetchGetExercise((){
      return remoteDataSource.getExercise(params);
    });
  }


}
