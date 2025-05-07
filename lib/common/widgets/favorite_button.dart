import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_colors.dart';
import 'package:spotify_clone_tr/domain/entities/song/song.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/favorite_button/bloc/favorite_button_bloc.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({required this.songEntity, this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonBloc(),
      child: BlocBuilder<FavoriteButtonBloc, FavoriteButtonState>(
        builder: (context, state) {
          if (state is FavoriteButtonInitial) {
            return IconButton(
              onPressed: () async {
                context.read<FavoriteButtonBloc>().add(
                  UpdateFavoriteButton(songEntity.songId),
                );
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                songEntity.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          if (state is FavoriteButtonUpdated) {
            return IconButton(
              onPressed: () {
                context.read<FavoriteButtonBloc>().add(
                  UpdateFavoriteButton(songEntity.songId),
                );
                if (function != null) {
                  function!();
                }
              },
              icon: Icon(
                state.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                size: 25,
                color: AppColors.darkGrey,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
