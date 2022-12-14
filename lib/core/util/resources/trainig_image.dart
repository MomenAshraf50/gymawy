import 'package:equatable/equatable.dart';

class TrainingImage extends Equatable {
  final String img;

  const TrainingImage({required this.img});

  @override
  List<Object?> get props => [img];
}