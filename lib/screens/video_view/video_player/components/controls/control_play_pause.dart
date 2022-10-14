import 'package:app/screens/main_content/main_content_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// package | video player
import 'package:video_player/video_player.dart';

class ControlPlayPause extends StatefulWidget {
  const ControlPlayPause({
    Key? key
  }) : super(key: key);

  @override
  State<ControlPlayPause> createState() => _ControlPlayPauseState();
}

class _ControlPlayPauseState extends State<ControlPlayPause> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? _) {
        final videoPlayerController = ref.read(videoPlayerControllerProvider.notifier).state;
        final videoPlayerControllerValue = videoPlayerController?.value;
        final isPlaying = videoPlayerControllerValue?.isPlaying;

        return isPlaying != null ? Positioned(
          child: InkWell(
            onTap: () {
              isPlaying ? videoPlayerController?.pause() : videoPlayerController?.play();
              setState(() {});
            },
            child: isPlaying
                ? const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 50,
            )
                : const Icon(
              Icons.pause,
              color: Colors.white,
              size: 50,
            ),
          ),
        ): const Text(' ');
      }
    );
  }
}
