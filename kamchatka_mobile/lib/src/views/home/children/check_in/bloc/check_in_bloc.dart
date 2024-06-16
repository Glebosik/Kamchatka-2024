import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/models/oopt.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  final DataRepository dataClient;

  CheckInBloc({required this.dataClient}) : super(CheckInInitial()) {
    on<CheckInEvent>((event, emit) {});

    on<CheckInFetchOopt>((event, emit) async {
      emit(CheckKnoLoading());
      try {
        emit(CheckKnoLoading());
        final oopts = await dataClient.getOopts();
        emit(CheckInKnoLoaded(oopts: oopts));
      } catch (e) {
        emit(CheckKnoLoadingFail());
      }
    });
  }
}
