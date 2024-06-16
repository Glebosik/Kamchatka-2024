part of 'oopt_bloc.dart';

sealed class OoptState extends Equatable {
  const OoptState();

  @override
  List<Object> get props => [];
}

final class OoptLoading extends OoptState {}

final class OoptError extends OoptState {}

final class OoptSuccess extends OoptState {
  final List<Oopt> oopts;

  const OoptSuccess(this.oopts);

  @override
  List<Object> get props => [oopts];
}
