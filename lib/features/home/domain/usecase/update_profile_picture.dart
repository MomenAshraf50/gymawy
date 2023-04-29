import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class UpdateProfilePicture
    implements UseCase<ProfileEntity, UpdateProfilePictureParams> {
  final HomeBaseRepository repository;

  UpdateProfilePicture(this.repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(
      UpdateProfilePictureParams params) async {
    return await repository.updateProfilePicture(
      params: params,
    );
  }
}

class UpdateProfilePictureParams extends Equatable {
  final File image;


  const UpdateProfilePictureParams({required this.image});

  @override
  List<Object> get props => [
    image,
  ];
}