part of 'oopt_bloc.dart';

sealed class OoptState extends Equatable {
  const OoptState();

  @override
  List<Object> get props => [];
}

final class OoptInitial extends OoptState {}

final class OoptsLoading extends OoptState {}

final class OoptsLoaded extends OoptState {
  final List<Oopt> oopts;

  const OoptsLoaded({required this.oopts});
  @override
  List<Object> get props => [oopts];
}
