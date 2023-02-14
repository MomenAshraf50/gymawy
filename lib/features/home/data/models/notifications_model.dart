import 'package:gymawy/features/home/domain/entities/notifications_entity.dart';

class NotificationsModel extends NotificationsEntity {
  NotificationsModel({
    required super.id,
    required super.recipient,
    required super.message,
    required super.verb,
    required super.read,
    required super.time,
  });

  factory NotificationsModel.fromJson(Map<String,dynamic> json){
    return NotificationsModel(
      message: json['message'],
      id: json['id'],
      read: json['read'],
      recipient:json['recipient'] ,
      time: json['timestamp'],
      verb: json['verb'],
    );
  }
}
