import 'package:flutter/material.dart';

// styles | screen
import 'package:app/screens/main_content/styles/screenStyles.dart';

// screens
import 'package:app/screens/videos_listing/videos_listing_index.dart';
import 'package:app/screens/video_view/video_view_index.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';
import 'package:miniplayer/miniplayer.dart';

// setting initial value for the video state
final selectedVideoProvider = StateProvider<VideoModal?>((_) => null);

class MainContentScreen extends StatefulWidget {
  const MainContentScreen({Key? key}) : super(key: key);

  @override
  State<MainContentScreen> createState() => _MainContentScreenState();
}

class _MainContentScreenState extends State<MainContentScreen> {
  static const double _playerMinHeight = 60;

  int currentIndex = 0;
  final List<Widget> _screens = [
    const VideosListingScreen(),
    const VideoViewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? _) {
          final VideoModal? selectedVideo = ref.watch(selectedVideoProvider);
          return Stack(
            children: _screens
                .asMap()
                .map((i, screen) =>
                MapEntry(
                    i, Offstage(offstage: currentIndex != i, child: screen)))
                .values
                .toList()
              ..add(
                Offstage(
                  offstage: selectedVideo == null,
                  child: Miniplayer(
                    minHeight: _playerMinHeight,
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height,
                    builder: (height, percentage) {
                      if(selectedVideo == null) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12, //New
                                blurRadius: 10.0,
                                offset: Offset(0, -2))
                          ]
                        ),
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Text('$height $percentage'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        unselectedLabelStyle: labelStylesUnselected,
        selectedLabelStyle: labelStylesSelected,
        iconSize: 20,
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(
              label: "Downloads", icon: Icon(Icons.download)),
        ],
      ),
    );
  }
}
