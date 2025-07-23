import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/domain/repos/register_phone_repo.dart';

import '../../data/data_source/register_phone_remote_data_source.dart';

abstract class UseCase<type> {
  Future<RegisterPhoneResponse> call(String phone);
}

class RegisterPhoneUseCase extends UseCase<RegisterPhoneModel> {
  final RegisterPhoneRepo registerPhoneRepo;
  RegisterPhoneUseCase(this.registerPhoneRepo);

  @override
  Future<RegisterPhoneResponse> call(String phone) async {
    return await registerPhoneRepo.registerPhone(phone);
  }
}
