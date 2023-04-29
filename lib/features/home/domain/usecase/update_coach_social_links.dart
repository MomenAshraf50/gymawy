import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';

class UpdateCoachSocialLinks
    implements UseCase<ProfileEntity, UpdateCoachSocialLinksParams> {
  final HomeBaseRepository repository;

  UpdateCoachSocialLinks(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(
      UpdateCoachSocialLinksParams params) async {
    return await repository.updateCoachSocialLinks(
      params: params,
    );
  }
}

class UpdateCoachSocialLinksParams extends Equatable {
  final String facebookLink;
  final String instagramLink;
  final String tiktokLink;
  final String youtubeLink;

  const UpdateCoachSocialLinksParams({
    required this.facebookLink,
    required this.instagramLink,
    required this.tiktokLink,
    required this.youtubeLink,
  });

  @override
  List<Object> get props => [
        facebookLink,
        instagramLink,
        youtubeLink,
        tiktokLink,
      ];
}
