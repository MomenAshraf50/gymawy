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
import 'package:gymawy/features/home/data/models/body_measurements_model.dart';
import 'package:gymawy/features/home/data/models/certificate_model.dart';
import 'package:gymawy/features/home/data/models/coach_subscriptions_model.dart';
import 'package:gymawy/features/home/data/models/exercise_details_model.dart';
import 'package:gymawy/features/home/data/models/notifications_model.dart';
import 'package:gymawy/features/home/data/models/profile_model.dart';
import 'package:gymawy/features/home/data/models/search_model.dart';
import 'package:gymawy/features/home/data/models/subscription_request_model.dart';
import 'package:gymawy/features/home/data/models/update_coach_model.dart';
import 'package:gymawy/features/home/data/models/user_plan_model.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/usecase/body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/certification_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_user_plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_subscription_status_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_details.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/user_plan_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import '../../domain/usecase/add_nutrition_details_usecase.dart';
import '../../domain/usecase/add_plan_usecase.dart';
import '../../domain/usecase/add_exercise_usecase.dart';
import '../../domain/usecase/delete_exercise_details_usecase.dart';
import '../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../domain/usecase/delete_subscriptionRequest_usecase.dart';
import '../../domain/usecase/get_exercise_plan_details.dart';
import '../../domain/usecase/get_nutrition_details.dart';
import '../../domain/usecase/get_plan_usecase.dart';
import '../models/plan_model.dart';
import '../models/add_nutrition_details_model.dart';

abstract class HomeBaseDataSource {
  Future<ProfileModel> updateProfile({required UpdateProfileParams params});

  Future<ProfileModel> updateProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<ProfileModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<List<SearchModel>> search({
    required String search,
  });

  Future<ProfileModel> profile({
    required int id,
    bool? isCoach,
  });

