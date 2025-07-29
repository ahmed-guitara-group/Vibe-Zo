import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'validate_token_state.dart';

class ValidateTokenCubit extends Cubit<ValidateTokenState> {
  ValidateTokenCubit() : super(ValidateTokenInitial());
}
