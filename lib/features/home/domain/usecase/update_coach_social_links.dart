import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../repository/home_update_base_repository.dart';

class UpdateCoachSocialLinks
    implements UseCase<UpdateEntity, UpdateCoachSocialLinksParams> {
  final HomeUpdateBaseRepository repository;

  UpdateCoachSocialLinks(this.repository);

  @override
  Future<Either<Failure, UpdateEntity>> call(
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
