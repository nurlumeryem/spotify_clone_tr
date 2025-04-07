import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/presentation/pages/onboarding_pages.dart';
import 'package:spotify_clone_tr/presentation/pages/splash.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashPage()),

        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
      ],
    );
  }
}
