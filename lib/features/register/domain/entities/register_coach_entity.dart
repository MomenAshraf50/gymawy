import 'package:equatable/equatable.dart';

class RegisterCoach extends Equatable {
  String token;

  RegisterCoach({
    required this.token,
  });

  @override
  List<Object?> get props => [
        token,
      ];
}
