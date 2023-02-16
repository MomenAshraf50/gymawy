import 'package:equatable/equatable.dart';

class CoachSubscriptionsEntity extends Equatable {
  int subscribeId;
  String clientUserName;
  String coachUserName;
  String startDate;
  String endDate;
  String status;
  String clientPic;
  int clientId;
  int coachId;

  CoachSubscriptionsEntity({
    required this.subscribeId,
    required this.clientUserName,
    required this.coachUserName,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.clientPic,
    required this.clientId,
    required this.coachId,
  });

  @override
  List<Object?> get props => [

  ];
}
