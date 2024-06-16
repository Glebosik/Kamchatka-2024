import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/views/oopt/bloc/oopt_bloc.dart';
import 'package:kamchatka/src/views/oopt/state_view/oopt_error.dart';
import 'package:kamchatka/src/views/oopt/state_view/oopt_loading.dart';
import 'package:kamchatka/src/views/oopt/state_view/oopt_success.dart';

class OoptView extends StatelessWidget {
  const OoptView({super.key});

  static const routeName = '/oopt';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<OoptBloc, OoptState>(
        builder: (context, state) {
          switch (state) {
            case OoptLoading():
              return const OoptLoadingView();
            case OoptError():
              return const OoptErrorView();
            case OoptSuccess():
              return OoptSuccessView(
                oopts: state.oopts,
              );
          }
        },
      ),
    );
  }
}
