import '../../data/data_source/countries_remote_data_source.dart';

abstract class GetCountriesRepo {
  Future<GetCountriesResponse> getCountries(String endpoint);
}
