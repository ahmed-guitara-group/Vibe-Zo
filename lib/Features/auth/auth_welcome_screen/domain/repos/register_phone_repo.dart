import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/data_source/register_phone_remote_data_source.dart';

abstract class RegisterPhoneRepo {
  Future<RegisterPhoneResponse> registerPhone(String phone);
}

abstract class SendCodeRepo {
  Future<SendCodeResponse> sendCode(String token, String type);
}

abstract class VerifyCodeRepo {
  Future<SendCodeResponse> verifyCode(String code, String type);
}
