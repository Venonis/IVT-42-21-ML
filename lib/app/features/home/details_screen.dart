import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    super.key, required this.id,
  });
  final int id;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  final _homeBloc = HomeBloc(getIt<TopNewsRepository>());

  @override
  void initState() {
    _homeBloc.add(const HomeLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Детали',
          ),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadSuccess) {
              GoRouterState.of(context);
              Article article = state.articles[widget.id];
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    Text(
                      article.description,
                      //style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              );
            }
            if (state is HomeLoadFailure) {
              return ErrorCard(
                title: 'Ошибка',
                description: state.exception.toString(),
                onReload: () {
                _homeBloc.add(const HomeLoad());
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