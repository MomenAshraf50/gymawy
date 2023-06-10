import 'package:gymawy/features/home/domain/entities/trainer_profile_entity.dart';

class ProfileTrainerModel extends ProfileTrainerEntity
{
  ProfileTrainerModel({
    required super.trainerInfo,
    required super.trainerClients,
    required super.averageRating
});

  factory ProfileTrainerModel.fromJson(Map<String,dynamic> json)
  {
    return ProfileTrainerModel(
      trainerInfo: TrainerInfo.fromJson(json['trainer']),
      trainerClients: json['trainerClients'] ?? 0,
      averageRating: json['averageRating'] ?? 0,
    );
  }
}