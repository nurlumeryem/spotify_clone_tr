import 'package:flutter/material.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_dimensions.dart';

import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
