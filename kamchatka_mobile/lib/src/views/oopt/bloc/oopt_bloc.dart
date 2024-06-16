// ignore_for_file: unused_import

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:latlong2/latlong.dart';

part 'oopt_event.dart';
part 'oopt_state.dart';

class OoptBloc extends Bloc<OoptEvent, OoptState> {
  OoptBloc() : super(const OoptSuccess([])) {
    on<OoptEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
