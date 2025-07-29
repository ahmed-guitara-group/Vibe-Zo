import '../../data/datasources/validate_token_remote_data_source.dart';
import '../../data/models/validate_token_model/validate_token_model.dart';
import '../repositories/validate_token_repo.dart';

abstract class UseCase<type> {
  Future<ValidateTokenResponse> call(String token);
}

class ValidateTokenUseCase extends UseCase<ValidateTokenModel> {
  final ValidateTokenRepo validateTokenRepo;
  ValidateTokenUseCase(this.validateTokenRepo);

  @override
  Future<ValidateTokenResponse> call(String token) async {
    return await validateTokenRepo.validateToken(token);
  }
}
