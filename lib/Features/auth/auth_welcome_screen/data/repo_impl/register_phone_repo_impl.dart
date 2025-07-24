import '../../domain/repos/register_phone_repo.dart';
import '../data_source/register_phone_remote_data_source.dart';

class RegisterPhoneRepoImpl extends RegisterPhoneRepo {
  final RegisterPhoneRemoteDataSource registerPhoneRemoteDataSource;

  RegisterPhoneRepoImpl(this.registerPhoneRemoteDataSource);

  @override
  Future<RegisterPhoneResponse> registerPhone(String phone) async {
    var userData = await registerPhoneRemoteDataSource.registerPhone(phone);
    return userData;
  }
}

class SendCodeRepoImpl extends SendCodeRepo {
  final SendCodeRemoteDataSource sendCodeRemoteDataSource;

  SendCodeRepoImpl(this.sendCodeRemoteDataSource);

  @override
  Future<SendCodeResponse> sendCode(String type, String token) async {
    var response = await sendCodeRemoteDataSource.sendCode(type, token);
    return response;
  }
}
