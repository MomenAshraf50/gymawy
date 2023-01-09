import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.userName,
    required super.fullName,
    required super.profilePicture,
    required super.bio,
    required super.phoneNumber,
    required super.gender,
    super.fixedPrice,
    super.facebookLink,
    super.instagramLink,
    super.tiktokLink,
    super.youtubeLink,
    required super.country,
    required super.governorate,
    required super.city,
    super.verification,
    super.userId,
    super.age,
    super.bodyFat,
    super.currentTall,
    super.currentWeight,
    super.goal
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        userName: json['user'] ?? 'UnKnown',
        fullName: json['name'] ?? 'UnKnown',
        profilePicture: json['profile_picture'] ?? 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=',
        bio: json['bio'] ?? 'UnKnown',
        phoneNumber: json['phone_number'] ?? 'UnKnown',
        gender: json['gander']?? 'M',
        fixedPrice: json['fixed_price_month']?? 0,
        facebookLink: json['facebook_link']?? 'UnKnown',
        instagramLink: json['instagram_link']?? 'UnKnown',
        tiktokLink: json['tik_tok_link']?? 'UnKnown',
        youtubeLink: json['youtube_link']?? 'UnKnown',
        country: json['country']?? 'UnKnown',
        governorate: json['Governorate']?? 'UnKnown',
        city: json['city']?? 'UnKnown',
        verification: json['verification']?? false,
        age: json['age']?? 0,
        bodyFat: json['body_fat']?? 0,
        currentTall: json['current_tall']?? 0,
        currentWeight: json['current_weight']?? 0,
        goal: json['goal']?? 'UnKnown',
        userId: json['user_id']?? 0,
    );
  }
}
