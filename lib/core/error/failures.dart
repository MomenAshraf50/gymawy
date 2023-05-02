import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable {

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
  @override
  List<Object> get props => [message];
}


String mapFailureToMessage(Failure failure) =>
    (failure as ServerFailure).message;
