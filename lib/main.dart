import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/core/configs/app_config.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_bloc.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugDisableShadows = true;

  FlutterError.onError = (details) {
    debugPrint(details.exceptionAsString());
  };

  setupLocator(); // GetIt kurulumun
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ModeBloc(), child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>().router;

    return BlocBuilder<ModeBloc, ModeState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme:
              state.mode == AppMode.dark ? ThemeData.dark() : ThemeData.light(),

          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
