import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/languages_model/languages_model.dart';
import '../../../domain/use_cases/get_countries_use_case.dart';

part 'get_langs_state.dart';

class GetLangsCubit extends Cubit<GetLangsState> {
  GetCountriesUseCase getCountriesUseCase;
  GetLangsCubit(this.getCountriesUseCase) : super(GetLangsInitial());
  Future<void> getLangs({required String endPoint}) async {
    emit(GetLangsLoading());
    final result = await getCountriesUseCase.call(endPoint);

    emit(result.fold(GetLangsFailed.new, GetLangsSuccessful.new));
  }
}
