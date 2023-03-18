import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/body_measurements_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class GetBodyMeasurementsUseCase extends UseCase<BodyMeasurementsEntity,GetBodyMeasurementsParams>{

  HomeBaseRepository homeBaseRepository;


  GetBodyMeasurementsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, BodyMeasurementsEntity>> call(GetBodyMeasurementsParams params) {
    return homeBaseRepository.getBodyMeasurements(params);
  }
}

class GetBodyMeasurementsParams extends Equatable {
  int measurementsId;

  GetBodyMeasurementsParams({required this.measurementsId});

  @override
  List<Object?> get props => [measurementsId];


}