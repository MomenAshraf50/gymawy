import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteBodyMeasurementsUseCase extends UseCase<void,NoParams>{

  HomeBaseRepository homeBaseRepository;


  DeleteBodyMeasurementsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return homeBaseRepository.deleteBodyMeasurements();
  }
}