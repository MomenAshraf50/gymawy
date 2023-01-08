import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  String? userName;
  int? userId;
  String? profilePicture;
  String? location;

  SearchEntity({
    required this.userId,
    required this.userName,
    required this.profilePicture,
    required this.location,
  });

  @override
  List<Object?> get props => [
    userName,
    profilePicture,
    location,
    userId
  ];
}
