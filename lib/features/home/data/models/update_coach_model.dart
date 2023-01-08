import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';

class UpdateModel extends UpdateEntity {
  UpdateModel({
    required super.userName,
    required super.fullName,
    required super.profilePicture,
    required super.bio,
    required super.phoneNumber,
    required super.gender,
    super.fixedPrice,
    super.facebookLink,
    super.instagramLink,
    super.tiktokLink,
    super.youtubeLink,
    required super.country,
    required super.governorate,
    required super.city,
    super.verification,
    super.userId,
    super.age,
    super.bodyFat,
    super.currentTall,
    super.currentWeight,
    super.goal
  });

  factory UpdateModel.fromJson(Map<String, dynamic> json) {
    return UpdateModel(
      userName: json['user'],
      fullName: json['name'],
      profilePicture: json['profile_picture'],
      bio: json['bio'],
      phoneNumber: json['phone_number'],
      gender: json['gander'],
      fixedPrice: json['fixed_price_month'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tik_tok_link'],
      youtubeLink: json['youtube_link'],
      country: json['country'],
      governorate: json['Governorate'],
      city: json['city'],
      verification: json['verification'],
      age: json['age'],
      bodyFat: json['body_fat'],
      currentTall: json['current_tall'],
      currentWeight: json['current_weight'],
      goal: json['goal'],
      userId: json['user_id']
    );
  }
}
