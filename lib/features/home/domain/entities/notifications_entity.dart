import 'package:equatable/equatable.dart';

class NotificationsEntity extends Equatable {
  int id;
  int recipient;
  String message;
  String verb;
  bool read;
  String time;

  NotificationsEntity({
    required this.id,
    required this.recipient,
    required this.message,
    required this.verb,
    required this.read,
    required this.time,
  });

  @override
  List<Object?> get props => [id,recipient,message,verb,read,time];
}
