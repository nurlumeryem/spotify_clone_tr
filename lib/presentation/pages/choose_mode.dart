import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_bloc.dart';
import 'package:spotify_clone_tr/presentation/bloc/mode_bloc/mode_event.dart';

class ChooseModeContent extends StatelessWidget {
  const ChooseModeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          ),
        ),

        const Text(
          'Choose Mode',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dark Mode Button
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ModeBloc>().add(SetDarkMode());
                  },

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          color: const Color(0xff30393C).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.moonIcon,
                            height: MediaQuery.of(context).size.width * 0.09,
                            width: MediaQuery.of(context).size.width * 0.09,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.042,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 40),
            // Light Mode Button
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<ModeBloc>().add(SetLightMode());
                  },

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.18,
                        width: MediaQuery.of(context).size.width * 0.18,
                        decoration: BoxDecoration(
                          color: const Color(0xff30393C).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.sunIcon,
                            height: MediaQuery.of(context).size.width * 0.09,
                            width: MediaQuery.of(context).size.width * 0.09,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Light Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: MediaQuery.of(context).size.width * 0.042,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
