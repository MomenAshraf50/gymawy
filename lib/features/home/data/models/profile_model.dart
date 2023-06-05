import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.userInformation,
    super.fixedPrice,
    super.experience,
    super.rating,
    super.facebookLink,
    super.instagramLink,
    super.tiktokLink,
    super.youtubeLink,
    super.verification,
    super.bodyFat,
    super.currentTall,
    super.currentWeight,
    super.goal
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        userInformation: UserInformation.fromJson(json['user']),
        fixedPrice: json['fixed_price_month'] ?? 0.0,
        facebookLink: json['facebook_link'] ?? 'Unknown',
        instagramLink: json['instagram_link'] ?? 'Unknown',
        tiktokLink: json['tik_tok_link'] ?? 'Unknown',
        youtubeLink: json['youtube_link'] ?? 'Unknown',
        verification: json['verification'] ?? false,
        bodyFat: json['body_fat'] ?? 0,
        currentTall: json['current_tall'] ?? 0,
        experience: json['experience'] ?? 0,
        rating: json['rating'] ?? 0.0,
        currentWeight: json['current_weight'] ?? 0.0,
        goal: json['goal'] ?? 'Unknown',
    );
  }
}
