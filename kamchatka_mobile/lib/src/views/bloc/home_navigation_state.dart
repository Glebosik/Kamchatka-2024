part of 'home_navigation_bloc.dart';

sealed class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

final class HomeNavigationInitial extends HomeNavigationState {}

final class MainPageLoading extends HomeNavigationState {}

final class MainPageLoaded extends HomeNavigationState {
  final List<Oopt> oopts;

  const MainPageLoaded({required this.oopts});

  @override
  List<Object> get props => [oopts];
}

final class MapPageLoaded extends HomeNavigationState {
  final List<Oopt> oopts;
  final List<MapObject<dynamic>> mapObjects;
  const MapPageLoaded({
    required this.oopts,
    required this.mapObjects,
  });
  @override
  List<Object> get props => [oopts];
}

final class MapPageLoading extends HomeNavigationState {}

final class ProfilePageLoading extends HomeNavigationState {}

final class ProfilePageLoaded extends HomeNavigationState {
  final User user;
  final List<Application> applications;
  const ProfilePageLoaded({required this.user, required this.applications});
  @override
  List<Object> get props => [user, applications];
}

final class ProfilePageFailed extends HomeNavigationState {}
