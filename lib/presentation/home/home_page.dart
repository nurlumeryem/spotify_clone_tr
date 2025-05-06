import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/helpers/is_dark_mode.dart';
import 'package:spotify_clone_tr/core/app/app.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_vectors.dart';
import 'package:spotify_clone_tr/presentation/home/widgets/new_songs.dart';
import 'package:spotify_clone_tr/presentation/home/widgets/play_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    print('HomePage initState çağrıldı');
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print('HomePage build metodu çağrıldı');
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [NewSongs(), Container(), Container(), Container()],
              ),
            ),

            PlayList(),
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 340,
              height: 118,
              decoration: BoxDecoration(
                color: const Color(0xFF42C83C),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const Positioned(
              left: 24,
              top: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yeni Albüm',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kuzu Kuzu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Tarkan',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -75,
              right: -20,
              child: Image.asset(
                AppImages.homeArtist,
                height: 190,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      padding: const EdgeInsets.only(left: 24, top: 40, bottom: 40),
      tabs: const [
        Text(
          'Yeniler',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Videolar',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Sanatçılar',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text(
          'Podcastler',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ],
    );
  }
}
