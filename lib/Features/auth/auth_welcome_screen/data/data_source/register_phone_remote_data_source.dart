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

// Verify Code Remote Data Source

typedef VerifyCodeResponse = Either<String, SendCodeModel>;

abstract class VerifyCodeRemoteDataSource {
  Future<VerifyCodeResponse> verifyCode(String token, String code);
}

class VerifyCodeRemoteDataSourceImpl extends VerifyCodeRemoteDataSource {
  @override
  Future<VerifyCodeResponse> verifyCode(String token, String code) async {
    VerifyCodeResponse verifyCodeResponse = left("");

    var body = {"code": code.trim()};

    await getIt<NetworkRequest>().requestFutureData<SendCodeModel>(
      Method.post,
      params: body,

      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerVerifyCodeApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          verifyCodeResponse = right(data);
        } else {
          verifyCodeResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        verifyCodeResponse = left(code.toString());
      },
    );
    return verifyCodeResponse;
  }
}
// Create Password Remote Data Source

typedef CreatePasswordResponse = Either<String, SendCodeModel>;

abstract class CreatePasswordRemoteDataSource {
  Future<CreatePasswordResponse> createPassword(String token, String password);
}

class CreatePasswordRemoteDataSourceImpl
    extends CreatePasswordRemoteDataSource {
  @override
  Future<CreatePasswordResponse> createPassword(
    String token,
    String password,
  ) async {
    VerifyCodeResponse createPasswordResponse = left("");

    var body = {"password": password};

    await getIt<NetworkRequest>().requestFutureData<SendCodeModel>(
      Method.post,
      params: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerCreatePasswordApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          createPasswordResponse = right(data);
        } else {
          createPasswordResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        createPasswordResponse = left(code.toString());
      },
    );
    return createPasswordResponse;
  }
}
