import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  String token;

  RegisterEntity({
    required this.token,
  });

  @override
  List<Object?> get props => [
        token,
      ];
}
