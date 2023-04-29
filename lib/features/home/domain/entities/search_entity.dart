import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class SearchEntity extends Equatable {
  UserInformation userInformation;

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
    required this.userInformation,
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
        userInformation,
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
