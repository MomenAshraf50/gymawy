import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_update_base_repository.dart';

class UpdateCoachProfilePicture
    implements UseCase<UpdateCoachEntity, UpdateCoachProfilePictureParams> {
  final HomeUpdateBaseRepository repository;

  UpdateCoachProfilePicture(this.repository);

  @override
  Future<Either<Failure, UpdateCoachEntity>> call(
      UpdateCoachProfilePictureParams params) async {
    return await repository.updateCoachProfilePicture(
      params: params,
    );
  }
}

class UpdateCoachProfilePictureParams extends Equatable {
  final File image;


  const UpdateCoachProfilePictureParams({required this.image});

  @override
  List<Object> get props => [
    image,
  ];
}