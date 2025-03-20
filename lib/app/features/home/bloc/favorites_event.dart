part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class FavoritesLoad extends FavoritesEvent {
  const FavoritesLoad({this.completer});

  final Completer? completer;

  @override
  List<Object> get props => [];
}

class FavoritesDelete extends FavoritesEvent {
  const FavoritesDelete({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}