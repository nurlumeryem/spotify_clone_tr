import 'package:flutter/material.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';

class ChooseModeContent extends StatelessWidget {
  const ChooseModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        const Text(
          'Choose Mode',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Dark Mode Kolonu
            Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(
                      0.3,
                    ), // Hafif gri arka plan
                  ),
                  child: Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.white.withOpacity(0.8),
                    size: 35,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Light Mode Kolonu
            Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.grey.withOpacity(
                      0.3,
                    ), // Hafif gri arka plan
                  ),
                  child: Icon(
                    Icons.light_mode_outlined,
                    color: Colors.white.withOpacity(0.8),
                    size: 35,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Light Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),

        const Spacer(),
      ],
    );
  }
}
