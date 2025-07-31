import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';
import 'package:vibe_zo/Features/chat/data/models/get_all_chats_model/get_all_chats_model.dart';

import '../../../Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';
import '../../../Features/auth/setup_profile/data/models/languages_model/languages_model.dart';
import '../../../Features/auth/setup_profile/data/models/setup_profile_model/setup_profile_model.dart';
import '../../../Features/chat/data/models/create_or_get_chat_model/create_or_get_chat_model.dart';
import '../../../Features/chat/data/models/get_chat_messages_model/get_chat_messages_model.dart';
import '../../../Features/chat/data/models/send_message_model/send_message_model.dart';
import '../../../Features/splash/data/models/validate_token_model/validate_token_model.dart';
import 'base_response/general_response.dart';
import 'net_response.dart';

class EntityFactory {
  static T? generateOBJ<T>(json) {
    if (T.toString() == "BaseResponse") {
      return BaseResponse.fromJson(json) as T;
    } else if (T.toString() == "GeneralResponse") {
      return GeneralResponse.fromJson(json) as T;
    } else if (T.toString() == "RegisterPhoneModel") {
      return RegisterPhoneModel.fromJson(json) as T;
    } else if (T.toString() == "SendCodeModel") {
      return SendCodeModel.fromJson(json) as T;
    } else if (T.toString() == "CountriesModel") {
      return CountriesModel.fromJson(json) as T;
    } else if (T.toString() == "SetupProfileModel") {
      return SetupProfileModel.fromJson(json) as T;
    } else if (T.toString() == "ValidateTokenModel") {
      return ValidateTokenModel.fromJson(json) as T;
    } else if (T.toString() == "GetAllChatsModel") {
      return GetAllChatsModel.fromJson(json) as T;
    } else if (T.toString() == "CreateOrGetChatModel") {
      return CreateOrGetChatModel.fromJson(json) as T;
    } else if (T.toString() == "GetChatMessagesModel") {
      return GetChatMessagesModel.fromJson(json) as T;
    } else if (T.toString() == "SendMessageModel") {
      return SendMessageModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
