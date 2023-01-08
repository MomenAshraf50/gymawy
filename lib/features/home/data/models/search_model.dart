import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.userName,
    required super.profilePicture,
    required super.location,
    required super.userId,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      userName: json['user'] ?? '',
      profilePicture: json['profile_picture'] ?? 'https://th.bing.com/th/id/R.39b1781782465e9c9433db271dc6a37b?rik=B25E6Z6PD%2fF60Q&riu=http%3a%2f%2fimage.shutterstock.com%2fz%2fstock-vector-vector-skull-profile-11021419.jpg&ehk=34EmAK%2b5VCh6nc5dOWoHjxkiuXaAviTQfDdURi3a%2byc%3d&risl=&pid=ImgRaw&r=0',
      location: json['Governorate'] ?? 'Unknown',
      userId: json['user_id'] ?? '',
    );
  }
}
