import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesServiceInterface _favoritesService;

  FavoritesBloc(this._favoritesService) : super(FavoritesInitial()) {
    on<FavoritesLoad>(_onFavoritesLoad);
    on<FavoritesDelete>(_onFavoritesDelete);
  }

  Future<void> _onFavoritesLoad(
    FavoritesLoad event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      if (state is! FavoritesLoadSuccess) emit(FavoritesLoadInProgress());
      
      final favoritesData = await _favoritesService.getFavorites();
      final favorites = favoritesData.map((data) => Article(
        uuid: data['id'],
        title: data['name'],
        description: data['description'],
        publishedAt: data['firstAppearance'],
      )).toList();

      emit(FavoritesLoadSuccess(favorites: favorites));
    } catch (exception, stackTrace) {
      emit(FavoritesLoadFailure(exception: exception));
      talker.handle(exception, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _onFavoritesDelete(
    FavoritesDelete event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _favoritesService.deleteFavorite(event.name);
      add(const FavoritesLoad());
    } catch (exception, stackTrace) {
      talker.handle(exception, stackTrace);
      add(const FavoritesLoad());
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    talker.handle(error, stackTrace);
  }
}