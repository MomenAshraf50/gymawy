import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/search_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import '../../../../core/error/failures.dart';
import '../entities/add_exercise_entity.dart';
import '../entities/add_exercise_plan_entity.dart';
import '../entities/certificate_entity.dart';
import '../entities/profile_entity.dart';
import '../usecase/add_exercise_plan_usecase.dart';
import '../usecase/delete_exersice_plan_usecase.dart';
import '../usecase/get_exercise_plan_usecase.dart';
import '../usecase/get_exercise_usecase.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, UpdateEntity>> updateProfile(
      {required UpdateProfileParams params});

  Future<Either<Failure, UpdateEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<Either<Failure, UpdateEntity>> updateProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<Either<Failure, List<SearchEntity>>> search({
    required String search,
  });

  Future<Either<Failure, ProfileEntity>> profile({
    required String id,
  });

  Future<Either<Failure, CertificateEntity>> certificate({
    required String id,
    required String certificateName,
    required FilePickerResult certificateFile,
    required String certificateDate,
  });

  Future<Either<Failure,List<CertificateEntity>>> getCertificate(GetCertificateParams params);

  Future<Either<Failure, void>> deleteCertificate({
    required String certificateId,
  });

  Future<Either<Failure,CertificateEntity>> updateCertificate(UpdateCertificateParams params);

  Future<Either<Failure, AddExerciseEntity>> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  });

  Future<Either<Failure,List<AddExerciseEntity>>> getExercise(GetExerciseParams params);

  Future<Either<Failure,AddExerciseEntity>> updateExercise(AddExerciseParams params);

  Future<Either<Failure,void>> deleteExercise(DeleteExerciseParams params);

  Future<Either<Failure, AddExercisePlanEntity>> addExercisePlan({
    required String exercisePlanName,
    required String exercisePlanVisibility,
  });

  Future<Either<Failure,List<AddExercisePlanEntity>>> getExercisePlan(GetExercisePlanParams params);

  Future<Either<Failure,AddExercisePlanEntity>> updateExercisePlan(AddExercisePlanParams params);

  Future<Either<Failure,void>> deleteExercisePlan(DeleteExercisePlanParams params);


}
