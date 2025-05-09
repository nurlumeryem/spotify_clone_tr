import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/favorite_button.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/song_player/bloc/song_player_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/song_player/bloc/song_player_state.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/favorite_button/bloc/favorite_button_bloc.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text('Now Playing', style: TextStyle(fontSize: 18)),
        action: IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert_rounded),
        ),
      ),
      body: BlocProvider(
        create:
            (context) => SongPlayerBloc()..add(LoadSongEvent(songEntity.url)),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _songCover(context),
                SizedBox(height: 20),
                _songDetail(context),
                SizedBox(height: 20),
                _songPlayer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(songEntity.coverFileName),
        ),
      ),
    );
  }

  Widget _songDetail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ],
        ),
        BlocProvider(
          create: (context) => FavoriteButtonBloc(),
          child: FavoriteButton(songEntity: songEntity),
        ),
      ],
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerBloc, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: state.position.inSeconds.toDouble(),
                min: 0.0,
                max: state.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  context.read<SongPlayerBloc>().add(
                    SeekEvent(Duration(seconds: value.toInt())),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(state.position)),
                  Text(formatDuration(state.duration)),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  context.read<SongPlayerBloc>().add(PlayPauseEvent());
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    state.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
        }
        if (state is SongPlayerFailure) {
          return Text('Hata: ${state.message}');
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
