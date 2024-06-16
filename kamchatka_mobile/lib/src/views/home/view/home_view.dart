// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/home/children/children.dart';
import 'package:kamchatka/src/views/home/children/consult/map_view_loading.dart';
import 'package:kamchatka/src/views/home/children/profile/profile_view_fail.dart';
import 'package:kamchatka/src/views/home/children/profile/profile_view_loading.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    const Key bottomKey = Key('BottomBarKey');
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
      builder: (context, state) {
        switch (state) {
          case HomeNavigationInitial():
          case MainPageLoading():
            return const MainView(bottomKey: bottomKey, oopts: []);
          case MainPageLoaded():
            return MainView(
              bottomKey: bottomKey,
              oopts: state.oopts,
            );
          case ProfilePageLoading():
            return const ProfileViewLoading(
              bottomKey: bottomKey,
            );
          case ProfilePageFailed():
            return const ProfileViewFail(bottomKey: bottomKey);
          case ProfilePageLoaded():
            return ProfileView(
              user: state.user,
              bottomKey: bottomKey,
              applications: state.applications,
            );
          case MapPageLoading():
          case MapPageLoaded():
            return const MapView(
              bottomKey: bottomKey,
            );
        }
      },
    );
  }
}
