import '../../data/datasources/validate_token_remote_data_source.dart';

abstract class ValidateTokenRepo {
  Future<ValidateTokenResponse> validateToken(String token);
}
