import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/languages_model/languages_model.dart';
import '../../../domain/use_cases/get_countries_use_case.dart';

part 'get_countries_state.dart';

class GetCountriesCubit extends Cubit<GetCountriesState> {
  final GetCountriesUseCase getCountriesUseCase;

  GetCountriesCubit(this.getCountriesUseCase) : super(GetCountriesInitial());
  Future<void> getCountries({required String endPoint}) async {
    emit(GetCountriesLoading());
    final result = await getCountriesUseCase.call(endPoint);

    emit(result.fold(GetCountriesFailed.new, GetCountriesSuccessful.new));
  }
}
