import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String email;
  String token;
  int userId;
  bool isTrainer;

  LoginEntity({
    required this.email,
    required this.token,
    required this.userId,
    required this.isTrainer,
  });

  @override
  List<Object?> get props => [
        email,
        token,
        userId,
        isTrainer,
      ];
}
