import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/body_measurements_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class BodyMeasurementsUseCase extends UseCase<BodyMeasurementsEntity,BodyMeasurementsParams> {

  HomeBaseRepository homeBaseRepository;


  BodyMeasurementsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, BodyMeasurementsEntity>> call(BodyMeasurementsParams params) {
    return homeBaseRepository.bodyMeasurements(params);
  }
}


class BodyMeasurementsParams extends Equatable {
  bool update;
  int? measurementsId;
  double? weight;
  double? tall;
  double? bodyFat;
  File? fullBodyPic;
  File? leftSideBodyPic;
  File? rightSideBodyPic;
  String? goal;

  BodyMeasurementsParams(
      {required this.update,this.measurementsId,this.weight, this.tall, this.bodyFat, this.fullBodyPic,
        this.leftSideBodyPic, this.rightSideBodyPic, this.goal,});

  @override
  List<Object?> get props =>
      [
        update,
        weight,
        tall,
        bodyFat,
        fullBodyPic,
        rightSideBodyPic,
        leftSideBodyPic,
        goal,
      ];


}