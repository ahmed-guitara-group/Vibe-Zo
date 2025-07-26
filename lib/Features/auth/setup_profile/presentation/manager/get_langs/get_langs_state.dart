part of 'get_langs_cubit.dart';

@immutable
sealed class GetLangsState {}

final class GetLangsInitial extends GetLangsState {}

class GetLangsLoading extends GetLangsState {
  GetLangsLoading();
}

class GetLangsSuccessful extends GetLangsState {
  final CountriesModel user;

  GetLangsSuccessful(this.user);
}

class GetLangsFailed extends GetLangsState {
  final String message;
  GetLangsFailed(this.message);
}
