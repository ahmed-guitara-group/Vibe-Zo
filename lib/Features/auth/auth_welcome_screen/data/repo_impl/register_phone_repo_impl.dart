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
