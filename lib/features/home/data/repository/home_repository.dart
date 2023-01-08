import 'package:dartz/dartz.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_source/home_remote_data_source.dart';

typedef Call = Future<UpdateCoachEntity> Function();
typedef CallSearch = Future<SearchEntity> Function();

class HomeRepository extends HomeBaseRepository {
  final HomeBaseDataSource remoteDataSource;

  HomeRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, UpdateCoachEntity>> fetchData(
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
  Future<Either<Failure, UpdateCoachEntity>> updateCoachProfile(
      {required UpdateCoachProfileParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateCoachProfile(params: params);
    });
  }

  @override
  Future<Either<Failure, UpdateCoachEntity>> updateCoachProfilePicture(
      {required UpdateCoachProfilePictureParams params}) async{
    return await fetchData(() {
      return remoteDataSource.updateCoachProfilePicture(params: params);
    });
  }

  @override
  Future<Either<Failure, UpdateCoachEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params}) async{
    return await fetchData(() {
      return remoteDataSource.updateCoachSocialLinks(params: params);
    });
  }

  /// Search

  Future<Either<Failure, SearchEntity>> fetchSearch(
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
  Future<Either<Failure, SearchEntity>> search({
    required String search,
  }) async {
    return await fetchSearch(() {
      return remoteDataSource.search(
          search: search
      );
    });
  }

}
