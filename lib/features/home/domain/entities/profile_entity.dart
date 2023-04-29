import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  UserInformation userInformation;
  int? bodyFat;
  double? currentWeight;
  int? currentTall;
  double? fixedPrice;
  double? rating;
  int? experience;
  String? goal;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  String? youtubeLink;
  bool? verification;

  ProfileEntity({
    required this.userInformation,
    this.experience,
    this.rating,
    this.fixedPrice,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    this.youtubeLink,
    this.verification,
    this.bodyFat,
    this.currentTall,
    this.currentWeight,
    this.goal,
  });

  @override
  List<Object?> get props => [
        fixedPrice,
        facebookLink,
        instagramLink,
        tiktokLink,
        youtubeLink,
        verification,
        experience,
        rating,
        bodyFat,
        currentTall,
        currentWeight,
        goal
      ];
}

class UserInformation extends Equatable {
  String userName;
  int userId;
  String firstName;
  String lastName;
  String profilePicture;
  String bio;
  String phoneNumber;
  String gender;
  int age;
  String email;
  String country;
  String governorate;
  String city;

  UserInformation({
    required this.userName,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.profilePicture,
    required this.bio,
    required this.phoneNumber,
    required this.gender,
    required this.age,
    required this.email,
    required this.city,
    required this.country,
    required this.governorate,
  });

  factory UserInformation.fromJson(Map<String,dynamic> json){
    return UserInformation(
      userName: json['username'],
      userId: json['id'],
      governorate: json['Governorate'] ?? '',
      country: json['country'] ??'',
      city: json['city']??'',
      bio: json['bio']??'',
      email: json['email']??'',
      phoneNumber: json['phone']??'',
      firstName: json['first_name']??'',
      lastName: json['last_name']??'',
      age: json['age'] ?? 0,
      gender: json['gander']??'',
      profilePicture: json['profile_picture'],
    );
  }

  @override
  List<Object?> get props => [
        userName,
        userId,
        firstName,
        profilePicture,
        bio,
        phoneNumber,
        gender,
        age,
        email,
        city,
        country,
        governorate,
      ];
}
