import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';

class CoachSubscriptionsModel extends CoachSubscriptionsEntity {
  CoachSubscriptionsModel({
    required super.subscribeId,
    required super.clientUserName,
    required super.coachUserName,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.clientPic,
    required super.clientId,
    required super.coachId,
  });

  factory CoachSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return CoachSubscriptionsModel(
      coachId: json['trainer'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      clientId: json['client'],
      clientUserName: json['client_username'],
      coachUserName: json['trainer_username'],
      clientPic: json['client_profile_pic'],
      status: json['status'],
      subscribeId: json['SUBSCRIPE_id'],
    );
  }
}
