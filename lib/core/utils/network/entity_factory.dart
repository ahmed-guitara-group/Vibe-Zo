import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';

import '../../../Features/auth/login/data/models/login_model/login_model.dart';
import 'base_response/general_response.dart';
import 'net_response.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (T.toString() == "BaseResponse") {
      return BaseResponse.fromJson(json) as T;
    } else if (T.toString() == "GeneralResponse") {
      return GeneralResponse.fromJson(json) as T;
    } else if (T.toString() == "LoginModel") {
      return LoginModel.fromJson(json) as T;
    } else if (T.toString() == "RegisterPhoneModel") {
      return RegisterPhoneModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
