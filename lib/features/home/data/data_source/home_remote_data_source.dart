import 'package:dio/dio.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/data/models/search_model.dart';
import 'package:gymawy/features/home/data/models/update_coach_model.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';

abstract class HomeBaseDataSource {
  Future<UpdateModel> updateCoachProfile({required UpdateProfileParams params});

  Future<UpdateModel> updateCoachProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<UpdateModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<List<SearchModel>> search({
    required String search,
  });
}

class HomeDataSourceImpl implements HomeBaseDataSource {
  final DioHelper dioHelper;

  HomeDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<UpdateModel> updateCoachProfile(
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
  Future<UpdateModel> updateCoachProfilePicture(
      {required UpdateProfilePictureParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: isCoachLogin! ? updateCoachEndPoint : updateClientsEndPoint,
      data: {
        'profile_picture': params.image,
      },
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
      url: isCoachFilter == false? registerEndPoint : registerCoachEndPoint,
      token: isCoachFilter == false ? token: null,
      query: {
        'search': search,
      },
    );
    return List<SearchModel>.from(
        (f.data['results'] as List).map((e) => SearchModel.fromJson(e)));
  }
}
