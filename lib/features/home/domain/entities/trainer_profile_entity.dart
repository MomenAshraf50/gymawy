import 'package:equatable/equatable.dart';

class ProfileTrainerEntity extends Equatable
{
  final TrainerInfo trainerInfo;
  final int trainerClients;
  final int averageRating;
    ProfileTrainerEntity({
      required this.trainerInfo,
      required this.averageRating,
      required this.trainerClients,
    });
  @override
  // TODO: implement props
  List<Object?> get props => [
    trainerInfo,
    averageRating,
    trainerClients,
  ];
}

class TrainerInfo extends Equatable
{
  final TrainerInfoDetails trainerInfoDetails;
  final int experience;
  final int price;
  final double rating;
  final String facebook_link;
  final String instagram_link;
  final String youtube_link;
  final String tik_tok_link;
  final bool is_verified;

  TrainerInfo({
   required this.trainerInfoDetails,
   required this.experience,
   required this.rating,
   required this.facebook_link,
   required this.instagram_link,
   required this.is_verified,
   required this.price,
   required this.tik_tok_link,
   required this.youtube_link
});

  factory TrainerInfo.fromJson (Map<String,dynamic> json) {
    return TrainerInfo(
      trainerInfoDetails : TrainerInfoDetails.fromJson(json['user']),
      experience : json['experience'],
      price : json['price'],
      rating : json['rating'] ?? 0.0,
      facebook_link : json['facebook_link'],
      instagram_link : json['instagram_link'],
      youtube_link : json['youtube_link'],
      tik_tok_link : json['tik_tok_link'],
      is_verified : json['is_verified'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    trainerInfoDetails,
    experience,
    price,
    rating,
    facebook_link,
    instagram_link,
    youtube_link,
    tik_tok_link,
    is_verified
  ];



}

class TrainerInfoDetails extends Equatable
{
  final int id;
  final int age;
  final String username;
  final String email;
  final String first_name;
  final String last_name;
  final String profile_picture;
  final String phone;
  final String country;
  final String Governorate;
  final String city;
  final String bio;
  final String gander;
  final String birth_date;

  TrainerInfoDetails (
  {
   required this.id,
   required this.age,
   required this.username,
   required this.email,
   required this.first_name,
   required this.last_name,
   required this.profile_picture,
   required this.phone,
   required this.country,
   required this.Governorate,
   required this.city,
   required this.bio,
   required this.gander,
   required this.birth_date,
});

  factory TrainerInfoDetails.fromJson(Map<String,dynamic> json)
  {
    return TrainerInfoDetails(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      profile_picture: json['profile_picture'],
      phone: json['phone'],
      country: json['country'],
      Governorate: json['Governorate'],
      city: json['city'],
      bio: json['bio'],
      gander: json['gander'],
      birth_date: json['birth_date'],
      age: json['age'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    username,
    email,
    first_name,
    last_name,
    profile_picture,
    phone,
    country,
    Governorate,
    city,
    bio,
    gander,
    birth_date,
    age
  ];


}