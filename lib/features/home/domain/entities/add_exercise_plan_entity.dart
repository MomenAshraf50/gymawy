import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class AddPlanEntity extends Equatable {
  int planId;
  String planName;
  String planVisibility;
  UserInformation makerInformation;
  AddPlanEntity({
    required this.planId,
    required this.makerInformation,
    required this.planName,
    required this.planVisibility,
  });

  @override
  List<Object?> get props => [
    planId,
    makerInformation,
    planName,
    planVisibility,

  ];
}
