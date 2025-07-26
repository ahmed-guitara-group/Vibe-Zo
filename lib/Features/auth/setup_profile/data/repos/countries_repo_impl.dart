import '../../domain/repos/countries_repo.dart';
import '../data_source/countries_remote_data_source.dart';

class CountriesRepoImpl extends GetCountriesRepo {
  final GetCountriesRemoteDataSource countriesRemoteDataSource;

  CountriesRepoImpl(this.countriesRemoteDataSource);

  @override
  Future<GetCountriesResponse> getCountries(String endpoint) async {
    var userData = await countriesRemoteDataSource.getCountries(endpoint);
    return userData;
  }
}
