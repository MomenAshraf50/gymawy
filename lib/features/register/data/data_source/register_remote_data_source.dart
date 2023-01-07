// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:gymawy/core/network/remote/api_endpoints.dart';
// import 'package:gymawy/core/network/remote/dio_helper.dart';
// import '../models/register_model.dart';
// abstract class RegisterBaseRemoteDataSource {
//   Future<RegisterModel> register({
//     required String userName,
//     required String firstName,
//     required String lastName,
//     required String fullName,
//     required String email,
//     required File profilePicture,
//     required String bio,
//     required String phoneNumber,
//     required String gander,
//     required String country,
//     required String governorate,
//     required String city,
//     required String password,
//     required String confirmPassword,
//     required String age,
//     required int currentWeight,
//     required int currentTall,
//     required int bodyFat,
//   });
// }
//
// class RegisterRemoteDataSourceImpl
//     implements RegisterBaseRemoteDataSource {
//   final DioHelper dioHelper;
//
//   RegisterRemoteDataSourceImpl({
//     required this.dioHelper,
//   });
//
//   @override
//   Future<RegisterModel> register({
//     required String userName,
//     required String firstName,
//     required String lastName,
//     required String fullName,
//     required String email,
//     required File profilePicture,
//     required String bio,
//     required String phoneNumber,
//     required String gander,
//     required String country,
//     required String governorate,
//     required String city,
//     required String password,
//     required String confirmPassword,
//     required String age,
//     required int currentWeight,
//     required int currentTall,
//     required int bodyFat,
//   }) async {
//     final Response f = await dioHelper.post(
//       url: registerEndPoint,
//       data: FormData.fromMap(
//           {
//             'username': userName,
//             'first_name': firstName,
//             'last_name': lastName,
//             'name': fullName,
//             'email': email,
//             'profile_picture': await MultipartFile.fromFile(
//               profilePicture.path,
//               filename: Uri.file(profilePicture.path).pathSegments.last,
//             ),
//             'bio': bio,
//             'phone_number': phoneNumber,
//             'gander': gander,
//             'country': country,
//             'Governorate': governorate,
//             'city': city,
//             'password1': password,
//             'password2': confirmPassword,
//             'age': age,
//             'current_weight': currentWeight,
//             'current_tall': currentTall,
//             'body_fat': bodyFat,
//           }
//       ),
//     );
//     return RegisterModel.fromJson(f.data);
//   }
// }

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
    required String fullName,
    required String email,
    required File profilePicture,
    required String bio,
    required String phoneNumber,
    required String gander,
    required String country,
    required String governorate,
    required String city,
    required String password,
    required String confirmPassword,
    String? age,
    int? currentWeight,
    int? currentTall,
    int? bodyFat,
    int? fixedPrice,
    String? facebookLink,
    String? instagramLink,
    String? youTubeLink,
    String? tikTokLink,
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
    required String fullName,
    required String email,
    required File profilePicture,
    required String bio,
    required String phoneNumber,
    required String gander,
    required String country,
    required String governorate,
    required String city,
    required String password,
    required String confirmPassword,
    String? age,
    int? currentWeight,
    int? currentTall,
    int? bodyFat,
    int? fixedPrice,
    String? facebookLink,
    String? instagramLink,
    String? youTubeLink,
    String? tikTokLink,
  }) async {
    final Response f = await dioHelper.post(
      url: isCoachRegister == false ? registerEndPoint : registerCoachEndPoint,
      data: isCoachRegister == false ?
      FormData.fromMap(
          {
            'username': userName,
            'first_name': firstName,
            'last_name': lastName,
            'name': fullName,
            'email': email,
            'profile_picture': await MultipartFile.fromFile(
              profilePicture.path,
              filename: Uri.file(profilePicture.path).pathSegments.last,
            ),
            'bio': bio,
            'phone_number': phoneNumber,
            'gander': gander,
            'country': country,
            'Governorate': governorate,
            'city': city,
            'password1': password,
            'password2': confirmPassword,
            'age': age,
            'current_weight': currentWeight,
            'current_tall': currentTall,
            'body_fat': bodyFat,
          }
      ) :
      FormData.fromMap(
          {
            'username': userName,
            'first_name': firstName,
            'last_name': lastName,
            'name': fullName,
            'email': email,
            'profile_picture': await MultipartFile.fromFile(
              profilePicture.path,
              filename: Uri.file(profilePicture.path).pathSegments.last,
            ),
            'bio': bio,
            'phone_number': phoneNumber,
            'gander': gander,
            'fixed_price_month': fixedPrice,
            'country': country,
            'Governorate': governorate,
            'city': city,
            'password1': password,
            'password2': confirmPassword,
            'facebook_link': facebookLink,
            'instagram_link': instagramLink,
            'youtube_link': youTubeLink,
            'tik_tok_link': tikTokLink,
          }
      )
      ,
    );
    return RegisterModel.fromJson(f.data);
  }
}

