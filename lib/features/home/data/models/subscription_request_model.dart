import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';

class SubscriptionRequestModel extends SubscriptionRequestEntity {
  SubscriptionRequestModel({
    required super.clientInformation,
    required super.subscriptionRequestId,
    required super.coachInformation,
    required super.requestState,
    required super.dateCreated,
    required super.startDate,
    required super.endDate,
  });

  factory SubscriptionRequestModel.fromJson(Map<String,dynamic> json){
    return SubscriptionRequestModel(
      clientInformation: UserInformation.fromJson(json['client']),
      coachInformation: UserInformation.fromJson(json['trainer_info']),
      dateCreated: json['date_created'],
      endDate: json['end_date'],
        requestState:json['state'],
      startDate: json['start_date'],
      subscriptionRequestId: json['id'],
    );
  }
}
