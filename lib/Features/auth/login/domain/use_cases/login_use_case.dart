import '../../../auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';
import '../../data/data_sources/remote_data_source/login_remote_data_source.dart';
import '../repositories/login_repo.dart';

abstract class UseCase<type> {
  Future<LoginResponse> call(String token, String password, String phone);
}

class LoginUseCase extends UseCase<RegisterPhoneModel> {
  final LoginRepo loginRepo;
  LoginUseCase(this.loginRepo);

  @override
  Future<LoginResponse> call(
    String token,
    String password,
    String phone,
  ) async {
    return await loginRepo.login(token, password, phone);
  }
}
