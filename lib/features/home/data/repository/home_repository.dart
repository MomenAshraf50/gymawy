
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:gymawy/features/home/data/data_source/home_remote_data_source.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
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
  Future<Either<Failure, UpdateEntity>> updateCoachProfile(
      {required UpdateProfileParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateCoachProfile(params: params);
    });
  }

  @override
  Future<Either<Failure, UpdateEntity>> updateCoachProfilePicture(
      {required UpdateProfilePictureParams params}) async{
    return await fetchData(() {
      return remoteDataSource.updateCoachProfilePicture(params: params);
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


}
