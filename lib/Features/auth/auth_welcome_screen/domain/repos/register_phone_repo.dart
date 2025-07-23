import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/data_source/register_phone_remote_data_source.dart';

abstract class RegisterPhoneRepo {
  Future<RegisterPhoneResponse> registerPhone(String phone);
}
