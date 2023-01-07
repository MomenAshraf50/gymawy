import 'package:dio/dio.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/data/models/update_coach_model.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';

abstract class UpdateCoachBaseDataSource {
  Future<UpdateCoachModel> updateCoachProfile(
      {required UpdateCoachProfileParams params});

  Future<UpdateCoachModel> updateCoachProfilePicture(
      {required UpdateCoachProfilePictureParams params});

  Future<UpdateCoachModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});
}

class UpdateCoachDataSourceImpl implements UpdateCoachBaseDataSource {
  final DioHelper dioHelper;

  UpdateCoachDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<UpdateCoachModel> updateCoachProfile(
      {required UpdateCoachProfileParams params}) async {
    final Response f = await dioHelper.put(
      url: updateEndPoint,
      token: token,
      data: {
        'username': params.userName,
        'first_name': params.firstName,
        'last_name': params.lastName,
        'bio': params.bio,
        'name': params.fullName,
        'fixed_price_month': params.fixedPrice,
        'phone_number': params.phone,
        'password': params.password,
        'email': params.email,
      },
    );
    return UpdateCoachModel.fromJson(f.data);
  }

  @override
  Future<UpdateCoachModel> updateCoachProfilePicture(
      {required UpdateCoachProfilePictureParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: updateEndPoint,
      data: {
        'profile_picture': params.image,
      },
    );
    return UpdateCoachModel.fromJson(f.data);
  }

  @override
  Future<UpdateCoachModel> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params}) async {
    final Response f = await dioHelper.put(
      token: token,
      url: updateEndPoint,
      data: {
        'tik_tok_link': params.tiktokLink,
        'youtube_link': params.youtubeLink,
        'facebook_link': params.facebookLink,
        'instagram_link': params.instagramLink,
      },
    );
    return UpdateCoachModel.fromJson(f.data);
  }
}
