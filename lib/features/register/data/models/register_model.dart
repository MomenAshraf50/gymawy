import '../../domain/entities/register_entity.dart';

class RegisterModel extends Register {
  RegisterModel({
    required super.token,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json['token'],
    );
  }
}
