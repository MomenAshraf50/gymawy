import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.userName,
    required super.profilePicture,
    required super.location,
    // required super.userId,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      userName: json['user'],
      profilePicture: json['profile_picture'],
      location: json['Governorate'],
      // userId: json['user_id'],
    );
  }
}
