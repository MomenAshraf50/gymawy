import 'package:dio/dio.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import '../../domain/usecase/register_coach_usecase.dart';
import '../../domain/usecase/register_usecase.dart';
import '../models/register_coach_model.dart';
import '../models/register_model.dart';

abstract class RegisterCoachBaseRemoteDataSource {
  final DioHelper dioHelper;

  RegisterCoachBaseRemoteDataSource(this.dioHelper);

  Future<RegisterCoachModel> registerCoach(RegisterCoachParameters registerCoachParameters);
}

class RegisterCoachRemoteDataSource extends RegisterCoachBaseRemoteDataSource {
  RegisterCoachRemoteDataSource(super.dioHelper);

  @override
  Future<RegisterCoachModel> registerCoach(RegisterCoachParameters registerCoachParameters) async {
    final registerCoachResponse = await dioHelper.post(
      url: registerCoachEndPoint,
        data: FormData.fromMap({
      'username': registerCoachParameters.userName,
      'first_name': registerCoachParameters.firstName,
      'last_name': registerCoachParameters.lastName,
      'name': registerCoachParameters.fullName,
      'email': registerCoachParameters.email,
      'profile_picture': await MultipartFile.fromFile(
          registerCoachParameters.profilePicture.path,
          filename: Uri.file(registerCoachParameters.profilePicture.path).pathSegments.last,
      ),
      'bio': registerCoachParameters.bio,
      'phone_number': registerCoachParameters.phoneNumber,
      'gander': registerCoachParameters.gander,
      'fixed_price_month': registerCoachParameters.fixedPrice,
      'country': registerCoachParameters.country,
      'Governorate': registerCoachParameters.governorate,
      'city': registerCoachParameters.city,
      'password1': registerCoachParameters.password,
      'password2': registerCoachParameters.confirmPassword,
      'facebook_link': registerCoachParameters.facebookLink,
      'instagram_link': registerCoachParameters.instagramLink,
      'youtube_link': registerCoachParameters.youtubeLink,
      'tik_tok_link': registerCoachParameters.tiktokLink,
      // 'profile_picture': registerParameters.profilePicture,
    }),
    );

    return RegisterCoachModel.fromJson(registerCoachResponse.data);
  }
}
