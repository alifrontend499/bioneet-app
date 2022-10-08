import 'package:app/screens/main_content/main_content_index.dart';
import 'package:flutter/material.dart';

// styles
import 'package:app/screens/videos_listing/styles/screenStyles.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';

// package | timeago
import 'package:timeago/timeago.dart' as timeago;

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoWidget extends ConsumerWidget {
  final VideoModal video;

  const VideoWidget({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return InkWell(
      onTap: () => ref.read(selectedVideoProvider.notifier).state = video, // setting the video state value

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
                video.videoThumbnailUrl,
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
                  Text(video.videoTitle,
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
                            video.videoDuration,
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
                            timeago.format(video.timeStamp),
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
  }
}
