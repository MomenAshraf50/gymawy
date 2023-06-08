import 'package:gymawy/features/home/domain/entities/body_measurements_entity.dart';

class BodyMeasurementsModel extends BodyMeasurementsEntity {
  BodyMeasurementsModel({
    required super.measurementsId,
    // required super.name,
    // required super.userName,
    required super.weight,
    required super.tall,
    required super.bodyFat,
    required super.frontBodyPic,
    required super.backBodyPic,
    required super.rightSideBodyPic,
    required super.leftSideBodyPic,
    required super.goal,
    required super.time,
  });

  factory BodyMeasurementsModel.fromJson(Map<String,dynamic> json){
    return BodyMeasurementsModel(
      measurementsId: json['id'],
      time: json['timestamp'],
     // userName: json['username'],
      goal: json['goal'],
      bodyFat: json['body_fat'],
     // name: json['name'],
      frontBodyPic: json['front_body_pic'],
      backBodyPic: json['back_body_pic'],
      leftSideBodyPic: json['leftSide_body_pic'],
      rightSideBodyPic: json['rightSide_body_pic'],
      tall: json['tall'],
      weight: json['weight'],
    );
  }
}
