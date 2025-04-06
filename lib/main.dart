import 'package:flutter/material.dart';
import 'package:spotify_clone_tr/core/configs/app_config.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_theme.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
