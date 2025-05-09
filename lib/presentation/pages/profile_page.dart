import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/favorite_button.dart';
import 'package:spotify_clone_tr/common/widgets/helpers/is_dark_mode.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_urls.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/favorite_button/bloc/favorite_button_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/favorite_songs/bloc/favorite_songs_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_state.dart';
import 'package:spotify_clone_tr/presentation/pages/song_player_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileInfoBloc()..add(LoadUserEvent())),
        BlocProvider(
          create: (_) => FavoriteSongsBloc()..add(LoadFavoriteSongsEvent()),
        ),
        BlocProvider(create: (context) => FavoriteButtonBloc()),
      ],
      child: Scaffold(
        appBar: BasicAppbar(
          backgroundColor: const Color(0xff2C2B2B),
          title: const Text('Profile'),
        ),
        body: Column(
          children: [
            _profileInfo(context),
            const SizedBox(height: 30),
            _favoriteSongs(),
          ],
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: BlocBuilder<ProfileInfoBloc, ProfileInfoState>(
        builder: (context, state) {
          if (state is ProfileInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileInfoLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/cat.png'),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(state.userEntity.email ?? 'No email'),
                const SizedBox(height: 10),
                Text(
                  state.userEntity.fullName ?? 'No name',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          } else if (state is ProfileInfoFailure) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsBloc()..add(LoadFavoriteSongsEvent()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORİ ŞARKILAR 🎵❤️'),
            const SizedBox(height: 20),
            BlocBuilder<FavoriteSongsBloc, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }

                if (state is FavoriteSongsLoaded) {
                  List<SongEntity> favoriteSongs = state.favoriteSongs;

                  if (favoriteSongs.isEmpty) {
                    return const Center(
                      child: Text('No favorite songs available.'),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final song = favoriteSongs[index];

                      return GestureDetector(
                        onTap: () {
                          String encodedUrl = Uri.encodeFull(song.url);
                          print('Playing song from URL: $encodedUrl');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => SongPlayerPage(
                                    songEntity: song,
                                    favoriteSongs: favoriteSongs,
                                  ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        song.coverFileName.startsWith('http')
                                            ? song.coverFileName
                                            : '${AppURLs.coverStorage}${song.coverFileName}?${AppURLs.mediaAlt}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      song.artist,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${(song.duration ~/ 60).toString().padLeft(2, '0')}:${(song.duration % 60).toString().padLeft(2, '0')}',
                                ),
                                const SizedBox(width: 20),
                                FavoriteButton(
                                  songEntity: state.favoriteSongs[index],
                                  isFavorite: favoriteSongs.contains(
                                    state.favoriteSongs[index],
                                  ),
                                  key: UniqueKey(),
                                  onPressed: () {
                                    context
                                        .read<FavoriteSongsBloc>()
                                        .removeSong(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder:
                        (context, index) => const SizedBox(height: 20),
                    itemCount: favoriteSongs.length,
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Text(
                    'Favori şarkılar yüklenirken bir hata oluştu: ${state.message}',
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
