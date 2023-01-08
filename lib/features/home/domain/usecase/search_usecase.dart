import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/search_entity.dart';
import '../repository/home_base_repository.dart';

class SearchUseCase implements UseCase<List<SearchEntity>, SearchParams> {
  final HomeBaseRepository repository;

  SearchUseCase(this.repository);

  @override
  Future<Either<Failure, List<SearchEntity>>> call(
      SearchParams params) async {
    return await repository.search(
      search: params.search,
    );
  }
}

class SearchParams extends Equatable {
  final String search;


  const SearchParams({
    required this.search,
  });

  @override
  List<Object> get props => [
    search,
  ];
}
