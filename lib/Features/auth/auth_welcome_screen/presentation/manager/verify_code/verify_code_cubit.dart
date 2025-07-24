import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/send_code_model/send_code_model.dart';

import '../../../domain/use_cases/verify_code_use_case.dart';

part 'verify_code_state.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeUseCase verifyCodeRequest;
  VerifyCodeCubit(this.verifyCodeRequest) : super(VerifyCodeInitial());

  Future<void> verifyCode(String token, String code) async {
    emit(VerifyCodeLoading());
    final result = await verifyCodeRequest.call(token, code);

    emit(result.fold(VerifyCodeFailed.new, VerifyCodeSuccessful.new));
  }
}
