import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  SearchModel({
    required super.results,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      results: json['results'],
    );
  }
}
