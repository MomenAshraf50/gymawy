import 'package:equatable/equatable.dart';

class UpdateCoachEntity extends Equatable {
  String userName;
  String fullName;
  String profilePicture;
  String bio;
  String phoneNumber;
  String gender;
  double fixedPrice;
  String facebookLink;
  String instagramLink;
  String tiktokLink;
  String youtubeLink;
  String country;
  String governorate;
  String city;
  bool verification;


  UpdateCoachEntity({
    required this.userName,
    required this.fullName,
    required this.profilePicture,
    required this.bio,
    required this.phoneNumber,
    required this.gender,
    required this.fixedPrice,
    required this.facebookLink,
    required this.instagramLink,
    required this.tiktokLink,
    required this.youtubeLink,
    required this.country,
    required this.governorate,
    required this.city,
    required this.verification
});

  @override
  List<Object?> get props => [
    userName,
    fullName,
    profilePicture,
    bio,
    phoneNumber,
    gender,
    fixedPrice,
    facebookLink,
    instagramLink,
    tiktokLink,
    youtubeLink,
    country,
    governorate,
    city,
    verification
  ];
}
