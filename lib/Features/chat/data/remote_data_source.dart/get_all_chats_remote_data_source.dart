import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../core/utils/network/api/network_api.dart';
import '../../../../core/utils/network/network_request.dart';
import '../../../../core/utils/network/network_utils.dart';
import '../models/create_oro_get_chat_model/create_oro_get_chat_model.dart';
import '../models/get_all_chats_model/get_all_chats_model.dart';

typedef GetAllChatsResponse = Either<String, GetAllChatsModel>;

abstract class GetAllChatsRemoteDataSource {
  Future<GetAllChatsResponse> getAllChats(String token);
}

class GetAllChatsRemoteDataSourceImpl extends GetAllChatsRemoteDataSource {
  @override
  Future<GetAllChatsResponse> getAllChats(String token) async {
    GetAllChatsResponse getAllChatsResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<GetAllChatsModel>(
      Method.get,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerGetAllChatsApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          getAllChatsResponse = right(data);
        } else {
          getAllChatsResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        getAllChatsResponse = left(code.toString());
      },
    );
    return getAllChatsResponse;
  }
}

typedef CreateOrGetChatResponse = Either<String, CreateOrGetChatModel>;

abstract class CreateOrGetChatRemoteDataSource {
  Future<CreateOrGetChatResponse> createOrGet(String token, String toUserId);
}

class CreateOrGetChatRemoteDataSourceImpl extends CreateOrGetChatRemoteDataSource {
  @override

  Future<CreateOrGetChatResponse> createOrGet(
    String token,
    String toUserId,
  ) async {
    CreateOrGetChatResponse createOrGetChatResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<CreateOrGetChatModel>(
      Method.get,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: "${Api.doServerCreateOrGetChatsApiCall}$toUserId",
      onSuccess: (data) {
        if (data.status == true) {
          createOrGetChatResponse = right(data);
        } else {
          createOrGetChatResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        createOrGetChatResponse = left(code.toString());
      },
    );
    return createOrGetChatResponse;
  }
}
