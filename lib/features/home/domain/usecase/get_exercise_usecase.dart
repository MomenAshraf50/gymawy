import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_exercise_entity.dart';

class GetExerciseUseCase extends UseCase<List<AddExerciseEntity>,GetExerciseParams>{

  HomeBaseRepository homeBaseRepository;


  GetExerciseUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<AddExerciseEntity>>> call(GetExerciseParams params) async{
    return await homeBaseRepository.getExercise(params);
  }
}

class GetExerciseParams extends Equatable{

  const GetExerciseParams();

  @override
  List<Object?> get props => [];
}