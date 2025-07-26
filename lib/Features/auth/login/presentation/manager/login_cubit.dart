// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../../../auth_welcome_screen/data/models/register_phone_model/register_phone_model.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginRequest;

  LoginCubit(this.loginRequest) : super(LoginInitial());

  Future<void> login({
    required String token,
    required String password,
    required String phone,
  }) async {
    emit(const LoginLoading());
    final result = await loginRequest.call(token, password, phone);

    emit(result.fold(LoginFailed.new, LoginSuccessful.new));
  }
}
