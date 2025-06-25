import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../bloc/exercise_bloc.dart';
import '../../../../bloc/exercise_event.dart';
import '../../../../bloc/exercise_state.dart';

class ExerciseYoutubePlayerWidget extends StatelessWidget {
  final String? youtubeLink;
  const ExerciseYoutubePlayerWidget({super.key, required this.youtubeLink});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ExercisePageBloc>();
    return BlocListener<ExercisePageBloc, ExercisePageState>(
      listenWhen: (p, c) => c.currentVideoLink == youtubeLink,
      listener: (context, state) {
        showDialog(
          context: context,
          builder:
              (context) =>
                  state.currentVideoId != null
                      ? Dialog(
                        backgroundColor: Colors.transparent,
                        child: Center(
                          child: YoutubePlayer(
                            controller: YoutubePlayerController(
                              initialVideoId: state.currentVideoId!,
                              flags: YoutubePlayerFlags(autoPlay: false),
                            ),
                            progressIndicatorColor: AppColors.primaryOrange,
                          ),
                        ),
                      )
                      : Center(
                        child: SizedBox(
                          height: 200,
                          child: Text(context.l10n.video_not_available),
                        ),
                      ),
        ).then((_) {
          bloc.add(CloseYoutubeVideoEvent());
        });
      },
      child: GestureDetector(
        onTap: () => bloc.add(ShowYoutubeVideoEvent(link: youtubeLink)),
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.primaryOrange,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow, color: Colors.black),
        ),
      ),
    );
  }
}
