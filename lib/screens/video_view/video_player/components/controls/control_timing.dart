import 'package:flutter/material.dart';

// package | video player
import 'package:video_player/video_player.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/screens/main_content/main_content_index.dart';

// styles
const TextStyle textControlStyle = TextStyle(
  color: Colors.white,
  fontSize: 12
);

class ControlTiming extends StatefulWidget {
  const ControlTiming({
    Key? key,
  }) : super(key: key);

  @override
  State<ControlTiming> createState() => _ControlTimingState();
}

class _ControlTimingState extends State<ControlTiming> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? _) {
          final videoPlayerController = ref.watch(videoPlayerControllerProvider);
          if(videoPlayerController != null) {
            final videoPlayerPosition = videoPlayerController.value.position.inMilliseconds;
            final videoPlayerDuration = Duration(milliseconds: videoPlayerPosition);
            final videoTime = [videoPlayerDuration.inMinutes, videoPlayerDuration.inSeconds]
                .map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');

            // to update video player values
            // videoPlayerController?.addListener(() {
            //   setState(() {});
            // });



            return Positioned(
              bottom: 12,
              left: 10,
              child: Row(
                children: [
                  Text(
                      videoTime,
                      style: textControlStyle
                  ),
                ],
              ),
            );
          }
          return const Text('');
        }
    );
  }
}
