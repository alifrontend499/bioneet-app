import 'package:flutter/material.dart';

// components
import 'package:app/screens/videos_listing/components/silverAppBar.dart';

// data
import 'package:app/screens/videos_listing/data.dart';

// widgets
import 'package:app/screens/videos_listing/widgets/VideoWidget.dart';

// package | riverpd
import 'package:flutter_riverpod/flutter_riverpod.dart';

// modal
import 'package:app/screens/videos_listing/models/video.dart';

// screen
import 'package:app/screens/main_content/main_content_index.dart';

class VideosListingScreen extends StatefulWidget {
  const VideosListingScreen({Key? key}) : super(key: key);

  @override
  State<VideosListingScreen> createState() => _VideosListingScreenState();
}

class _VideosListingScreenState extends State<VideosListingScreen> {
  Future<void> onRefresh() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? _) {
          final VideoModal? selectedVideo = ref.watch(selectedVideoProvider);

          return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                silverAppBarComponent(context),
                SliverPadding(
                  padding: selectedVideo != null ? const EdgeInsets.only(bottom: 60) : const EdgeInsets.only(bottom: 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final data = videosListing[index];
                      return VideoWidget(
                        video: data,
                      );
                    }, childCount: videosListing.length),
                  ),
                ),
              ]);
        },
      ),
    );
  }
}
