import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';

class UpdateCoachModel extends UpdateCoachEntity {
  UpdateCoachModel({
    required super.userName,
    required super.fullName,
    required super.profilePicture,
    required super.bio,
    required super.phoneNumber,
    required super.gender,
    required super.fixedPrice,
    required super.facebookLink,
    required super.instagramLink,
    required super.tiktokLink,
    required super.youtubeLink,
    required super.country,
    required super.governorate,
    required super.city,
    required super.verification,
  });

  factory UpdateCoachModel.fromJson(Map<String, dynamic> json) {
    return UpdateCoachModel(
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
    );
  }
}
