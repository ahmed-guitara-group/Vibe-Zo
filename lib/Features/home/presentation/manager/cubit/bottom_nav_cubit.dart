import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/Features/chat/presentation/manager/get_all_chats/get_all_chats_cubit.dart';
import 'package:vibe_zo/Features/chat/presentation/views/chat_screen.dart';

import '../../../../../core/utils/functions/setup_service_locator.dart';
import '../../screens/home_screen.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());

  int bottomNavIndex = 0;
  bool drawerIsOpen = false;
  late String? messageId;
  List<Widget> bottomNavScreens = [
    //THREE BOTTOM NAV ITEMS
    HomeScreen(),

    MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<GetAllChatsCubit>())],
      child: ChatScreen(),
    ),

    HomeScreen(), HomeScreen(),
  ];

  Widget get selectedBottomNavScreen => bottomNavScreens[bottomNavIndex];

  ListQueue<int> navigationQueue = ListQueue();

  void updateBottomNavIndex(int value) {
    emit(BottomNavInitial());
    bottomNavIndex = value;
    emit(BottomNavIsChanging());
  }

  void changeDrawerState(bool value) {
    emit(BottomNavInitial());
    drawerIsOpen = value;
    emit(DrawerState());
  }

  void getMessageId(String value) {
    emit(BottomNavInitial());
    messageId = value;
    emit(BottomNavIsChanging());
  }
}
