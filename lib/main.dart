import 'package:flutter/material.dart';
import 'package:flutter_application_1/di/di.dart';
import 'package:flutter_application_1/flutter_application_1.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) => talker.handle(
    details.exception,
    details.stack,
  );
  
  runApp(const NewsBriefApp());
}
