import 'package:dio/dio.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import '../../domain/usecase/register_usecase.dart';
import '../models/register_model.dart';

abstract class RegisterBaseRemoteDataSource {
  final DioHelper dioHelper;

  RegisterBaseRemoteDataSource(this.dioHelper);

  Future<RegisterModel> register(RegisterParameters registerParameters);
}

class RegisterRemoteDataSource extends RegisterBaseRemoteDataSource {
  RegisterRemoteDataSource(super.dioHelper);

  @override
  Future<RegisterModel> register(RegisterParameters registerParameters) async {
    final registerResponse = await dioHelper.post(url: registerEndPoint,
        data: FormData.fromMap({
      'username': registerParameters.userName,
      'first_name': registerParameters.firstName,
      'last_name': registerParameters.lastName,
      'name': registerParameters.fullName,
      'email': registerParameters.email,
      'profile_picture': await MultipartFile.fromFile(
          registerParameters.profilePicture.path,
          filename: Uri.file(registerParameters.profilePicture.path).pathSegments.last,
      ),
      'bio': registerParameters.bio,
      'phone_number': registerParameters.phoneNumber,
      'gander': registerParameters.gander,
      'country': registerParameters.country,
      'Governorate': registerParameters.governorate,
      'city': registerParameters.city,
      'password1': registerParameters.password,
      'password2': registerParameters.confirmPassword,
      'age': registerParameters.age,
      'current_weight': registerParameters.currentWeight,
      'current_tall': registerParameters.currentTall,
      'body_fat': registerParameters.bodyFat,
      // 'profile_picture': registerParameters.profilePicture,
    }),
    );

    return RegisterModel.fromJson(registerResponse.data);
  }
}
