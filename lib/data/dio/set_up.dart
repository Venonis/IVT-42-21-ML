import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void setUpDio() {
  dio.options.baseUrl = 'https://api.thenewsapi.com/v1/news/'; // общая часть адресов запросов
  dio.options.queryParameters.addAll({
    'api_token': dotenv.env['API_KEY'] ?? '', // сюда нужно будет подставить ключ/токен, выданный при регистрации
  });
  dio.options.connectTimeout = const Duration(minutes: 1);
  dio.options.receiveTimeout = const Duration(minutes: 1);
  dio.interceptors.addAll([
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printRequestData: true,
        printRequestHeaders: true,
      ),
    ),
  ]);
}
