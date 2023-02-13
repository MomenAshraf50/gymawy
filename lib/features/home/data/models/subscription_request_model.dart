import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';

class SubscriptionRequestModel extends SubscriptionRequestEntity {
  SubscriptionRequestModel({
    required super.subscriptionRequestId,
    required super.clientUsername,
    required super.coachUsername,
    required super.requestState,
    required super.dateCreated,
    required super.startDate,
    required super.endDate,
    required super.clientId,
    required super.coachId,
  });

  factory SubscriptionRequestModel.fromJson(Map<String,dynamic> json){
    return SubscriptionRequestModel(
      clientId: json['client'],
      clientUsername: json['client_username'],
      coachId: json['trainer'],
      coachUsername: json['trainer_username'],
      dateCreated: json['date_created'],
      endDate: json['end_date'],
        requestState:json['state'],
      startDate: json['start_date'],
      subscriptionRequestId: json['SubscriptionRequest_id'],
    );
  }
}
