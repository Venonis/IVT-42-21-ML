import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/app/features/home/bloc/favorites_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';
//import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  //final FavoritesBloc _favoritesBloc = FavoritesBloc(getIt<favoritesService>());
  //final _favoritesBloc = getIt<FavoritesBloc>();
  final _favoritesBloc = FavoritesBloc(getIt<FavoritesService>());

  @override
  void initState() {
    _favoritesBloc.add(const FavoritesLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Избранное'),
          ),
          body: BlocBuilder<FavoritesBloc, FavoritesState>(
            bloc: _favoritesBloc,
            builder: (context, state) {
              if (state is FavoritesLoadInProgress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is FavoritesLoadSuccess) {
                List<Article> favorites = state.favorites;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Избранное',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      20.ph,
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          return ArticleCard(
                            article: favorites[index],
                            id: index,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return 20.ph;
                        },
                      ),
                    ],
                  ),
                );
              }
              if (state is FavoritesLoadFailure) {
                return ErrorCardFav(
                  title: 'Ошибка',
                  description: state.exception.toString(),
                  onReload: () {
                  _favoritesBloc.add(const FavoritesLoad());
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      );
  }
}

class ErrorCardFav extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCardFav({
    super.key,
    required this.title,
    required this.description,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 8),
              Text(description),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onReload,
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}