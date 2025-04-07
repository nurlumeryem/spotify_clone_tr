import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_dimensions.dart';

import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    redirect();
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double responsiveWidth =
        (196 / AppDimensions.figmaDesignWidth) * screenWidth;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.spotifyIcon,
          width: responsiveWidth,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
