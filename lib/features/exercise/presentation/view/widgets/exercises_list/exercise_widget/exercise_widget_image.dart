import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/core/widgets/app_network_image.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseWidgetImage extends StatelessWidget {
  final String? link;
  const ExerciseWidgetImage({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    final String videoId = YoutubePlayer.convertUrlToId(link ?? '') ?? '';
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16),
      child: AppNetworkImage(
        height: 80,
        width: 80,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        networkImage: videoId.videoIdToYoutubeThumbnail(),
      ),
    );
  }
}
