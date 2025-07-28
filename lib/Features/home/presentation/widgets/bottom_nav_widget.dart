import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/constants.dart';
import '../manager/cubit/bottom_nav_cubit.dart';
import 'custom_home_app_bar_widget.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.07,
              ),
              child: CustomHomeAppBar(hasSearchIcon: true),
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: false,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: kGreyTextColor,
              onTap: (value) {
                BlocProvider.of<BottomNavCubit>(
                  context,
                ).updateBottomNavIndex(value);
              },
              currentIndex: context.watch<BottomNavCubit>().bottomNavIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: context.locale.translate("more")!,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: "Chat",
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: context.locale.translate("more")!,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: context.locale.translate("more")!,
                ),
              ],
            ),
            body: context.watch<BottomNavCubit>().selectedBottomNavScreen,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
