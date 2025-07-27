part of 'setup_profile_cubit.dart';

@immutable
sealed class SetupProfileState {}

final class SetupProfileInitial extends SetupProfileState {}

final class SetupProfileStepOne extends SetupProfileState {}

final class SetupProfileStepTwo extends SetupProfileState {}

class SetupProfileStepOneDataSaved extends SetupProfileState {}
