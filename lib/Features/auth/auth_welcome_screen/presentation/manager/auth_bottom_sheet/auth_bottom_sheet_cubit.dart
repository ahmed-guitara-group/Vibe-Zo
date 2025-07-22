import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_bottom_sheet_state.dart';

class AuthBottomSheetCubit extends Cubit<AuthBottomSheetState> {
  AuthBottomSheetCubit() : super(AuthBottomSheetInitial());

  void changeBottomSheetState({required String pageRoute}) {
    emit(AuthBottomSheetChanged(activePageRoute: pageRoute));
  }
}
