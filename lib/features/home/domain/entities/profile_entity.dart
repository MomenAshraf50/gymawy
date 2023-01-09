import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  String userName;
  int? userId;
  String fullName;
  String profilePicture;
  String? bio;
  String phoneNumber;
  String gender;
  int? age;
  int? bodyFat;
  double? currentWeight;
  int? currentTall;
  double? fixedPrice;
  String? goal;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  String? youtubeLink;
  String country;
  String governorate;
  String? city;
  bool? verification;


  ProfileEntity({
    required this.userName,
    required this.fullName,
    required this.profilePicture,
    required this.bio,
    required this.phoneNumber,
    required this.gender,
    this.fixedPrice,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.youtubeLink,
    required this.country,
    required this.governorate,
    required this.city,
    this.verification,
    this.userId,
    this.age,
    this.bodyFat,
    this.currentTall,
    this.currentWeight,
    this.goal
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
