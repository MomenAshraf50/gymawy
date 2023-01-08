import 'package:equatable/equatable.dart';

class SearchEntity extends Equatable {
  List results;

  SearchEntity({
    required this.results,
  });

  @override
  List<Object?> get props => [
    results,
  ];
}
