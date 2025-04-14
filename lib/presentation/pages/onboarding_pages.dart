import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/common/widgets/button.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_dimensions.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_strings.dart';
import 'package:spotify_clone_tr/presentation/pages/choose_mode.dart';
import 'package:spotify_clone_tr/presentation/pages/get_started.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(0);
  final List<String> backgroundImages = [
    AppImages.getStartedImage,
    AppImages.chooseModeImage,
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final int currentPage = _pageController.page?.round() ?? 0;
      if (_currentPageNotifier.value != currentPage) {
        _currentPageNotifier.value = currentPage;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double iconWidth =
        (196 / AppDimensions.figmaDesignWidth) * screenWidth;

    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resimleri için Stack ve Positioned.fill kullanımı
          Positioned.fill(
            child: ValueListenableBuilder<int>(
              valueListenable: _currentPageNotifier,
              builder: (context, currentPage, _) {
                return AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundImages[currentPage]),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Container(color: Colors.black.withOpacity(0.15)),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Image.asset(AppImages.spotifyIcon, width: iconWidth),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          // Sayfa geçişlerinde opacity efekti
                          double value = 1.0;
                          if (_pageController.position.haveDimensions) {
                            value = _pageController.page! - index;
                            value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                          }
                          return Opacity(
                            opacity: value,
                            child: Transform.scale(scale: value, child: child),
                          );
                        },
                        child:
                            index == 0
                                ? const GetStartedContent()
                                : const ChooseModeContent(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                ValueListenableBuilder<int>(
                  valueListenable: _currentPageNotifier,
                  builder: (context, currentPage, _) {
                    return AppButon(
                      text:
                          currentPage == 0
                              ? AppStrings.getStarted
                              : AppStrings.continueText,
                      onPressed: () async {
                        if (currentPage == 0) {
                          await _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          if (!mounted) return;
                          context.go('/signupOrsigninPage');
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
