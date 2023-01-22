import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/data/models/add_exercise_model.dart';
import 'package:gymawy/features/home/data/models/certificate_model.dart';
import 'package:gymawy/features/home/data/models/profile_model.dart';
import 'package:gymawy/features/home/data/models/search_model.dart';
import 'package:gymawy/features/home/data/models/update_coach_model.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import '../../domain/usecase/add_exercise_plan_usecase.dart';
import '../../domain/usecase/add_exercise_usecase.dart';
import '../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../domain/usecase/get_exercise_plan_usecase.dart';
import '../models/add_exercise_plan_model.dart';
import '../models/get_exercise_plan_model.dart';

abstract class HomeBaseDataSource {
  Future<UpdateModel> updateProfile({required UpdateProfileParams params});

  Future<UpdateModel> updateProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<UpdateModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<List<SearchModel>> search({
    required String search,
  });

  Future<ProfileModel> profile({
    required String id,
  });

  Future<CertificateModel> certificate({
    required String id,
    required String certificateName,
    required FilePickerResult certificateFile,
    required String certificateDate,
  });

  Future<List<CertificateModel>> getCertificate(GetCertificateParams params);

  Future<void> deleteCertificate({
    required String certificateId,
  });

  Future<CertificateModel> updateCertificate(UpdateCertificateParams params);

  Future<AddExerciseModel> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  });

  Future<List<AddExerciseModel>> getExercise(GetExerciseParams params);

  Future<AddExerciseModel> updateExercise(AddExerciseParams params);

  Future<void> deleteExercise(DeleteExerciseParams params);

  Future<AddExercisePlanModel> addExercisePlan({
    required String exercisePlanName,
    required String exercisePlanVisibility,
  });

  Future<List<AddExercisePlanModel>> getExercisePlan(GetExercisePlanParams params);

  Future<AddExercisePlanModel> updateExercisePlan(AddExercisePlanParams params);

  Future<void> deleteExercisePlan(DeleteExercisePlanParams params);


}

class HomeDataSourceImpl implements HomeBaseDataSource {
  final DioHelper dioHelper;

  HomeDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<UpdateModel> updateProfile(
      {required UpdateProfileParams params}) async {
    final Response f = await dioHelper.put(
      url: isCoachLogin! ? updateCoachEndPoint : updateClientsEndPoint,
      token: token,
      data: isCoachLogin!
          ? {
              'username': params.userName,
              'first_name': params.firstName,
              'last_name': params.lastName,
              'bio': params.bio,
              'name': params.fullName,
              'fixed_price_month': params.fixedPrice,
              'phone_number': params.phone,
              'password': params.password,
              'email': params.email,
            }
          : {
              'username': params.userName,
              'first_name': params.firstName,
              'last_name': params.lastName,
              'bio': params.bio,
              'name': params.fullName,
              'phone_number': params.phone,
              'password': params.password,
              'email': params.email,
              'current_weight': params.currentWeight,
              'body_fat': params.bodyFat,
              'goal': params.goal,
              'current_tall': params.currentTall,
            },
    );
    return UpdateModel.fromJson(f.data);
  }

