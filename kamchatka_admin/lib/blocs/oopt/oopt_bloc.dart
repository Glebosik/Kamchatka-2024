import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_table/data/data_repository.dart';
import 'package:uni_table/data/models/models.dart';

part 'oopt_event.dart';
part 'oopt_state.dart';

class OoptBloc extends Bloc<OoptEvent, OoptState> {
  final DataRepository repository;
  List<Oopt> oopts = [];
  OoptBloc({required this.repository}) : super(OoptInitial()) {
    on<OoptEvent>((event, emit) {});
    on<OoptsUpdate>((event, emit) async {
      emit(OoptsLoading());
      try {
        oopts = await repository.getOopts();
        emit(OoptsLoaded(oopts: oopts));
      } catch (e) {
        emit(OoptsLoaded(oopts: oopts));
      }
    });
  }
}
