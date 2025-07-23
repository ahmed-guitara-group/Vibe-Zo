import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/api/network_api.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/register_phone_model/register_phone_model.dart';

typedef RegisterPhoneResponse = Either<String, RegisterPhoneModel>;

abstract class RegisterPhoneRemoteDataSource {
  Future<RegisterPhoneResponse> registerPhone(String phone);
}

class RegisterPhoneRemoteDataSourceImpl extends RegisterPhoneRemoteDataSource {
  @override
  Future<RegisterPhoneResponse> registerPhone(String phone) async {
    RegisterPhoneResponse registerPhoneResponse = left("");

    var body = {"phone": phone.trim()};

    await getIt<NetworkRequest>().requestFutureData<RegisterPhoneModel>(
      Method.post,
      params: body,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: Api.doServerRegisterApiCall,
      onSuccess: (data) {
        if (data.status == true) {
          registerPhoneResponse = right(data);
        } else {
          registerPhoneResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        print("HAMADA $code, $msg");
        registerPhoneResponse = left('Error $code, Invalid input');
      },
    );
    return registerPhoneResponse;
  }
}
