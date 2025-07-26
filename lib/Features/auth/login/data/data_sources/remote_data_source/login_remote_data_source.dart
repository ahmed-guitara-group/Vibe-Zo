import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../../../auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';

typedef LoginResponse = Either<String, RegisterPhoneModel>;

abstract class LoginRemoteDataSource {
  Future<LoginResponse> login(String token, String password, String phone);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  @override
  Future<LoginResponse> login(
    String token,
    String password,
    String phone,
  ) async {
    LoginResponse loginResponse = left("");

    var body = {"phone": token, "password": password};

    await getIt<NetworkRequest>().requestFutureData<RegisterPhoneModel>(
      Method.post,
      params: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerLoginApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          loginResponse = right(data);
        } else {
          loginResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        loginResponse = left('Error $code, Invalid input');
      },
    );
    return loginResponse;
  }
}
