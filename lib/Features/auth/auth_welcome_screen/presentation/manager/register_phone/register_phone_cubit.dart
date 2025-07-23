import 'package:bloc/bloc.dart';
import 'package:vibe_zo/Features/auth/auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';

import '../../../domain/use_cases/register_phone_use_case.dart';

part 'register_phone_state.dart';

class RegisterPhoneCubit extends Cubit<RegisterPhoneState> {
  final RegisterPhoneUseCase registerPhoneRequest;

  RegisterPhoneCubit(this.registerPhoneRequest) : super(RegisterPhoneInitial());

  Future<void> registerPhone(String phone) async {
    emit(const RegisterPhoneLoading());
    final result = await registerPhoneRequest.call(phone);

    emit(result.fold(RegisterPhoneFailed.new, RegisterPhoneSuccessful.new));
  }
}
