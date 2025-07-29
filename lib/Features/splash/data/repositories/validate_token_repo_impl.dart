import 'package:vibe_zo/Features/splash/data/datasources/validate_token_remote_data_source.dart';

import '../../domain/repositories/validate_token_repo.dart';

class ValidateTokenRepoImpl extends ValidateTokenRepo {
  final ValidateTokenRemoteDataSource validateTokenRemoteDataSource;

  ValidateTokenRepoImpl(this.validateTokenRemoteDataSource);

  @override
  Future<ValidateTokenResponse> validateToken(String token) async {
    var userData = await validateTokenRemoteDataSource.validateToken(token);
    return userData;
  }
}
