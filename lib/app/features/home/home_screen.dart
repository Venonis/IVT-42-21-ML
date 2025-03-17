import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

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
  final _authBloc = AuthBloc(getIt<AuthService>());

  @override
  void initState() {
    _homeBloc.add(const HomeLoad());
    _authBloc.add(AuthCheckStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthAuthenticated && state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthUnauthenticated && state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Главная'),
            actions: [
              IconButton(
                onPressed: () => _showAuthDialog(context, true), 
                icon: const Icon(Icons.person_add)
                ),
              IconButton(
                onPressed: () => _showAuthDialog(context, false), 
                icon: const Icon(Icons.login)
                ),
              IconButton(
                onPressed: () => _authBloc.add(AuthLogout()), 
                icon: const Icon(Icons.logout)
                )
            ],
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
      )
    );
  }

  Future<void> _showAuthDialog(BuildContext context, bool signInOrLogIn) async {
  final AuthService authService = getIt<AuthService>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // if logged in, cancel
  if (authService.isLoggedIn()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Вы уже вошли в аккаунт.')),
    );
  }
  else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(signInOrLogIn ? 'Регистрация' : 'Вход'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () async {
                if (signInOrLogIn){ // sign in
                  _authBloc.add(AuthSignUp(email: emailController.text, password: passwordController.text));
                } else { // log in
                  _authBloc.add(AuthLogin(email: emailController.text, password: passwordController.text));
                }
                Navigator.of(context).pop();
              },
              child: Text(signInOrLogIn ? 'Зарегистрироваться' : 'Войти'),
            ),
          ],
        );
      },
    );
  }
}
}