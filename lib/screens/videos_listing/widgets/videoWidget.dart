import 'package:app/screens/main_content/main_content_index.dart';
import 'package:flutter/material.dart';

// styles
import 'package:app/screens/videos_listing/styles/screenStyles.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';
import 'package:miniplayer/miniplayer.dart';

// package | timeago
import 'package:timeago/timeago.dart' as timeago;

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VideoWidget extends StatefulWidget {
  final VideoModal video;
  final VoidCallback? onTap;

  const VideoWidget({Key? key, required this.video, this.onTap}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return InkWell(
          onTap: () => {
            ref.watch(selectedVideoProvider.notifier).state = widget.video, // setting the video state value
            ref.watch(miniPlayerControllerProvider.notifier).state.animateToHeight(
                state: PanelState.MAX
            ),

            if(widget.onTap != null) widget.onTap!(),
          },

          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // child | image container
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.network(
                    widget.video.videoThumbnailUrl,
                    width: 120,
                  ),
                ),
                const SizedBox(width: 15),

                // child | video details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // child | title
                      Text(widget.video.videoTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: videoTitleStyle),
                      const SizedBox(height: 4),

                      // child | duration
                      Wrap(
                        children: [
                          Row(
                            children: [
                              // child | icon
                              const Icon(
                                Icons.access_time,
                                size: 16,
                                color: Colors.black87,
                              ),
                              const SizedBox(width: 5),

                              // child | duration
                              Text(
                                widget.video.videoDuration,
                                style: videoDurationStyle,
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),

                          // child | time
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
                                timeago.format(widget.video.timeStamp),
                                style: videoDurationStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 3),

                // child | video options
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 18),
                  splashRadius: 22,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
