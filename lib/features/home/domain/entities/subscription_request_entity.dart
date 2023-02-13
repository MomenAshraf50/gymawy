import 'package:equatable/equatable.dart';

class SubscriptionRequestEntity extends Equatable {
  int subscriptionRequestId;
  String clientUsername;
  String clientPic;
  String coachUsername;
  String requestState;
  String dateCreated;
  String startDate;
  String endDate;
  int clientId;
  int coachId;

  SubscriptionRequestEntity({
    required this.subscriptionRequestId,
    required this.clientUsername,
    required this.coachUsername,
    required this.requestState,
    required this.dateCreated,
    required this.startDate,
    required this.endDate,
    required this.clientId,
    required this.coachId,
    required this.clientPic
  });

  @override
  List<Object?> get props => [
    subscriptionRequestId,
    clientUsername,
    clientUsername,
    clientId,
    coachId,
    startDate,
    endDate,
    dateCreated,
    requestState,
    clientPic
  ];
}
