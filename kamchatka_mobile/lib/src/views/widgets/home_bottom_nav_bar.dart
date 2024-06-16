import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeNavigationBloc homeNavigationBloc =
        context.read<HomeNavigationBloc>();
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //selectedItemColor: ColorName.orange,
      //unselectedItemColor: ColorName.hyperlinkOrange,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 10,
      currentIndex: homeNavigationBloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          label: 'Главная',
          icon: Assets.icons.home.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Карта',
          icon: Assets.icons.map.svg(),
        ),
        BottomNavigationBarItem(
          label: 'Профиль',
          icon: Assets.icons.profile.svg(),
        ),
      ],
      onTap: (index) {
        homeNavigationBloc.add(PageTapped(index));
      },
    );
  }
}
