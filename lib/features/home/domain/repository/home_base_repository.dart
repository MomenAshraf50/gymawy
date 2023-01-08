import 'package:dartz/dartz.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_entity.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, UpdateCoachEntity>> updateCoachProfile(
      {required UpdateCoachProfileParams params});

  Future<Either<Failure, UpdateCoachEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<Either<Failure, UpdateCoachEntity>> updateCoachProfilePicture(
      {required UpdateCoachProfilePictureParams params});

  Future<Either<Failure, SearchEntity>> search({
    required String search,
  });


}
