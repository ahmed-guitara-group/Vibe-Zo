part of 'auth_bottom_sheet_cubit.dart';

@immutable
sealed class AuthBottomSheetState {}

final class AuthBottomSheetInitial extends AuthBottomSheetState {}

final class AuthBottomSheetChanged extends AuthBottomSheetState {
  final String activePageRoute;
  AuthBottomSheetChanged({required this.activePageRoute});
}
