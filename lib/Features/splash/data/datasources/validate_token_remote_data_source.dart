import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vibe_zo/Features/splash/data/models/validate_token_model/validate_token_model.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../../domain/entity/login_entity.dart';

typedef ValidateTokenResponse = Either<String, LoginEntity>;

abstract class ValidateTokenRemoteDataSource {
  Future<ValidateTokenResponse> validateToken(String token);
}

class ValidateTokenRemoteDataSourceImpl extends ValidateTokenRemoteDataSource {
  @override
  Future<ValidateTokenResponse> validateToken(String token) async {
    ValidateTokenResponse validateTokenResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<ValidateTokenModel>(
      Method.post,
      // params: body,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Authorization': 'Bearer $token'},
      ),
      url: Api.doServerCheckTokenApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          validateTokenResponse = right(data);
        } else {
          validateTokenResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        validateTokenResponse = left(code.toString());
      },
    );
    return validateTokenResponse;
  }
}
