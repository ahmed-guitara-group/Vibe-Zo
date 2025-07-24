//Verify Code Use Case

import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../data/data_source/register_phone_remote_data_source.dart';
import '../repos/register_phone_repo.dart';

abstract class UseCase<type> {
  Future<SendCodeResponse> call(String code, String token);
}

class VerifyCodeUseCase extends UseCase<SendCodeModel> {
  final VerifyCodeRepo verifyCodeRepo;
  VerifyCodeUseCase(this.verifyCodeRepo);

  @override
  Future<SendCodeResponse> call(String code, String token) async {
    return await verifyCodeRepo.verifyCode(code, token);
  }
}
