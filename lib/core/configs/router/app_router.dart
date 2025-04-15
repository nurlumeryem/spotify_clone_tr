import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signin.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signup.dart';
import 'package:spotify_clone_tr/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify_clone_tr/presentation/pages/onboarding_pages.dart';
import 'package:spotify_clone_tr/presentation/pages/splash.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
    : router = GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/',
        routes: [
          GoRoute(path: '/', builder: (context, state) => const SplashPage()),
          GoRoute(
            path: '/onboarding',
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: '/signupOrsigninPage',
            pageBuilder:
                (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: const SignupOrSigninPage(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInOut,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
          ),
          GoRoute(
            path: '/signup',
            pageBuilder:
                (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SignupPage(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.1),
                          end: Offset.zero,
                        ).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: child,
                      ),
                    );
                  },
                ),
          ),
          GoRoute(
            path: '/signin',
            pageBuilder:
                (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SigninPage(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInOut,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
          ),
          GoRoute(
            path: '/signup',
            pageBuilder:
                (context, state) => CustomTransitionPage<void>(
                  key: state.pageKey,
                  child: SignupPage(),
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(
                      opacity: CurveTween(
                        curve: Curves.easeInOut,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
          ),
        ],
        errorBuilder:
            (context, state) => Scaffold(
              body: Center(
                child: Text(
                  'Sayfa bulunamadı: ${state.error}',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
      );
}
