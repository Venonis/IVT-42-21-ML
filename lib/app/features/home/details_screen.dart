import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/app/app.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.id});
  final int id;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _homeBloc = HomeBloc(getIt<TopNewsRepository>());
  final _authBloc = AuthBloc(getIt<AuthService>());

  bool isFavoriteGl = false;

  @override
  void initState() {
    _homeBloc.stream.listen((state) {
      if (state is HomeLoadSuccess) {
        _checkIfFavourite(widget.id);
      }
    });
    super.initState();
    _homeBloc.add(const HomeLoad());
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
            title: const Text('Детали'),
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
                      ),
                      30.ph,
                      Text(
                        article.publishedAt,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.bodySmall,
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

  Future<void> _checkIfFavourite(int id) async {
    final CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');

    try {
      QuerySnapshot snapshot = await favorites
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('favourites')
          .get();

      bool isFavorite = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList()
          .any((favorite) => favorite['id'] == id);

      setState(() {
        isFavoriteGl = isFavorite;
      });
    } on FirebaseException catch (e) {
      throw e.message.toString();
    }
  }
}