import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/core/configs/app_config.dart';
import 'package:spotify_clone_tr/core/configs/router/app_router.dart';
import 'package:spotify_clone_tr/firebase_options.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_bloc.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hata yakalama mekanizmasını geliştiriyoruz
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Hata mesajını kullanıcıya gösterebilirsiniz
    // Example: showToast("Something went wrong!");
  };

  // Firebase'i başlatıyoruz
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
    // Firebase hatası durumunda kullanıcıya bir mesaj gösterebilirsiniz
    // Example: showToast("Firebase initialization failed.");
  }

  await initializeDependencies();
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
        // Temayı dinamik olarak belirliyoruz
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
