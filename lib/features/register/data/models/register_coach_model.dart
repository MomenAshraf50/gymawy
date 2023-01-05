import '../../domain/entities/register_coach_entity.dart';

class RegisterCoachModel extends RegisterCoach {
  RegisterCoachModel({
    required super.token,
  });

  factory RegisterCoachModel.fromJson(Map<String, dynamic> json) {
    return RegisterCoachModel(
      token: json['token'],
    );
  }
}
