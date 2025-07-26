import '../../domain/repositories/login_repo.dart';
import '../data_sources/remote_data_source/login_remote_data_source.dart';

class LoginRepoImpl extends LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl(this.loginRemoteDataSource);

  @override
  Future<LoginResponse> login(
    String token,
    String password,
    String phone,
  ) async {
    var response = await loginRemoteDataSource.login(token, password, phone);
    return response;
  }
}