  @override
  Future<UpdateModel> updateProfilePicture(
      {required UpdateProfilePictureParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: isCoachLogin! ? updateCoachEndPoint : updateClientsEndPoint,
      data: FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          params.image.path,
        )
      }),
      isMultipart: true,
    );
    return UpdateModel.fromJson(f.data);
  }

  @override
  Future<UpdateModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: updateCoachEndPoint,
      data: {
        'tik_tok_link': params.tiktokLink,
        'youtube_link': params.youtubeLink,
        'facebook_link': params.facebookLink,
        'instagram_link': params.instagramLink,
      },
    );
    return UpdateModel.fromJson(f.data);
  }

  @override
  Future<List<SearchModel>> search({
    required String search,
  }) async {
    final Response f = await dioHelper.get(
      url: isCoachFilter == false || constClientVariable != null ? registerEndPoint : registerCoachEndPoint,
      token: token,
      query: constClientVariable == null ?
      {
        'search': search,
      }: null ,
    );
    return List<SearchModel>.from(
        (f.data['results'] as List).map((e) => SearchModel.fromJson(e)));
  }

  @override
  Future<ProfileModel> profile({
    required String id,
  }) async {
    final Response f = await dioHelper.get(
      token: token,
      url:
          //'$registerCoachEndPoint$id/',
          //'$registerEndPoint$id/',
          isCoachLogin == false
              ? '$registerEndPoint$id/'
              : '$registerCoachEndPoint$id/',
    );
    return ProfileModel.fromJson(f.data);
  }

  @override
  Future<CertificateModel> certificate({
    required String id,
    required String certificateName,
    required FilePickerResult certificateFile,
    required String certificateDate,
  }) async {
    final Response f = await dioHelper.post(
      token: token,
      url: certificateEndPoint,
      query: {
        'owner': id,
      },
      data: FormData.fromMap({
        'certificate_name': certificateName,
        'certificate_file': await MultipartFile.fromFile(
            certificateFile.files.first.path!,
            filename:
                Uri.file(certificateFile.files.first.path!).pathSegments.last),
        'date': certificateDate,
      }),
      isMultipart: true,
    );
    return CertificateModel.fromJson(f.data);
  }

  @override
  Future<List<CertificateModel>> getCertificate(
      GetCertificateParams params) async {
    final Response f = await dioHelper.get(
      url: certificateEndPoint,
      query: {
        'owner': params.ownerId,
        //'owner__username': params.ownerName
      },
      token: token,
    );
    return List<CertificateModel>.from(
        (f.data['results'] as List).map((e) => CertificateModel.fromJson(e)));
  }

  @override
  Future<void> deleteCertificate({
    required String certificateId,
  }) async {
    final Response f = await dioHelper.delete(
      token: token,
      url: '$certificateEndPoint$certificateId/',
    );
    return f.data;
  }

  @override
  Future<CertificateModel> updateCertificate(
      UpdateCertificateParams params) async {
    if (params.isFile) {
      final Response f = await dioHelper.put(
        url: '$certificateEndPoint${params.certificateId}/',
        data: {
          'certificate_file': await MultipartFile.fromFile(
              params.certificate!.files.first.path!,
              filename: Uri.file(params.certificate!.files.first.path!)
                  .pathSegments
                  .last),
          'certificate_name': params.certificateName,
          'date': params.certificateDate
        },
        token: token,
      );
      return CertificateModel.fromJson(f.data);
    } else {
      final Response f = await dioHelper.put(
        url: '$certificateEndPoint${params.certificateId}/',
        data: {
          'certificate_name': params.certificateName,
          'date': params.certificateDate
        },
        token: token,
      );
      return CertificateModel.fromJson(f.data);
    }
  }

  @override
  Future<AddExerciseModel> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  }) async {
    final Response f = await dioHelper.post(
        url: addExerciseEndPoint,
        token: token,
        data: FormData.fromMap({
          'exercise_name': exerciseName,
          'category': exerciseCategory,
          'exercise_pic': await MultipartFile.fromFile(
            exercisePic.path,
            filename: Uri.file(exercisePic.path).pathSegments.last,
          ),
          'exercise_vid': await MultipartFile.fromFile(
              exerciseVideo.files.first.path!,
              filename:
                  Uri.file(exerciseVideo.files.first.path!).pathSegments.last),
          'visibility': exerciseVisibility,
        }),
        isMultipart: true,
        progressCallback: (int count, int total) {
          debugPrintFullText('count this request is $count');
          debugPrintFullText('total this request is $total');
          //  debugPrintFullText('progress this request is ${count ~/ total * 100}%');
          HomeCubit homeCubit = HomeCubit.get(context);
          homeCubit.changeProgressValue(
            countProgressValue: count,
            totalProgressValue: total,
          );
        });

    return AddExerciseModel.fromJson(f.data);
  }

  @override
  Future<List<AddExerciseModel>> getExercise(GetExerciseParams params) async {
    final Response f = await dioHelper.get(
      url: addExerciseEndPoint,
      token: token,
    );
    return List<AddExerciseModel>.from(
        (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e)));

    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<AddExerciseModel> updateExercise(AddExerciseParams params) async {
    final Response f;

    if (params.isVideo == false && params.isImage == false) {
      final Response f = await dioHelper.put(
          url: '$addExerciseEndPoint${params.exerciseId}/',
          token: token,
          data: FormData.fromMap({
            'exercise_name': params.exerciseName,
            'category': params.exerciseCategory,
            'visibility': params.exerciseVisibility,
          })
          );
      return AddExerciseModel.fromJson(f.data);
    } else if (params.isVideo == true && params.isImage == true) {
      final Response f = await dioHelper.put(
          url: '$addExerciseEndPoint${params.exerciseId}/',
          token: token,
          data: FormData.fromMap({
            'exercise_name': params.exerciseName,
            'category': params.exerciseCategory,
            'exercise_pic': await MultipartFile.fromFile(
              params.exercisePic!.path,
              filename: Uri.file(params.exercisePic!.path).pathSegments.last,
            ),
            'exercise_vid': await MultipartFile.fromFile(
                params.exerciseVideo!.files.first.path!,
                filename: Uri.file(params.exerciseVideo!.files.first.path!)
                    .pathSegments
                    .last),
            'visibility': params.exerciseVisibility,
          }),
          isMultipart: true,
          progressCallback: (int count, int total) {
            debugPrintFullText('count this request is $count');
            debugPrintFullText('total this request is $total');
            //  debugPrintFullText('progress this request is ${count ~/ total * 100}%');
            HomeCubit homeCubit = HomeCubit.get(params.context);
            homeCubit.changeProgressValue(
              countProgressValue: count,
              totalProgressValue: total,
            );
          });
      return AddExerciseModel.fromJson(f.data);
    } else if (params.isVideo == true && params.isImage == false) {
      final Response f = await dioHelper.put(
          url: '$addExerciseEndPoint${params.exerciseId}/',
          token: token,
          data: FormData.fromMap({
            'exercise_name': params.exerciseName,
            'category': params.exerciseCategory,
            'exercise_vid': await MultipartFile.fromFile(
                params.exerciseVideo!.files.first.path!,
                filename: Uri.file(params.exerciseVideo!.files.first.path!)
                    .pathSegments
                    .last),
            'visibility': params.exerciseVisibility,
          }),
          isMultipart: true,
          progressCallback: (int count, int total) {
            debugPrintFullText('count this request is $count');
            debugPrintFullText('total this request is $total');
            //  debugPrintFullText('progress this request is ${count ~/ total * 100}%');
            HomeCubit homeCubit = HomeCubit.get(params.context);
            homeCubit.changeProgressValue(
              countProgressValue: count,
              totalProgressValue: total,
            );
          });
      return AddExerciseModel.fromJson(f.data);
    } else {
      final Response f = await dioHelper.put(
          url: '$addExerciseEndPoint${params.exerciseId}/',
          token: token,
          data: FormData.fromMap({
            'exercise_name': params.exerciseName,
            'category': params.exerciseCategory,
            'exercise_pic': await MultipartFile.fromFile(
              params.exercisePic!.path,
              filename: Uri.file(params.exercisePic!.path).pathSegments.last,
            ),
            'visibility': params.exerciseVisibility,
          }),
          isMultipart: true,
          progressCallback: (int count, int total) {
            debugPrintFullText('count this request is $count');
            debugPrintFullText('total this request is $total');
            //  debugPrintFullText('progress this request is ${count ~/ total * 100}%');
            HomeCubit homeCubit = HomeCubit.get(params.context);
            homeCubit.changeProgressValue(
              countProgressValue: count,
              totalProgressValue: total,
            );
          });
      return AddExerciseModel.fromJson(f.data);
    }
  }

  @override
  Future<void> deleteExercise(params) async {
    await dioHelper.delete(
      url: '$addExerciseEndPoint${params.exerciseId}/',
      token: token,
    );
  }


  @override
  Future<AddExercisePlanModel> addExercisePlan({
    required String exercisePlanName,
    required String exercisePlanVisibility,
  }) async {
    final Response f = await dioHelper.post(
        url: addExercisePlanEndPoint,
        token: token,
        data: FormData.fromMap({
          'plan_name': exercisePlanName,
          'visibility': exercisePlanVisibility,
        },),
    );

    return AddExercisePlanModel.fromJson(f.data);
  }

  @override
  Future<List<AddExercisePlanModel>> getExercisePlan(GetExercisePlanParams params) async {
    final Response f = await dioHelper.get(
      url: addExercisePlanEndPoint,
      token: token,
    );
    return List<AddExercisePlanModel>.from(
        (f.data['results'] as List).map((e) => AddExercisePlanModel.fromJson(e)));
    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<AddExercisePlanModel> updateExercisePlan(AddExercisePlanParams params) async {
    final Response f = await dioHelper.put(
        url: '$addExercisePlanEndPoint${params.exercisePlanId}/',
        token: token,
        data: FormData.fromMap({
          'plan_name': params.exercisePlanName,
          'visibility': params.exercisePlanVisibility,
        })
    );
    return AddExercisePlanModel.fromJson(f.data);
  }

  @override
  Future<void> deleteExercisePlan(params) async {
    await dioHelper.delete(
      url: '$addExercisePlanEndPoint${params.exercisePlanId}/',
      token: token,
    );
  }



}
