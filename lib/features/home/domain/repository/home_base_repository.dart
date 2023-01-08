import 'package:dartz/dartz.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import 'package:gymawy/features/home/domain/usecase/search_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import '../../../../core/error/failures.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, UpdateEntity>> updateCoachProfile(
      {required UpdateProfileParams params});

  Future<Either<Failure, UpdateEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<Either<Failure, UpdateEntity>> updateCoachProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<Either<Failure, List<SearchEntity>>> search({
    required String search,
  });
}
