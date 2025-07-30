import '../../domain/repos/get_all_chat_repo.dart';
import '../remote_data_source.dart/get_all_chats_remote_data_source.dart';

class GetAllChatsRepoImpl extends GetAllChatsRepo {
  final GetAllChatsRemoteDataSource getAllChatsRemoteDataSource;

  GetAllChatsRepoImpl(this.getAllChatsRemoteDataSource);

  @override
  Future<GetAllChatsResponse> getAllChats(String token) async {
    var userData = await getAllChatsRemoteDataSource.getAllChats(token);
    return userData;
  }
}

class CreateOrGetChatRepoImpl extends CreateOrGetChatRepo {
  final CreateOrGetChatRemoteDataSource createOrGetRemoteDataSource;

  CreateOrGetChatRepoImpl(this.createOrGetRemoteDataSource);

  @override
  Future<CreateOrGetChatResponse> createOrGetChat(String token, String toUserID) async {
    var userData = await createOrGetRemoteDataSource.createOrGet(
      token,
      toUserID,
    );
    return userData;
  }
}
