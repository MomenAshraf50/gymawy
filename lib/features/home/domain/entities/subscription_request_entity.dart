import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class SubscriptionRequestEntity extends Equatable {
  int subscriptionRequestId;
  UserInformation clientInformation;
  UserInformation coachInformation;
  String requestState;
  String dateCreated;
  String startDate;
  String endDate;

  SubscriptionRequestEntity({
    required this.subscriptionRequestId,
    required this.clientInformation,
    required this.coachInformation,
    required this.requestState,
    required this.dateCreated,
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [
    subscriptionRequestId,
    clientInformation,
    coachInformation,
    startDate,
    endDate,
    dateCreated,
    requestState,
  ];
}
