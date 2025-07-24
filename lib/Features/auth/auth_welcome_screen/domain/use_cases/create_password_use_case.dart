//Verify Code Use Case

import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../data/data_source/register_phone_remote_data_source.dart';
import '../repos/register_phone_repo.dart';

abstract class UseCase<type> {
  Future<CreatePasswordResponse> call(String password, String token);
}

class CreatePasswordUseCase extends UseCase<SendCodeModel> {
  final CreatePasswordRepo createPasswordRepo;
  CreatePasswordUseCase(this.createPasswordRepo);

  @override
  Future<SendCodeResponse> call(String password, String token) async {
    return await createPasswordRepo.createPassword(password, token);
  }
}
