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

// Verify code

class VerifyCodeRepoImpl extends VerifyCodeRepo {
  final VerifyCodeRemoteDataSource verifyCodeRemoteDataSource;

  VerifyCodeRepoImpl(this.verifyCodeRemoteDataSource);

  @override
  Future<VerifyCodeResponse> verifyCode(String code, String token) async {
    var response = await verifyCodeRemoteDataSource.verifyCode(code, token);
    return response;
  }
}

// create password

class CreatePasswordRepoImpl extends CreatePasswordRepo {
  final CreatePasswordRemoteDataSource createPasswordRemoteDataSource;

  CreatePasswordRepoImpl(this.createPasswordRemoteDataSource);

  @override
  Future<CreatePasswordResponse> createPassword(
    String password,
    String token,
  ) async {
    var response = await createPasswordRemoteDataSource.createPassword(
      password,
      token,
    );
    return response;
  }
}
