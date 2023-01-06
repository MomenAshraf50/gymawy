// import 'package:dartz/dartz.dart';
// import 'package:equatable/equatable.dart';
// import '../error/failures.dart';
//
//
// abstract class UseCase<Type, Params> {
//   Future<Either<Failure, Type>> call(Params params);
// }
//
// abstract class UseCaseString<Type, Params> {
//   Future<Either<String, Type>> callString(Params params);
// }
//
// class NoParams extends Equatable {
//   @override
//   List<Object> get props => [];
// }

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}