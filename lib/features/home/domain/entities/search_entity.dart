import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  String? userName;
  int? userId;
  String? profilePicture;
  String? location;

  ///not required
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? tiktokLink;
  String? bio;
  double? fixedPrice;
  bool? verification;
  int? age;
  int? bodyFat;
  int? currentTall;
  double? currentWeight;
  String? goal;

  SearchEntity({
    required this.userId,
    required this.userName,
    required this.profilePicture,
    required this.location,
    this.verification,
    this.bodyFat,
    this.currentWeight,
    this.currentTall,
    this.goal,
    this.instagramLink,
    this.fixedPrice,
    this.facebookLink,
    this.bio,
    this.age,
    this.tiktokLink,
    this.youtubeLink,
  });

  @override
  List<Object?> get props => [
        userName,
        profilePicture,
        location,
        userId,
        verification,
        bodyFat,
        currentTall,
        currentWeight,
        goal,
        instagramLink,
        fixedPrice,
        facebookLink,
        bio,
        age,
        tiktokLink,
        youtubeLink,
      ];
}
