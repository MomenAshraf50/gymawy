import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/data/models/add_exercise_model.dart';
import 'package:gymawy/features/home/data/models/add_nutrition_model.dart';
import 'package:gymawy/features/home/data/models/certificate_model.dart';
import 'package:gymawy/features/home/data/models/exercise_details_model.dart';
import 'package:gymawy/features/home/data/models/profile_model.dart';
import 'package:gymawy/features/home/data/models/search_model.dart';
import 'package:gymawy/features/home/data/models/update_coach_model.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import '../../domain/usecase/add_plan_usecase.dart';
import '../../domain/usecase/add_exercise_usecase.dart';
import '../../domain/usecase/delete_exercise_details_usecase.dart';
import '../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../domain/usecase/get_exercise_plan_details.dart';
import '../../domain/usecase/get_plan_usecase.dart';
import '../models/add_exercise_plan_model.dart';

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

  Future<AddExercisePlanModel> addPlan({
    required bool isNutrition,
    required String planName,
    required String planVisibility,
  });

  Future<List<AddExercisePlanModel>> getPlan(GetPlanParams params);

  Future<AddExercisePlanModel> updatePlan(AddPlanParams params);

  Future<void> deletePlan(DeletePlanParams params);

  Future<ExerciseDetailsModel> addExerciseDetails(ExerciseDetailsParams params);

  Future<List<ExerciseDetailsModel>> getExerciseDetails(
      GetExercisePlanDetailsParams params);

  Future<void> deleteExercisePlanDetails(
      DeleteExercisePlanDetailsParams params);

  Future<AddNutritionModel> addNutrition({
    required int fat,
    required int carb,
    required int protein,
    required int calories,
    required String? howToPrepare,
    required Map component,
    required File nutritionPic,
    required String nutritionCategory,
    required String nutritionName,
    required String nutritionVisibility,
  });


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
      url: isCoachFilter == false ||
              constClientVariable != null ||
              constClientSearchVariable != null
          ? registerEndPoint
          : registerCoachEndPoint,
      token: token,
      query: constClientVariable == null || constClientSearchVariable != null
          ? {
              'search': search,
            }
          : null,
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
      query: constExerciseSearchVariable != null
          ? {
              'search': params.searchExercise,
            }
          : null,
    );
    return List<AddExerciseModel>.from(
        (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e)));

    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<AddExerciseModel> updateExercise(AddExerciseParams params) async {

    if (params.isVideo == false && params.isImage == false) {
      final Response f = await dioHelper.put(
          url: '$addExerciseEndPoint${params.exerciseId}/',
          token: token,
          data: FormData.fromMap({
            'exercise_name': params.exerciseName,
            'category': params.exerciseCategory,
            'visibility': params.exerciseVisibility,
          }));
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
  Future<AddExercisePlanModel> addPlan({
    required String planName,
    required String planVisibility,
    required bool isNutrition,
  }) async {
    final Response f = await dioHelper.post(
      url: isNutrition ? addNutritionPlanEndPoint : addExercisePlanEndPoint,
      token: token,
      data: FormData.fromMap(
        {
          'plan_name': planName,
          'visibility': planVisibility,
        },
      ),
    );

    return isNutrition
        ? AddExercisePlanModel.fromNutritionJson(f.data)
        : AddExercisePlanModel.fromExerciseJson(f.data);
  }

  @override
  Future<List<AddExercisePlanModel>> getPlan(GetPlanParams params) async {
    final Response f = await dioHelper.get(
      url: params.isNutrition
          ? addNutritionPlanEndPoint
          : addExercisePlanEndPoint,
      token: token,
      query: constPlanSearchVariable != null
          ? {
              'search': params.searchPlan,
            }
          : null,
    );
    return params.isNutrition
        ? List<AddExercisePlanModel>.from((f.data['results'] as List)
            .map((e) => AddExercisePlanModel.fromNutritionJson(e)))
        : List<AddExercisePlanModel>.from((f.data['results'] as List)
            .map((e) => AddExercisePlanModel.fromExerciseJson(e)));
    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<AddExercisePlanModel> updatePlan(AddPlanParams params) async {
    final Response f = await dioHelper.put(
        url: params.isNutrition == true? '$addNutritionPlanEndPoint${params.exercisePlanId}/' : '$addExercisePlanEndPoint${params.exercisePlanId}/',
        token: token,
        data: FormData.fromMap({
          'plan_name': params.planName,
          'visibility': params.planVisibility,
        })
    );
    return params.isNutrition == true?
     AddExercisePlanModel.fromNutritionJson(f.data) : AddExercisePlanModel.fromExerciseJson(f.data);
  }

  @override
  Future<void> deletePlan(params) async {
    await dioHelper.delete(
      url: params.isNutrition == true ?'$addNutritionPlanEndPoint${params.exercisePlanId}/' : '$addExercisePlanEndPoint${params.exercisePlanId}/',
      token: token,
    );
  }

  @override
  Future<ExerciseDetailsModel> addExerciseDetails(
      ExerciseDetailsParams params) async {
    final Response f = await dioHelper
        .post(url: addExerciseDetailsEndPoint, token: token, data: {
      'exercise': params.exerciseId,
      'exercise_plan': params.planId,
      'sets': params.sets,
      'reps': params.reps,
      'rest': params.rest,
      'day': params.day,
    });
    return ExerciseDetailsModel.fromJson(f.data);
  }

  @override
  Future<List<ExerciseDetailsModel>> getExerciseDetails(
      GetExercisePlanDetailsParams params) async {
    final Response f = await dioHelper.get(
      url: addExerciseDetailsEndPoint,
      token: token,
    );
    return List<ExerciseDetailsModel>.from((f.data['results'] as List)
        .map((e) => ExerciseDetailsModel.fromJson(e)));
    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<void> deleteExercisePlanDetails(params) async {
    await dioHelper.delete(
      url: '$addExerciseDetailsEndPoint${params.exercisePlanDetailsId}/',
      token: token,
    );
  }


  @override
  Future<AddNutritionModel> addNutrition({
    required int fat,
    required int carb,
    required int protein,
    required int calories,
    required String? howToPrepare,
    required Map component,
    required File nutritionPic,
    required String nutritionCategory,
    required String nutritionName,
    required String nutritionVisibility,
  }) async {
    final Response f = await dioHelper
        .post(
        url: addNutritionEndPoint,
        token: token,
        data: FormData.fromMap({
          'nutrition_name': nutritionName,
          'nutrition_category': nutritionCategory,
          'component': json.encode(component),
          'calories': calories,
          'protein': protein,
          'how_to_prepare': howToPrepare,
          'carb': carb,
          'fat': fat,
          'visibility': nutritionVisibility,
          'nutrition_pic': await MultipartFile.fromFile(
            nutritionPic.path,
            filename: Uri.file(nutritionPic.path).pathSegments.last,),
        }));
    return AddNutritionModel.fromJson(f.data);
  }


}
