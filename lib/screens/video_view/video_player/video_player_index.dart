import 'package:flutter/material.dart';

// states
import 'package:app/screens/main_content/main_content_index.dart';

// video player
import 'package:video_player/video_player.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// overlay
import 'package:app/screens/video_view/video_player/components/video_overlay_component.dart';

class VideoPlayerWidget extends StatefulWidget {
  final Orientation orientation;
  final ScrollController? scrollController;

  const VideoPlayerWidget({
    Key? key,
    required this.orientation,
    required this.scrollController
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool overlayVisibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? _) {
        final videoPlayerController = ref.watch(videoPlayerControllerProvider);
        final VideoModal? selectedVideo = ref.watch(selectedVideoProvider);

        // final videoPlayerController = ref.read(videoPlayerControllerProvider.notifier).state;
        final videoPlayerControllerValue = videoPlayerController?.value;
        final isInitialized = videoPlayerControllerValue?.isInitialized;

        // to update video player values
        videoPlayerController?.addListener(() {
          setState(() {});
        });

        if(selectedVideo != null && videoPlayerController != null) {

          if(isInitialized == false) {
            return Container(
              height: 250,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            );
          }

          final isPortrait = widget.orientation == Orientation.portrait;
          final videoSize = videoPlayerController.value.size;
          final double videoHeight = videoSize.height;
          final double videoWidth = videoSize.width;
          return AspectRatio(
            aspectRatio: videoPlayerController.value.aspectRatio,
            child: Stack(
              fit: isPortrait ? StackFit.loose : StackFit.expand,

              children: [
                GestureDetector(
                  onTap: () => setState(() => overlayVisibility = true),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: videoHeight,
                      width: videoWidth,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => setState(() => overlayVisibility = false),
                  child: AnimatedOpacity( // for visibility of the overlay
                    opacity: overlayVisibility ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Visibility(
                      visible: overlayVisibility,
                      child: VideoPlayerOverlay(
                        controller: videoPlayerController,
                        orientation: widget.orientation,
                        scrollController: widget.scrollController,
                        selectedVideo: selectedVideo,
                        // enableDownload: widget.enableDownload
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: SizedBox(
                    height: 12,
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
                ),
              ],
            ),
          );
        }

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
    );
  }
}
