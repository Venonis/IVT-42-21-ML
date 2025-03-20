part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoadInProgress extends FavoritesState {}

final class FavoritesLoadSuccess extends FavoritesState {
  const FavoritesLoadSuccess({required this.favorites});

  final List<Article> favorites;

  @override
  List<Object> get props => [favorites];
}

final class FavoritesLoadFailure extends FavoritesState {
  const FavoritesLoadFailure({required this.exception});

  final Object? exception;

  @override
  List<Object> get props => [];
}