import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  String userName;
  String userId;
  String profilePicture;

  SearchEntity({
    required this.userId,
    required this.userName,
    required this.profilePicture,
  });

  @override
  List<Object?> get props => [
    userName,
    profilePicture,
    userId
  ];
}
