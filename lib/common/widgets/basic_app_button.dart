import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final bool hasBorder;

  const BasicAppButton({
    required this.onPressed,
    required this.title,
    this.width = 147,
    this.height = 73,
    this.backgroundColor = const Color(0xFF42C83C), // Spotify yeşili varsayılan
    this.borderRadius = 30.0,
    this.textStyle,
    this.hasBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            side:
                hasBorder
                    ? const BorderSide(color: Colors.white, width: 2)
                    : BorderSide.none,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        child: Text(
          title,
          style:
              textStyle ??
              const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
