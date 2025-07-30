import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../core/utils/network/api/network_api.dart';
import '../../../../../core/utils/network/network_request.dart';
import '../../../../../core/utils/network/network_utils.dart';
import '../models/setup_profile_model/setup_profile_model.dart';

typedef SetupProfileResponse = Either<String, SetupProfileModel>;

abstract class SetupProfileRemoteDataSource {
  Future<SetupProfileResponse> setupProfile({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  });
}

class SetupProfileRemoteDataSourceImpl extends SetupProfileRemoteDataSource {
  @override
  Future<SetupProfileResponse> setupProfile({
    required String userName,
    required String name,
    required String birthDate,
    required String gender,
    required List<String> spokenLanguages,
    required List<String> countries,
    required File photo,
    required String token,
  }) async {
    SetupProfileResponse responseResult = left("حدث خطأ أثناء رفع البيانات");
    // var body = {
    //   'username': userName,
    //   'name': name,
    //   'birthDate': birthDate,
    //   'gender': gender,
    //   'speakLanguage': spokenLanguages.join(','),
    //   'country': countries.join(','),
    //   'photo': await MultipartFile.fromFile(
    //     photo.path,
    //     filename: photo.path.split('/').last,
    //   ),
    // };

    try {
      final formData = FormData.fromMap({
        'username': userName,
        'name': name,
        'birthDate': birthDate,
        'gender': gender,
        'speakLanguage': jsonEncode(spokenLanguages),
        'country': jsonEncode(countries),
        'photo': await MultipartFile.fromFile(
          photo.path,
          filename: photo.path.split('/').last,
        ),
      });
      await getIt<NetworkRequest>().requestFutureData<SetupProfileModel>(
        Method.post,
        url: Api.doServerAddDataApiCall,
        //  params: body,
        isFormData: true,
        formData: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer $token'},
        ),
        onSuccess: (data) {
          if (data.status == true) {
            responseResult = right(data);
          } else {
            responseResult = left(data.message ?? "حدث خطاء");
          }
        },
        onError: (code, msg) {
          responseResult = left(msg);
        },
      );
    } catch (e) {
      responseResult = left("Exception: ${e.toString()}");
    }

    return responseResult;
  }
}
