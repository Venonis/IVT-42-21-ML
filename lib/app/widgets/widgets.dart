import 'package:flutter/material.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/domain/domain.dart';
import 'package:flutter_application_1/flutter_application_1.dart';
// export 'article_card.dart';
// export 'error_card.dart';
// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/app/app.dart';
part 'article_card.dart';
part 'error_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  runApp(const NewsBriefApp());
}