import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/domain/use_cases/send_code_use_case.dart';

import '../../../data/models/send_code_model/send_code_model.dart';

part 'send_code_state.dart';

class SendCodeCubit extends Cubit<SendCodeState> {
  SendCodeUseCase sendCodeRequest;
  SendCodeCubit(this.sendCodeRequest) : super(SendCodeInitial());

  Future<void> sendCode(String token, String type) async {
    emit(SendCodeLoading());
    final result = await sendCodeRequest.call(token, type);

    emit(result.fold(SendCodeFailed.new, SendCodeSuccessful.new));
  }
}
