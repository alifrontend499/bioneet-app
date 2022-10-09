import 'package:flutter/material.dart';

// styles
import 'package:app/screens/videos_listing/styles/screenStyles.dart';

// package | video player
import 'package:video_player/video_player.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// model
import 'package:app/screens/videos_listing/models/video.dart';

// screen
import 'package:app/screens/main_content/main_content_index.dart';

// package | timeago
import 'package:timeago/timeago.dart' as timeago;

// data
import 'package:app/screens/videos_listing/data.dart';

// widgets
import 'package:app/screens/videos_listing/widgets/VideoWidget.dart';

class VideoViewScreen extends ConsumerStatefulWidget {
  const VideoViewScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends ConsumerState<VideoViewScreen> {
  ScrollController? _scrollController;
  late VideoPlayerController _videoPlayerController;
  VideoModal? selectedVideo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    final updatedVideos = ref.read(selectedVideoProvider);
    setState(() {
      selectedVideo = updatedVideos;
    });

    // video player
    _videoPlayerController = VideoPlayerController.asset(
      selectedVideo!.videoUrl
    );
    _videoPlayerController.addListener(() {
      setState(() {});
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.play();

    // scroll controller
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant VideoViewScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    print('getting called $oldWidget');

    final updatedVideos = ref.read(selectedVideoProvider);

    if(updatedVideos != null) {
      setState(() {
        selectedVideo = updatedVideos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          shrinkWrap: true,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // child | video player
                  AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_videoPlayerController),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  if (selectedVideo != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            selectedVideo!.videoTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              // child | icon
                              const Icon(
                                Icons.calendar_month_outlined,
                                size: 15,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 5),

                              // child | duration
                              Text(
                                timeago.format(selectedVideo!.timeStamp),
                                style: videoDurationStyle,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(),

                          // const Text(
                          //   "More Videos",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.w600,
                          //       fontSize: 17
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final data = videosListing[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: VideoWidget(
                      video: data,
                      onTap: () => _scrollController?.animateTo(0, duration: const Duration(microseconds: 2000), curve: Curves.easeIn)
                  ),
                );
              }, childCount: videosListing.length),
            ),
          ],
        ),
      ),
    );
  }
}

