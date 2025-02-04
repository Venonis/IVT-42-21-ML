import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';
// import 'package:flutter_application_1/app/widgets/article_card.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            'Главная',
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
              List<Article> articles = state.articles;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Топ Новостей',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    20.ph,
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(
                          article: articles[index],
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