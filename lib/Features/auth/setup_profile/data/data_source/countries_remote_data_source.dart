import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../../core/utils/functions/setup_service_locator.dart';
import '../../../../../../core/utils/network/network_request.dart';
import '../../../../../../core/utils/network/network_utils.dart';
import '../models/languages_model/languages_model.dart';

typedef GetCountriesResponse = Either<String, CountriesModel>;

abstract class GetCountriesRemoteDataSource {
  Future<GetCountriesResponse> getCountries(String endpoint);
}

class GetCountriesRemoteDataSourceImpl extends GetCountriesRemoteDataSource {
  @override
  Future<GetCountriesResponse> getCountries(String endpoint) async {
    GetCountriesResponse getCountriesResponse = left("");

    await getIt<NetworkRequest>().requestFutureData<CountriesModel>(
      Method.get,
      options: Options(contentType: Headers.formUrlEncodedContentType),
      url: endpoint,
      onSuccess: (data) {
        if (data.status == true) {
          getCountriesResponse = right(data);
        } else {
          getCountriesResponse = left(data.message!);
        }
      },
      onError: (code, msg) {
        getCountriesResponse = left(code.toString());
      },
    );
    return getCountriesResponse;
  }
}
