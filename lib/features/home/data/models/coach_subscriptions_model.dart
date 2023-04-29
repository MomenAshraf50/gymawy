import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class CoachSubscriptionsModel extends CoachSubscriptionsEntity {
  CoachSubscriptionsModel({
    required super.subscribeId,
    required super.clientInformation,
    required super.startDate,
    required super.endDate,
    required super.status,
    required super.coachInformation,
    required super.coachId,
  });

  factory CoachSubscriptionsModel.fromJson(Map<String, dynamic> json) {
    return CoachSubscriptionsModel(
      coachId: json['trainer'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      coachInformation: UserInformation.fromJson(json['trainer_info']),
      clientInformation: UserInformation.fromJson(json['client_info']),
      status: json['status'],
      subscribeId: json['id'],
    );
  }
}
