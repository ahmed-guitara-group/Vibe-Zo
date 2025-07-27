part of 'setup_profile_cubit.dart';

@immutable
sealed class SetupProfileUIState {}

final class SetupProfileInitial extends SetupProfileUIState {}

final class SetupProfileStepOne extends SetupProfileUIState {}

final class SetupProfileStepTwo extends SetupProfileUIState {}

class SetupProfileStepOneDataSaved extends SetupProfileUIState {}
