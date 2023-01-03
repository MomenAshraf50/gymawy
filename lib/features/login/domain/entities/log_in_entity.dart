import 'package:equatable/equatable.dart';

class LogIn extends Equatable {
  String email;
  String token;
  int userId;
  bool isTrainer;

  LogIn({
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
