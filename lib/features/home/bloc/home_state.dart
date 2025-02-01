part of 'home_bloc.dart';

// @immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  HomeLoadedState(
      this.tasks,
      );

  final List<Task> tasks;
}

class HomeLoadingFailureState extends HomeState {
  HomeLoadingFailureState(
      this.exception,
      );

  final Object? exception;
}