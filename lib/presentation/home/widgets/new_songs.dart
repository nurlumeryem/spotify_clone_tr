import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_tr/common/widgets/helpers/is_dark_mode.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_urls.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/new_songs/news_songs_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/new_songs/news_songs_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/new_songs/news_songs_state.dart';
import 'package:spotify_clone_tr/service_locator.dart';
import 'package:spotify_clone_tr/domain/usecases/get_news_usecase.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              NewsSongsBloc(sl<GetNewsSongsUseCase>())..add(FetchNewsSongs()),

      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsBloc, NewsSongsState>(
          builder: (context, state) {
            if (state is NewsSongsLoading) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }
            if (state is NewsSongsLoaded) {
              return _songs(state.songs);
            }
            if (state is NewsSongsLoadFailure) {
              return Center(
                child: Text('Şarkılar yüklenemedi: ${state.message}'),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final song = songs[index];
        return GestureDetector(
          onTap: () {
            context.push('/songPlayerPage', extra: songs[index]);
          },
          child: SizedBox(
            width: 160,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(song.coverFileName),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 40,
                          width: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                context.isDarkMode
                                    ? AppColors.darkGrey
                                    : const Color(0xffE6E6E6),
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color:
                                context.isDarkMode
                                    ? const Color(0xff959595)
                                    : const Color(0xff555555),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  Text(
                    songs[index].title,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    songs[index].artist,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 14),
      itemCount: songs.length,
    );
  }
}
