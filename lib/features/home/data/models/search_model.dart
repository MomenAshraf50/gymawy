import 'package:gymawy/core/util/resources/constants_manager.dart';

import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.userName,
    required super.profilePicture,
    required super.location,
    required super.userId,
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
    return isCoachFilter == false || constClientVariable != null
        ? SearchModel(
            userName: json['user'] ?? '',
            profilePicture: json['profile_picture'] ??
                'https://th.bing.com/th/id/R.39b1781782465e9c9433db271dc6a37b?rik=B25E6Z6PD%2fF60Q&riu=http%3a%2f%2fimage.shutterstock.com%2fz%2fstock-vector-vector-skull-profile-11021419.jpg&ehk=34EmAK%2b5VCh6nc5dOWoHjxkiuXaAviTQfDdURi3a%2byc%3d&risl=&pid=ImgRaw&r=0',
            location: json['Governorate'] ?? 'Unknown',
            userId: json['user_id'] ?? '',
            age: json['age'] ?? 0,
            bio: json['bio'] ?? '',
            currentWeight: json['current_weight'] ?? 0.0,
            currentTall: json['current_tall'] ?? 0,
            bodyFat: json['body_fat'] ?? 0,
            goal: json['goal'] ?? '',
          )
        : SearchModel(
            userName: json['user'] ?? '',
            profilePicture: json['profile_picture'] ??
                'https://th.bing.com/th/id/R.39b1781782465e9c9433db271dc6a37b?rik=B25E6Z6PD%2fF60Q&riu=http%3a%2f%2fimage.shutterstock.com%2fz%2fstock-vector-vector-skull-profile-11021419.jpg&ehk=34EmAK%2b5VCh6nc5dOWoHjxkiuXaAviTQfDdURi3a%2byc%3d&risl=&pid=ImgRaw&r=0',
            location: json['Governorate'] ?? 'Unknown',
            userId: json['user_id'] ?? '',
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
