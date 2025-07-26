import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'setup_profile_state.dart';

class SetupProfileCubit extends Cubit<SetupProfileState> {
  SetupProfileCubit() : super(SetupProfileInitial());
}
