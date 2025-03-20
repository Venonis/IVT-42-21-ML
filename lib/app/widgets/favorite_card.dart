import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/features/home/bloc/favorites_bloc.dart';
import 'package:flutter_application_1/domain/domain.dart';

class FavoriteCard extends StatelessWidget {
  final Article article;

  const FavoriteCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(article.description),
            const SizedBox(height: 8),
            Text('First appearance: ${article.publishedAt}'),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.red),
                onPressed: () => context.read<FavoritesBloc>().add(
                      FavoritesDelete(name: article.title),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}