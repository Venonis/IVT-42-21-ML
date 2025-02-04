import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/data/data.dart';
import 'package:flutter_application_1/domain/domain.dart';

class TopNewsRepository extends TopNewsRepositoryIterface {
  TopNewsRepository({required this.dio});
  final Dio dio;
  @override
  Future<List<Article>> getTopNews() async {
    try {
      final Response response = await dio.get(
        Endpoints.topStories,
        queryParameters: {
          'locale': 'ru',
          'language': 'ru',
        },
      );
      final news = (response.data['data'] as List)
        .map((e) => Article.fromJson(e))
        .toList();
      return news;
    } on DioException catch (e) {
      throw e.message.toString();
    }
  }
}