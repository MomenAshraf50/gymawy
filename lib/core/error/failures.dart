import 'package:equatable/equatable.dart';

import '../util/resources/constants_manager.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  // final String error;
  // final int code;
  final String message;

  ServerFailure({
    // required this.error,
    // required this.code,
    required this.message,
  });
}

class CacheFailure extends Failure {}

// String mapFailureToError(Failure failure) {
//   switch (failure.runtimeType) {
//     case ServerFailure:
//       return (failure as ServerFailure).error.toString();
//     case CacheFailure:
//       return cacheFailureMessage;
//     default:
//       return 'Unexpected error';
//   }
// }

//int mapFailureToCode(Failure failure) => (failure as ServerFailure).code;

String mapFailureToMessage(Failure failure) =>
    (failure as ServerFailure).message;
