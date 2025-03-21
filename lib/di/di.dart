import 'package:flutter_application_1/app/features/home/bloc/favorites_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/dio/dio.dart';
import 'package:flutter_application_1/domain/domain.dart';
import 'package:flutter_application_1/app/app.dart';

final getIt = GetIt.instance;
final talker = TalkerFlutter.init();
final Dio dio = Dio();

Future<void> setupLocator() async {
  setUpDio();

  getIt.registerSingleton(talker);
  getIt.registerSingleton(dio);

  getIt.registerSingleton(AuthService());
  
  getIt.registerSingleton(TopNewsRepository(dio: dio));
  getIt.registerSingleton(HomeBloc(getIt.get<TopNewsRepository>()));
  
  getIt.registerSingleton(FavoritesService(dio: dio));
  getIt.registerSingleton(FavoritesBloc(getIt.get<FavoritesService>()));
  
}