import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/widgets/check_in_body_first.dart';
import 'package:kamchatka/src/views/home/children/check_in/widgets/check_in_body_fail.dart';
import 'package:kamchatka/src/views/home/children/check_in/widgets/check_in_body_loading.dart';

class CheckInView extends StatelessWidget {
  const CheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckInBloc, CheckInState>(
      builder: (context, state) {
        switch (state) {
          case CheckInInitial():
          case CheckKnoLoading():
            return const CheckInBodyLoading();
          case CheckInKnoLoaded():
            return CheckInBodyFirst(oopts: state.oopts);
          case CheckKnoLoadingFail():
            return const CheckInFail();
        }
      },
    );
  }
}
