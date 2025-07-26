part of 'get_countries_cubit.dart';

@immutable
sealed class GetCountriesState {}

final class GetCountriesInitial extends GetCountriesState {}

final class ShowAllCountriesState extends GetCountriesState {}

class GetCountriesLoading extends GetCountriesState {
  GetCountriesLoading();
}

class GetCountriesSuccessful extends GetCountriesState {
  final CountriesModel user;

  GetCountriesSuccessful(this.user);
}

class GetCountriesFailed extends GetCountriesState {
  final String message;
  GetCountriesFailed(this.message);
}
