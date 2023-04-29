import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class CoachSubscriptionsEntity extends Equatable {
  int subscribeId;
  UserInformation clientInformation;
  UserInformation coachInformation;
  String startDate;
  String endDate;
  String status;
  int coachId;

  CoachSubscriptionsEntity({
    required this.subscribeId,
    required this.clientInformation,
    required this.coachInformation,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.coachId,
  });

  @override
  List<Object?> get props => [
    subscribeId,
    clientInformation,
    coachInformation,
    startDate,
    endDate,
    status,
    coachId,
  ];
}
