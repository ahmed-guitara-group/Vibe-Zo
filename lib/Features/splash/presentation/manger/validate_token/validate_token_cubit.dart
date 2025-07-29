import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vibe_zo/Features/splash/data/models/validate_token_model/validate_token_model.dart';

import '../../../domain/usecases/validate_token_use_case.dart';

part 'validate_token_state.dart';

class ValidateTokenCubit extends Cubit<ValidateTokenState> {
  final ValidateTokenUseCase validateTokenUseCase;

  ValidateTokenCubit(this.validateTokenUseCase) : super(ValidateTokenInitial());

  Future<void> validateToken({required String token}) async {
    emit(ValidateTokenLoading());
    final result = await validateTokenUseCase.call(token);

    emit(result.fold(ValidateTokenFailed.new, ValidateTokenSuccessful.new));
  }
}
