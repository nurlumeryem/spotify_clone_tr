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

    final List<String> backgroundImages = [
      AppImages.getStartedImage,
      AppImages.chooseModeImage,
    ];

    return Scaffold(
      body: Stack(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: _currentPageNotifier,
            builder: (context, currentPage, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: Container(
                  key: ValueKey<int>(currentPage),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(backgroundImages[currentPage]),
                    ),
                  ),
                ),
              );
            },
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
                      vertical: 40,
                      horizontal: 40,
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
                      if (index == 0) {
                        return const GetStartedContent();
                      } else {
                        return const ChooseModeContent();
                      }
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
                      onPressed: () {
                        if (currentPage == 0) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          context.go('/home');
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
