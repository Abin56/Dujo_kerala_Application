import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class VideoScreen extends StatelessWidget {
  final String videoLink;

  const VideoScreen({Key? key, required this.videoLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        videoLink,
        betterPlayerConfiguration: const BetterPlayerConfiguration(
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
