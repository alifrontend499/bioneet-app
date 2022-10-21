import 'package:app/screens/video_view/video_player/video_player_index.dart';
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

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({Key? key}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  ScrollController? _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // scroll controller
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return GestureDetector(
              onTap: () => false,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? _) {
                  final VideoModal? selectedVideo = ref.watch(selectedVideoProvider);

                  return CustomScrollView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    // physics: isFullScreen ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // child | video player
                            VideoPlayerWidget(
                              orientation: orientation,
                              scrollController: _scrollController
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
                                        fontWeight: FontWeight.w600,
                                      ),
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
                                          timeago.format(DateTime.parse(selectedVideo!.timeStamp)),
                                          style: videoDurationStyle,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    const Divider(),
                                    const SizedBox(height: 5),
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
                  );
                },
              ),
            );
          },
        ),
      ),

      // bottomSheet: GestureDetector(
      //   onTap: () => false,
      //   child: Container(
      //     width: double.infinity,
      //     padding: const EdgeInsets.all(20),
      //     color: Colors.white,
      //     child: Text('hello'),
      //   ),
      // ),
    );
  }
}

