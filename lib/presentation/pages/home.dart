import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_vectors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
    );
  }
}
