import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/register_phone_model/register_phone_model.dart';

typedef RegisterPhoneResponse = Either<String, RegisterPhoneModel>;

abstract class RegisterPhoneRemoteDataSource {
  Future<RegisterPhoneResponse> registerPhone(String phone);
}

class RegisterPhoneRemoteDataSourceImpl extends RegisterPhoneRemoteDataSource {
  @override
  Future<RegisterPhoneResponse> registerPhone(String phone) async {
    RegisterPhoneResponse registerPhoneResponse = left("");

    var body = {"phone": phone.trim()};

    await getIt<NetworkRequest>().requestFutureData<RegisterPhoneModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: Api.doServerRegisterApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          registerPhoneResponse = right(data);
        } else {
          registerPhoneResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        registerPhoneResponse = left(code.toString());
      },
    );
    return registerPhoneResponse;
  }
}

//SEND OTP CODE REMOTE DATA SOURCE

typedef SendCodeResponse = Either<String, SendCodeModel>;

abstract class SendCodeRemoteDataSource {
  Future<SendCodeResponse> sendCode(String token, String type);
}

class SendCodeRemoteDataSourceImpl extends SendCodeRemoteDataSource {
  @override
  Future<SendCodeResponse> sendCode(String token, String type) async {
    SendCodeResponse sendCodeResponse = left("");

    var body = {"type": type.trim()};

    await getIt<NetworkRequest>().requestFutureData<SendCodeModel>(
      Method.post,
      params: body,

      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerSendCodeApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          sendCodeResponse = right(data);
        } else {
          sendCodeResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        sendCodeResponse = left(code.toString());
      },
    );
    return sendCodeResponse;
  }
}
