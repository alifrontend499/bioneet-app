import 'package:app/screens/main_content/main_content_index.dart';
import 'package:app/screens/video_view/video_player/components/video_overlay_component.dart';
import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoPlayerWidget extends ConsumerStatefulWidget {
  const VideoPlayerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends ConsumerState<VideoPlayerWidget> {
  bool overlayVisibility = false;

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = ref.watch(videoPlayerControllerProvider);

    if(videoPlayerController == null) {
      return Container(
        height: 250,
        width: double.infinity,
        color: Colors.black,
        child: const Center(
          child: Text(
            'no video selected',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      );
    }

    return Container(
      height: 250,
      width: double.infinity,
      color: Colors.black,
      child:  AspectRatio(
        aspectRatio: videoPlayerController.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(videoPlayerController),

            AnimatedOpacity( // for visibility of the overlay
              opacity: overlayVisibility ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Visibility(
                visible: overlayVisibility,
                child: VideoPlayerOverlay(
                  controller: videoPlayerController,
                  // orientation: widget.orientation,
                  // videoUrl: widget.videoUrl,
                  // enableDownload: widget.enableDownload
                ),
              )
            ),

            SizedBox( // video player progress indicator
              height: 10,
              child: VideoProgressIndicator(
                videoPlayerController,
                allowScrubbing: true,
                colors: const VideoProgressColors(
                  backgroundColor: Colors.white60,
                  playedColor: Colors.redAccent,
                  bufferedColor: Colors.grey
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
