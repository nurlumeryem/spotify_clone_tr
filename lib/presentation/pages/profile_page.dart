import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone_tr/common/widgets/app_bar.dart';
import 'package:spotify_clone_tr/common/widgets/helpers/is_dark_mode.dart';
import 'package:spotify_clone_tr/core/configs/theme/app_images.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_bloc.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_event.dart';
import 'package:spotify_clone_tr/presentation/home/bloc/profile_info/bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoBloc()..add(LoadUserEvent()),
      child: Scaffold(
        appBar: BasicAppbar(
          backgroundColor: const Color(0xff2C2B2B),
          title: const Text('Profile'),
        ),
        body: Column(children: [_profileInfo(context)]),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
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
                      image:
                          state.userEntity.imageURL != null &&
                                  state.userEntity.imageURL!.isNotEmpty
                              ? NetworkImage(state.userEntity.imageURL!)
                              : AssetImage(AppImages.defaultImage),
                      fit: BoxFit.cover,
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
}
