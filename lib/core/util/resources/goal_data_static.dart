import 'package:equatable/equatable.dart';

class GoalDataStatic extends Equatable {
  final String img;
  final String title;
  final String body;

  const GoalDataStatic(
      {required this.img, required this.title, required this.body});

  @override
  List<Object?> get props => [img, title, body];
}