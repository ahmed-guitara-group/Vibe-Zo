//Verify Code Use Case

import '../../data/data_source/register_phone_remote_data_source.dart';
import '../../data/models/register_phone_model/register_phone_model.dart';
import '../repos/register_phone_repo.dart';

abstract class UseCase<type> {
  Future<SendCodeResponse> call(String code, String token);
}

class SendCodeUseCase extends UseCase<RegisterPhoneModel> {
  final SendCodeRepo sendCodeRepo;
  SendCodeUseCase(this.sendCodeRepo);

  @override
  Future<SendCodeResponse> call(String type, String token) async {
    return await sendCodeRepo.sendCode(type, token);
  }
}
