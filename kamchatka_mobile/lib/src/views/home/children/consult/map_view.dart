import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/check_in_view.dart';
import 'package:kamchatka/src/views/home/children/consult/map_view_loaded.dart';
import 'package:kamchatka/src/views/home/children/consult/report_view.dart';
import 'package:kamchatka/src/views/widgets/home_bottom_nav_bar.dart';

class MapView extends StatelessWidget {
  const MapView({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: (context, state) {
          switch (state) {
            case HomeNavigationInitial():
            case ProfilePageLoading():
            case ProfilePageLoaded():
            case ProfilePageFailed():
            case MainPageLoading():
            case MainPageLoaded():
            case MapPageLoading():
              return const MapViewLoaded(
                oopts: [],
                mapObjects: [],
              );
            case MapPageLoaded():
              return MapViewLoaded(
                oopts: state.oopts,
                mapObjects: state.mapObjects,
              );
          }
        },
      ),
      floatingActionButton: OutlinedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ReportView()));
          },
          child: Text(
            'Сообщить о проблеме',
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: HomeBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
