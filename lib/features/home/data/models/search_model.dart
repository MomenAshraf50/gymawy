import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.userInformation,
    super.youtubeLink,
    super.tiktokLink,
    super.age,
    super.bio,
    super.facebookLink,
    super.fixedPrice,
    super.instagramLink,
    super.goal,
    super.currentWeight,
    super.currentTall,
    super.bodyFat,
    super.verification,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return isCoachFilter == false || constClientVariable == null
        ? SearchModel(
      userInformation: UserInformation.fromJson(json['user']),
            age: json['age'] ?? 0,
            bio: json['bio'] ?? '',
            currentWeight: json['current_weight'] ?? 0.0,
            currentTall: json['current_tall'] ?? 0,
            bodyFat: json['body_fat'] ?? 0,
            goal: json['goal'] ?? '',
          )
        : SearchModel(
      userInformation: UserInformation.fromJson(json['user']),
            bio: json['bio'] ?? '',
            fixedPrice: json['fixed_price_month'] ?? 0.0,
            facebookLink: json['facebook_link'] ?? '',
            instagramLink: json['instagram_link'] ?? '',
            youtubeLink: json['youtube_link'] ?? '',
            tiktokLink: json['tik_tok_link'] ?? '',
            verification: json['verification'] ?? false,
          );
  }
}
