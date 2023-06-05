import 'dart:io';
import 'package:dio/dio.dart';
import 'package:gymawy/core/network/remote/api_endpoints.dart';
import 'package:gymawy/core/network/remote/dio_helper.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../models/register_model.dart';

abstract class RegisterBaseRemoteDataSource {
  Future<RegisterModel> register({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required File profilePicture,
    required String phoneNumber,
    required String gander,
    required String password,
    required String confirmPassword,
    required String city,
    required String country,
    String? age,
    int? fixedPrice,
    int? experience,
  });
}

class RegisterRemoteDataSourceImpl
    implements RegisterBaseRemoteDataSource {
  final DioHelper dioHelper;

  RegisterRemoteDataSourceImpl({
    required this.dioHelper,
  });

  @override
  Future<RegisterModel> register({
    required String userName,
    required String firstName,
    required String lastName,
    required String email,
    required File profilePicture,
    required String phoneNumber,
    required String gander,
    required String password,
    required String confirmPassword,
    required String city,
    required String country,
    String? age,
    int? fixedPrice,
    int? experience,
  }) async {
    final Response f = await dioHelper.post(
      url: !isCoachRegister ? registerClientEndPoint : registerCoachEndPoint,
      data: !isCoachRegister ?
      FormData.fromMap(
          {
            'username': userName,
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'profile_picture': await MultipartFile.fromFile(
              profilePicture.path,
              filename: Uri.file(profilePicture.path).pathSegments.last,
            ),
            'bio': 'Write your bio...',
            'phone': phoneNumber,
            'gander': gander,
            'password': password,
            'age': age,
            'country':country,
            'Governorate':'',
            'city':city,
          }
      ) :
      FormData.fromMap(
          {
            'username': userName,
            'first_name': firstName,
            'last_name': lastName,
            'email': email,
            'profile_picture': await MultipartFile.fromFile(
              profilePicture.path,
              filename: Uri.file(profilePicture.path).pathSegments.last,
            ),
            'bio': 'Write your bio...',
            'phone': phoneNumber,
            'gander': gander,
            'price': fixedPrice,
            'password': password,
            'experience': experience,
            'country':country,
            'Governorate':'',
            'city':city,
          }
      ),
      isMultipart: true,
    );
    return RegisterModel.fromJson(f.data);
  }
}

