import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

import '../../domain/entities/add_exercise_plan_entity.dart';

class PlanModel extends AddPlanEntity {
  PlanModel({
    required super.makerInformation,
    required super.planId,
    required super.planVisibility,
    required super.planName
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      makerInformation:  UserInformation.fromJson(json['maker']),
      planName:  json['plan_name'] ?? 'UnKnown',
      planId:  json['id'] ?? 0,
      planVisibility:  json['visibility'] ?? 'public',
    );
  }


}
