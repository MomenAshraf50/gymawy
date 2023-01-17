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
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';

import '../../../../core/util/widgets/progress.dart';
import '../../domain/usecase/add_exercise_usecase.dart';

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
          )}
        ),
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
      url: isCoachFilter == false ? registerEndPoint : registerCoachEndPoint,
      token: token,
      query: {
        'search': search,
      },
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
        query:
        {
          'owner': id,
        },
        data: FormData.fromMap({
          'certificate_name': certificateName,
          'certificate_file': await MultipartFile.fromFile(
              certificateFile.files.first.path!,
              filename: Uri.file(certificateFile.files.first.path!)
                  .pathSegments
                  .last
          ),
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
    final Response f = await dioHelper.put(
      url: '$certificateEndPoint${params.certificateId}/',

      data: {
        'certificate_name': params.certificateName,
         'date' : params.certificateDate
      },
      token: token,
    );

    return CertificateModel.fromJson(f.data);
  }

  @override
  Future<AddExerciseModel> addExercise({
        required String exerciseName,
        required String exerciseCategory,
        required String exerciseVisibility,
        required File exercisePic,
        required FilePickerResult exerciseVideo,
      }
      ) async {
        final Response f = await dioHelper.post(
          url: addExerciseEndPoint,
          token: token,
          data: FormData.fromMap({
              'exercise_name': exerciseName,
              'category' : exerciseCategory,
              'exercise_pic' : await MultipartFile.fromFile(
                exercisePic.path,
                filename: Uri.file(exercisePic.path).pathSegments.last,
              ),
              'exercise_vid' : await MultipartFile.fromFile(
                  exerciseVideo.files.first.path!,
                  filename: Uri.file(exerciseVideo.files.first.path!
                  )
                      .pathSegments
                      .last
              ),
              'visibility' : exerciseVisibility,
          }),
          isMultipart: true,
          progressCallback: (int count, int total)
          {
            debugPrintFullText('progress this request is ${count ~/ total * 100}%');
          }
        );

    return AddExerciseModel.fromJson(f.data);
  }

}
