import '../../data/data_source/countries_remote_data_source.dart';
import '../../data/models/languages_model/languages_model.dart';
import '../repos/countries_repo.dart';

abstract class UseCase<type> {
  Future<GetCountriesResponse> call(String endPoint);
}

class GetCountriesUseCase extends UseCase<CountriesModel> {
  final GetCountriesRepo getCountriesRepo;
  GetCountriesUseCase(this.getCountriesRepo);

  @override
  Future<GetCountriesResponse> call(String endPoint) async {
    return await getCountriesRepo.getCountries(endPoint);
  }
}
