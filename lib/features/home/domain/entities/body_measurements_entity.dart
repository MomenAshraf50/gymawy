import 'package:equatable/equatable.dart';

class BodyMeasurementsEntity extends Equatable {
  int measurementsId;
  String name;
  String userName;
  double weight;
  double tall;
  double bodyFat;
  String fullBodyPic;
  String rightSideBodyPic;
  String leftSideBodyPic;
  String goal;
  String time;

  BodyMeasurementsEntity({
    required this.measurementsId,
    required this.name,
    required this.userName,
    required this.weight,
    required this.tall,
    required this.bodyFat,
    required this.fullBodyPic,
    required this.rightSideBodyPic,
    required this.leftSideBodyPic,
    required this.goal,
    required this.time,
  });

  @override
  List<Object?> get props => [
    measurementsId,
        name,
        userName,
        weight,
        tall,
        bodyFat,
        fullBodyPic,
        rightSideBodyPic,
        leftSideBodyPic,
        goal,
        time,
      ];
}
