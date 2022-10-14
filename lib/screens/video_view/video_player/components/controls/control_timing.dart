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

  // to convert time
  String getTime(val) {
    if(val < 10) {
      return "0$val";
    } else {
      return '$val';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? _) {
          final videoPlayerController = ref.watch(videoPlayerControllerProvider);

          return Positioned(
            bottom: 12,
            left: 10,
            child: Row(
              children: [
                Text(
                    "${getTime(videoPlayerController?.value.position.inMinutes)}:${getTime(videoPlayerController?.value.position.inSeconds)}",
                    style: textControlStyle
                ),

                const SizedBox(width: 2),
                const Text(
                    "/",
                    style: textControlStyle
                ),
                const SizedBox(width: 2),

                Text(
                    "${getTime(videoPlayerController?.value.duration.inMinutes)}:${getTime(videoPlayerController?.value.duration.inSeconds)}",
                    style: textControlStyle
                ),
              ],
            ),
          );
        }
    );
  }
}
