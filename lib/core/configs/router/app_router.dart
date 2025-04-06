import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/presentation/pages/get_started.dart';
import 'package:spotify_clone_tr/presentation/pages/splash.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashPage()),
        GoRoute(
          path: '/home',
          builder: (context, state) => const GetStartedPage(),
        ),
      ],
    );
  }
}
