import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/app.dart';

class NewsBriefApp extends StatelessWidget {
  const NewsBriefApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'News Brief',
      theme: AppTheme.lightTheme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
    );
  }
}