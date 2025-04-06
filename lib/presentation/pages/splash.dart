import 'package:flutter/material.dart';
// Kendi projenizdeki doğru yolu kullandığınızdan emin olun
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const double figmaTasarimGenisligi = 390.0;
  @override
  Widget build(BuildContext context) {
    final double ekranGenisligi = MediaQuery.of(context).size.width;
    final double responsiveGenislik =
        (196 / figmaTasarimGenisligi) * ekranGenisligi;
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.spotifyIcon,
          width: responsiveGenislik,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
