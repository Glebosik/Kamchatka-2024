part of 'home_navigation_bloc.dart';

sealed class HomeNavigationEvent extends Equatable {
  const HomeNavigationEvent();

  @override
  List<Object> get props => [];
}

final class PageTapped extends HomeNavigationEvent {
  final int index;

  const PageTapped(this.index);
  @override
  List<Object> get props => [index];
}

final class UpdateApplications extends HomeNavigationEvent {}
