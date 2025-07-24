import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/send_code_model/send_code_model.dart';
import '../../../domain/use_cases/create_password_use_case.dart';

part 'create_password_state.dart';

class CreatePasswordCubit extends Cubit<CreatePasswordState> {
  CreatePasswordUseCase createPasswordRequest;

  CreatePasswordCubit(this.createPasswordRequest)
    : super(CreatePasswordInitial());
  Future<void> createPassword(String token, String password) async {
    emit(CreatePasswordLoading());
    final result = await createPasswordRequest.call(token, password);

    emit(result.fold(CreatePasswordFailed.new, CreatePasswordSuccessful.new));
  }
}
