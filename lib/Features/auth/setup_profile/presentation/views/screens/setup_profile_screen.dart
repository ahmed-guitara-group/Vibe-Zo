import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../manager/setup_profile_ui/setup_profile_cubit.dart';
import 'setup_profile_screen_step_one.dart';
import 'setup_profile_screen_step_two.dart';

class SetupProfileScreen extends StatelessWidget {
  const SetupProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<SetupProfileUiCubit, SetupProfileUIState>(
        builder: (context, state) {
          if (state is SetupProfileInitial || state is SetupProfileStepOne) {
            return const SetupProfileScreenStepOne();
          } else if (state is SetupProfileStepTwo) {
            return const SetupProfileScreenStepTwo();
          } else {
            return const SetupProfileScreenStepOne();
          }
        },
      ),
    );
  }
}
