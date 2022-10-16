import 'package:app/screens/videos_listing/models/video.dart';
import 'package:flutter/material.dart';

// package | video player
import 'package:video_player/video_player.dart';

// controls
import 'package:app/screens/video_view/video_player/components/controls/control_play_pause.dart';
import 'package:app/screens/video_view/video_player/components/controls/control_fullscreen.dart';
import 'package:app/screens/video_view/video_player/components/controls/control_download.dart';
import 'package:app/screens/video_view/video_player/components/controls/control_timing.dart';
import 'package:app/screens/video_view/video_player/components/controls/control_settings.dart';

class VideoPlayerOverlay extends StatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;
  final ScrollController? scrollController;
  final VideoModal selectedVideo;
  // final bool enableDownload;

  const VideoPlayerOverlay({
    Key? key,
    required this.controller,
    required this.orientation,
    required this.scrollController,
    required this.selectedVideo,
    // required this.enableDownload
  }) : super(key: key);

  @override
  State<VideoPlayerOverlay> createState() => _VideoPlayerOverlayState();
}

class _VideoPlayerOverlayState extends State<VideoPlayerOverlay> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black26,
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [ // all options on the overlay
            const ControlPlayPause(), // play pause

            ControlFullScreen( // full screen control
              controller: widget.controller,
              orientation: widget.orientation,
              scrollController: widget.scrollController,
            ),

            const ControlTiming(), // video timing

              ControlDownload(
                controller: widget.controller,
                selectedVideo: widget.selectedVideo,
              ),

            // if(widget.enableDownload == true) ...[
             // download control
            // ],

            ControlSettings(controller: widget.controller), // download control
          ],
        ),
      ),
    );
  }
}
