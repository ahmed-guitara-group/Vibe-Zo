import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_zo/core/utils/helper.dart';

import '../../../../core/utils/constants.dart';
import '../manager/cubit/bottom_nav_cubit.dart';

class BottomNavWidget extends StatelessWidget {
  const BottomNavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          // appBar: PreferredSize(
          //   preferredSize: const Size.fromHeight(60),
          //   child: CustomHomeAppBar(tapHandler: () {}),
          // ),
          appBar: AppBar(),
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: false,
            //  backgroundColor: Colors.red,
            // fixedColor: kPrimaryColor,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kGreyTextColor,
            onTap: (value) {
              BlocProvider.of<BottomNavCubit>(
                context,
              ).updateBottomNavIndex(value);
            },
            currentIndex: BlocProvider.of<BottomNavCubit>(
              context,
            ).bottomNavIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: context.locale.translate("more")!,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: context.locale.translate("more")!,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: context.locale.translate("more")!,
              ),
            ],
          ),
          body: context.watch<BottomNavCubit>().selectedBottomNavScreen,
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
