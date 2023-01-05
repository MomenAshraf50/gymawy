import 'package:equatable/equatable.dart';

class Register extends Equatable {
  String token;

  Register({
    required this.token,
  });

  @override
  List<Object?> get props => [
        token,
      ];
}
