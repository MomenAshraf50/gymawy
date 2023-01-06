import 'package:gymawy/features/login/domain/entities/log_in_entity.dart';

class LogInModel extends LoginEntity {
  LogInModel({
    required super.email,
    required super.token,
    required super.userId,
    required super.isTrainer,
  });

  factory LogInModel.fromJson(Map<String, dynamic> json) {
    return LogInModel(
      email: json['email'],
      token: json['token'],
      userId: json['user_id'],
      isTrainer: json['is_trainer'],
    );
  }
}
