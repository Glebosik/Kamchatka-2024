part of 'check_in_bloc.dart';

sealed class CheckInState extends Equatable {
  const CheckInState();

  @override
  List<Object> get props => [];
}

final class CheckInInitial extends CheckInState {}

final class CheckKnoLoading extends CheckInState {}

final class CheckInKnoLoaded extends CheckInState {
  final List<Oopt> oopts;

  const CheckInKnoLoaded({required this.oopts});

  @override
  List<Object> get props => [oopts];
}

class CheckKnoLoadingFail extends CheckInState {}
