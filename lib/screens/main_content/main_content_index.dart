import 'package:flutter/material.dart';

// styles | screen
import 'package:app/screens/main_content/styles/screenStyles.dart';

// screens
import 'package:app/screens/videos_listing/videos_listing_index.dart';
import 'package:app/screens/video_view/video_view_index.dart';
import 'package:app/screens/downloads/downloads_index.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';

// package | mini player
import 'package:miniplayer/miniplayer.dart';

// package | video player
import 'package:video_player/video_player.dart';

// package | cached images
import 'package:cached_network_image/cached_network_image.dart';

// setting initial value for the video state
final selectedVideoProvider = StateProvider<VideoModal?>((_) => null);
final miniPlayerControllerProvider =
    StateProvider.autoDispose<MiniplayerController>(
        (ref) => MiniplayerController());
final videoPlayerControllerProvider =
    StateProvider.autoDispose<VideoPlayerController?>((_) => null);
final isPlayerFullScreenProvider =
StateProvider<bool>((_) => false);

class MainContentScreen extends ConsumerStatefulWidget {
  const MainContentScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends ConsumerState<MainContentScreen> {
  static const double _playerMinHeight = 60;

  int currentIndex = 0;
  final List<Widget> _screens = [
    const VideosListingScreen(),
    const DownloadsScreen(),
    // const VideoViewScreen(),
  ];

  // setting mini-player to mini screen
  void minimizeMiniPlayer() {
    ref.read(miniPlayerControllerProvider.notifier).state.animateToHeight(
      state: PanelState.MIN
    );
  }

  @override
  Widget build(BuildContext context) {
    final VideoModal? selectedVideo = ref.watch(selectedVideoProvider);
    final miniPlayerController = ref.watch(miniPlayerControllerProvider);
    final videoPlayerController = ref.watch(videoPlayerControllerProvider);

    // to update video player values
    // videoPlayerController?.addListener(() {
    //   setState(() {});
    // });

    return Scaffold(
      body: Stack(
        children: _screens.asMap().map((i, screen) =>
          MapEntry(i, Offstage(offstage: currentIndex != i, child: screen)))
          .values.toList()
          ..add(Offstage(
            offstage: selectedVideo == null,
            child: Miniplayer(
              controller: miniPlayerController,
              minHeight: _playerMinHeight,
              maxHeight: MediaQuery.of(context).size.height,
              builder: (height, percentage) {
                // if no video is selected
                if (selectedVideo == null) {
                  return const SizedBox.shrink();
                }

                // checking height to show the video view screen
                if (height <= _playerMinHeight + 50) {
                  return Container(
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12, //New
                          blurRadius: 10.0,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          // child | content
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // child | image
                              CachedNetworkImage(
                                placeholder: (context, url) => const Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                imageUrl: selectedVideo.videoThumbnailUrl,
                                width: 80,
                              ),
                              const SizedBox(width: 15),

                              // child | text
                              Expanded(
                                child: Text(
                                  selectedVideo.videoTitle,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(width: 15),

                              // child | icons
                              Row(
                                children: [
                                  if (videoPlayerController != null) ...[
                                    if(videoPlayerController.value.isPlaying) ...[
                                      InkWell(
                                        onTap: () => ref.read(videoPlayerControllerProvider.notifier).state?.pause(),
                                        child:
                                        const Icon(Icons.pause, size: 26),
                                        // splashRadius: 22,
                                      )
                                    ] else ...[
                                      InkWell(
                                        onTap: () => ref.read(videoPlayerControllerProvider.notifier).state?.play(),
                                        child:
                                        const Icon(Icons.play_arrow, size: 26),
                                        // splashRadius: 22,
                                      )
                                    ],
                                  ],
                                  const SizedBox(width: 15),

                                  // child | icon
                                  InkWell(
                                    onTap: () {
                                      ref.read(videoPlayerControllerProvider.notifier).state?.dispose(); // setting the video state value
                                      ref.read(videoPlayerControllerProvider.notifier).state = null; // setting the video state value
                                      ref.read(selectedVideoProvider.notifier).state = null; // setting the video state value
                                    },
                                    child: const Icon(Icons.cancel, size: 21),
                                    // splashRadius: 22,
                                  ),
                                  const SizedBox(width: 10),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return const VideoViewScreen();
              },
            ),
          ),
        ),
      ),

      bottomNavigationBar: Visibility(
        visible: ref.watch(isPlayerFullScreenProvider) == false ? true : false,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() => currentIndex = index);
            minimizeMiniPlayer();
          },
          unselectedLabelStyle: labelStylesUnselected,
          selectedLabelStyle: labelStylesSelected,
          iconSize: 20,
          unselectedItemColor: Colors.black38,
          selectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: "Downloads", icon: Icon(Icons.download)),
          ],
        ),
      ),
    );
  }
}
