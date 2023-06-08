import 'package:equatable/equatable.dart';

class BodyMeasurementsEntity extends Equatable {
  int measurementsId;
  // String name;
  // String userName;
  double weight;
  int tall;
  int bodyFat;
  String frontBodyPic;
  String backBodyPic;
  String rightSideBodyPic;
  String leftSideBodyPic;
  String goal;
  String time;

  BodyMeasurementsEntity({
    required this.measurementsId,
    // required this.name,
    // required this.userName,
    required this.weight,
    required this.tall,
    required this.bodyFat,
    required this.frontBodyPic,
    required this.backBodyPic,
    required this.rightSideBodyPic,
    required this.leftSideBodyPic,
    required this.goal,
    required this.time,
  });

  @override
  List<Object?> get props => [
    measurementsId,
        // name,
        // userName,
        weight,
        tall,
        bodyFat,
        frontBodyPic,
        backBodyPic,
        rightSideBodyPic,
        leftSideBodyPic,
        goal,
        time,
      ];
}