  Future<CertificateModel> certificate({
    required CertificateParams params
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

  Future<PlanModel> addPlan({
    required bool isNutrition,
    required String planName,
    required String planVisibility,
  });

  Future<List<PlanModel>> getPlan(GetPlanParams params);

  Future<PlanModel> updatePlan(AddPlanParams params);

  Future<void> deletePlan(DeletePlanParams params);

  Future<ExerciseDetailsModel> addExerciseDetails(ExerciseDetailsParams params);

  Future<List<ExerciseDetailsModel>> getExerciseDetails(
      GetExercisePlanDetailsParams params);

  Future<void> deleteExercisePlanDetails(
      DeleteExercisePlanDetailsParams params);

  Future<AddNutritionModel> addNutrition({
    int? nutritionId,
    required bool update,
    required double fat,
    required double carb,
    required double protein,
    required double calories,
    required String? howToPrepare,
    required Map component,
    File? nutritionPic,
    required String nutritionCategory,
    required String nutritionName,
    required String nutritionVisibility,
  });

  Future<List<AddNutritionModel>> getNutrition(GetNutritionParams params);

  Future<void> deleteNutrition(DeleteNutritionParams params);

  Future<NutritionDetailsModel> addNutritionDetails(
      NutritionDetailsParams params);

  Future<List<NutritionDetailsModel>> getNutritionDetails(
      GetNutritionPlanDetailsParams params);

  Future<SubscriptionRequestModel> subscriptionRequest(
      SubscriptionRequestParams params);

  Future<List<SubscriptionRequestModel>> getSubscriptionRequests(
      GetSubscriptionsRequestsParams params);

  Future<void> deleteSubscriptionRequest(
      DeleteSubscriptionRequestParams params);

  Future<List<NotificationsModel>> getNotifications();

  Future<void> markAsRead(MarkAsReadParams params);

  Future<List<CoachSubscriptionsModel>> getCoachSubscriptions();

  Future<CoachSubscriptionsModel> updateSubscriptionStatus(
      UpdateSubscriptionStatusParams params);

  Future<void> notificationsSubscription(
      NotificationsSubscriptionParams params);

  Future<BodyMeasurementsModel> bodyMeasurements(BodyMeasurementsParams params);

  Future<BodyMeasurementsModel> getBodyMeasurements(
      GetBodyMeasurementsParams params);

  Future<void> deleteBodyMeasurements();

  Future<UserPlanModel> userPlan(UserPlanParams params);

  Future<List<UserPlanModel>> getUserPlan();

  Future<void> deleteUserPlan(DeleteUserPlanParams params);
}

class HomeDataSourceImpl implements HomeBaseDataSource {
  final DioHelper dioHelper;

  HomeDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<ProfileModel> updateProfile(
      {required UpdateProfileParams params}) async {
    final Response f = await dioHelper.put(
      url: isCoachLogin ? updateCoachEndPoint : updateClientsEndPoint,
      token: token,
      data: isCoachLogin
          ? {
              'username': params.userName,
              'bio': params.bio,
              'first_name': params.firstName,
              'last_name': params.lastName,
              'fixed_price_month': params.fixedPrice,
              'phone_number': params.phone,
              if (params.password != null) 'password': params.password,
              'email': params.email,
            }
          : {
              'username': params.userName,
              'bio': params.bio,
              'first_name': params.firstName,
              'last_name': params.lastName,
              'phone_number': params.phone,
              if (params.password != null) 'password': params.password,
              'email': params.email,
            },
    );
    return ProfileModel.fromJson(f.data);
  }

  @override
  Future<ProfileModel> updateProfilePicture(
      {required UpdateProfilePictureParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: isCoachLogin ? updateCoachEndPoint : updateClientsEndPoint,
      data: FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          params.image.path,
        )
      }),
      isMultipart: true,
    );
    return ProfileModel.fromJson(f.data);
  }

  @override
  Future<ProfileModel> updateCoachSocialLinks(
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
    return ProfileModel.fromJson(f.data);
  }

  @override
  Future<List<SearchModel>> search({
    required String search,
  }) async {
    final Response f = await dioHelper.get(
      url: isCoachFilter == false ||
              constClientVariable != null ||
              constClientSearchVariable != null
          ? registerClientEndPoint
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
    required int id,
    bool? isCoach,
  }) async {
    final Response f = await dioHelper.get(
      token: token,
      url:
          //'$registerCoachEndPoint$id/',
          //'$registerEndPoint$id/',
          !isCoachLogin
              ? '$registerClientEndPoint$id/'
              : '$registerCoachEndPoint$id/',
    );
    return ProfileModel.fromJson(f.data);
  }

  @override
  Future<CertificateModel> certificate({
    required CertificateParams params
  }) async {
    final Response f = await dioHelper.post(
      token: token,
      url: certificateEndPoint,
      query: {
        'owner': params.id,
      },
      data: FormData.fromMap({
        'certificate_name': params.certificateName,
        'certificate_file': await MultipartFile.fromFile(
            params.certificateFile.files.first.path!,
            filename:
                Uri.file(params.certificateFile.files.first.path!).pathSegments.last),
        'date': params.certificateDate,
        'certificate_serial': params.certificateSerial,
        'description': params.certificateDescription,
        'expiration_date': params.certificateExpirationDate,
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
        'owner__id': params.ownerId,
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
          'description': params.certificateDescription,
          'expiration_date': params.certificateExpirationDate,
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
            progressValue: count,
            totalValue: total,
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
              progressValue: count,
              totalValue: total,
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
              progressValue: count,
              totalValue: total,
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
              progressValue: count,
              totalValue: total,
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
  Future<PlanModel> addPlan({
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

    return PlanModel.fromJson(f.data);
  }

  @override
  Future<List<PlanModel>> getPlan(GetPlanParams params) async {
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
    return List<PlanModel>.from(
        (f.data['results'] as List).map((e) => PlanModel.fromJson(e)));
  }

  @override
  Future<PlanModel> updatePlan(AddPlanParams params) async {
    final Response f = await dioHelper.put(
        url: params.isNutrition == true
            ? '$addNutritionPlanEndPoint${params.exercisePlanId}/'
            : '$addExercisePlanEndPoint${params.exercisePlanId}/',
        token: token,
        data: FormData.fromMap({
          'plan_name': params.planName,
          'visibility': params.planVisibility,
        }));
    return PlanModel.fromJson(f.data);
  }

  @override
  Future<void> deletePlan(params) async {
    await dioHelper.delete(
      url: params.isNutrition == true
          ? '$addNutritionPlanEndPoint${params.exercisePlanId}/'
          : '$addExercisePlanEndPoint${params.exercisePlanId}/',
      token: token,
    );
  }

  @override
  Future<ExerciseDetailsModel> addExerciseDetails(
      ExerciseDetailsParams params) async {
    final Response f = params.update
        ? await dioHelper.put(
            url: '$addExerciseDetailsEndPoint${params.exerciseDetailId}/',
            token: token,
            data: {
                'sets': params.sets,
                'reps': params.reps,
                'rest': params.rest,
                'day': params.day,
              })
        : await dioHelper
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
      query: {'exercise_plan': params.exercisePlanId},
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
      url: params.isNutrition == false
          ? '$addExerciseDetailsEndPoint${params.exercisePlanDetailsId}/'
          : '$addNutritionDetailsEndPoint${params.exercisePlanDetailsId}/',
      token: token,
    );
  }

  @override
  Future<AddNutritionModel> addNutrition({
    int? nutritionId,
    required bool update,
    required double fat,
    required double carb,
    required double protein,
    required double calories,
    required String? howToPrepare,
    required Map component,
    File? nutritionPic,
    required String nutritionCategory,
    required String nutritionName,
    required String nutritionVisibility,
  }) async {
    final Response f = update
        ? await dioHelper.put(
            url: '$addNutritionEndPoint$nutritionId/',
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
              'nutrition_pic': nutritionPic == null
                  ? null
                  : await MultipartFile.fromFile(
                      nutritionPic.path,
                      filename: Uri.file(nutritionPic.path).pathSegments.last,
                    ),
            }))
        : await dioHelper.post(
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
                nutritionPic!.path,
                filename: Uri.file(nutritionPic.path).pathSegments.last,
              ),
            }));
    return AddNutritionModel.fromJson(f.data);
  }

  @override
  Future<List<AddNutritionModel>> getNutrition(
      GetNutritionParams params) async {
    final Response f = await dioHelper.get(
      url: addNutritionEndPoint,
      token: token,
      query: constNutritionSearchVariable != null
          ? {
              'search': params.searchNutrition,
            }
          : null,
    );
    return List<AddNutritionModel>.from(
        (f.data['results'] as List).map((e) => AddNutritionModel.fromJson(e)));
    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<void> deleteNutrition(DeleteNutritionParams params) async {
    await dioHelper.delete(
      url: '$addNutritionEndPoint${params.nutritionId}/',
      token: token,
    );
  }

  @override
  Future<NutritionDetailsModel> addNutritionDetails(
      NutritionDetailsParams params) async {
    final Response f = params.update
        ? await dioHelper.put(
            url: '$addNutritionDetailsEndPoint${params.nutritionDetailId}/',
            token: token,
            data: {
                'day': params.day,
                'meal': params.meal,
                'meal_time': params.time,
              })
        : await dioHelper
            .post(url: addNutritionDetailsEndPoint, token: token, data: {
            'nutrition': params.nutritionId,
            'nutrition_plan': params.planId,
            'day': params.day,
            'meal': params.meal,
            'meal_time': params.time,
          });
    return NutritionDetailsModel.fromJson(f.data);
  }

  @override
  Future<List<NutritionDetailsModel>> getNutritionDetails(
      GetNutritionPlanDetailsParams params) async {
    final Response f = await dioHelper.get(
      url: addNutritionDetailsEndPoint,
      query: {'nutrition_plan': params.nutritionPlanId},
      token: token,
    );
    return List<NutritionDetailsModel>.from((f.data['results'] as List)
        .map((e) => NutritionDetailsModel.fromJson(e)));
    // return List<AddExerciseModel>.from(
    //     (f.data['results'] as List).map((e) => AddExerciseModel.fromJson(e))).where((element) => element.exerciseName =='').toList();
  }

  @override
  Future<SubscriptionRequestModel> subscriptionRequest(
      SubscriptionRequestParams params) async {
    final Response f = params.isUpdate == true
        ? await dioHelper.put(
            url: '$subscriptionRequestEndPoint${params.subscriptionRequest}/',
            token: token,
            data: {
                'state': params.status,
              })
        : await dioHelper
            .post(url: subscriptionRequestEndPoint, token: token, data: {
            'trainer': params.coachId,
            if (params.startDate != null) 'start_date': params.startDate,
            if (params.endDate != null) 'end_date': params.endDate,
          });

    return SubscriptionRequestModel.fromJson(f.data);
  }


  @override
  Future<List<SubscriptionRequestModel>> getSubscriptionRequests(params) async {
    final Response f = await dioHelper
        .get(url: subscriptionRequestEndPoint, token: token, query: {
      if (params.requestState != null) 'state': params.requestState,
      if (params.subscriptionRequestId != null)
        'id': params.subscriptionRequestId
    });

    return List<SubscriptionRequestModel>.from((f.data['results'] as List)
        .map((e) => SubscriptionRequestModel.fromJson(e)));
  }

  @override
  Future<void> deleteSubscriptionRequest(
      DeleteSubscriptionRequestParams params) async {
    await dioHelper.delete(
      url: '$subscriptionRequestEndPoint${params.subscriptionRequestId}/',
      token: token,
    );
  }

  @override
  Future<List<NotificationsModel>> getNotifications() async {
    final Response f = await dioHelper.get(
      url: getNotificationsEndPoint,
      token: token,
    );
    return List<NotificationsModel>.from(
        (f.data['results'] as List).map((e) => NotificationsModel.fromJson(e)));
  }

  @override
  Future<void> markAsRead(MarkAsReadParams params) async {
    await dioHelper.patch(
      url: "$notificationsEndPoint${params.notificationId}$markAsReadEndPoint",
      token: token,
    );
  }

  @override
  Future<List<CoachSubscriptionsModel>> getCoachSubscriptions() async {
    final Response f = await dioHelper.get(
      url: subscriptionEndPoint,
      token: token,
    );
    return List<CoachSubscriptionsModel>.from((f.data['results'] as List)
        .map((e) => CoachSubscriptionsModel.fromJson(e)));
  }

  @override
  Future<CoachSubscriptionsModel> updateSubscriptionStatus(
      UpdateSubscriptionStatusParams params) async {
    final Response f = await dioHelper.put(
        url: '$subscriptionEndPoint${params.subscriptionId}/',
        token: token,
        data: {
          'status': params.status,
          'client': params.clientId,
          'trainer': params.coachId,
        });

    return CoachSubscriptionsModel.fromJson(f.data);
  }

  @override
  Future<void> notificationsSubscription(
      NotificationsSubscriptionParams params) async {
    await dioHelper.post(
      url: params.userLoggedIn
          ? notificationSubscribeEndPoint
          : notificationUnSubscribeEndPoint,
      token: token,
      data: {
        'device_token': params.deviceToken,
      },
    );
  }

  @override
  Future<BodyMeasurementsModel> bodyMeasurements(
      BodyMeasurementsParams params) async {
    final Response f = params.update
        ? await dioHelper.put(
            token: token,
            url: '$bodyMeasurementsEndPoint${params.measurementsId}/',
            data: FormData.fromMap({
              'weight': params.weight,
              'tall': params.tall,
              'body_fat': params.bodyFat,
              if (params.fullBodyPic != null)
                'full_body_pic': await MultipartFile.fromFile(
                    params.fullBodyPic!.path,
                    filename:
                        Uri.file(params.fullBodyPic!.path).pathSegments.last),
              if (params.rightSideBodyPic != null)
                'rightSide_body_pic': await MultipartFile.fromFile(
                  params.rightSideBodyPic!.path,
                  filename:
                      Uri.file(params.rightSideBodyPic!.path).pathSegments.last,
                ),
              if (params.leftSideBodyPic != null)
                'leftSide_body_pic': MultipartFile.fromFile(
                  params.leftSideBodyPic!.path,
                  filename:
                      Uri.file(params.leftSideBodyPic!.path).pathSegments.last,
                ),
              'goal': params.goal,
            }),
          )
        : await dioHelper.post(
            token: token,
            url: bodyMeasurementsEndPoint,
            data: FormData.fromMap({
              'weight': params.weight,
              'tall': params.tall,
              'body_fat': params.bodyFat,
              'full_body_pic': await MultipartFile.fromFile(
                  params.fullBodyPic!.path,
                  filename:
                      Uri.file(params.fullBodyPic!.path).pathSegments.last),
              'rightSide_body_pic': await MultipartFile.fromFile(
                params.rightSideBodyPic!.path,
                filename:
                    Uri.file(params.rightSideBodyPic!.path).pathSegments.last,
              ),
              'leftSide_body_pic': MultipartFile.fromFile(
                params.leftSideBodyPic!.path,
                filename:
                    Uri.file(params.leftSideBodyPic!.path).pathSegments.last,
              ),
              'goal': params.goal,
            }),
          );
    return BodyMeasurementsModel.fromJson(f.data);
  }

  @override
  Future<BodyMeasurementsModel> getBodyMeasurements(
      GetBodyMeasurementsParams params) async {
    final Response f = await dioHelper.get(
      url: '$bodyMeasurementsEndPoint${params.measurementsId}/',
      token: token,
    );

    return BodyMeasurementsModel.fromJson(f.data);
  }

  @override
  Future<void> deleteBodyMeasurements() async {
    await dioHelper.delete(
      url: bodyMeasurementsEndPoint,
      token: token,
    );
  }

  @override
  Future<UserPlanModel> userPlan(UserPlanParams params) async {
    final Response f = params.isUpdate
        ? await dioHelper.put(
            url: userPlanEndPoint,
            token: token,
            data: {
              'client': params.clientId,
              if (params.exercisePlanId != null)
                'exercise_plan': params.exercisePlanId,
              if (params.nutritionPlanId != null)
                'nutrition_plan': params.nutritionPlanId,
            },
          )
        : await dioHelper.post(
            url: userPlanEndPoint,
            token: token,
            data: {
              'client': params.clientId,
              'exercise_plan': params.exercisePlanId,
              'nutrition_plan': params.nutritionPlanId,
            },
          );
    return UserPlanModel.fromJson(f.data);
  }

  @override
  Future<List<UserPlanModel>> getUserPlan() async {
    final Response f = await dioHelper.get(
      url: userPlanEndPoint,
      token: token,
    );

    return List<UserPlanModel>.from(
        (f.data['results'] as List).map((e) => UserPlanModel.fromJson(e)));
  }

  @override
  Future<void> deleteUserPlan(DeleteUserPlanParams params) async {
    await dioHelper.delete(
      url: '$userPlanEndPoint${params.userPlanId}/',
      token: token,
    );
  }
}
