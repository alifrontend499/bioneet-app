import 'package:flutter/material.dart';

// components
import 'package:app/screens/videos_listing/components/silverAppBar.dart';

// data
import 'package:app/screens/videos_listing/data.dart';

// widgets
import 'package:app/screens/videos_listing/widgets/VideoWidget.dart';

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
          slivers: [
        silverAppBarComponent(context),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final data = videosListing[index];
            return VideoWidget(
              video: data,
            );
          }, childCount: videosListing.length),
        )
      ]),

      // body: RefreshIndicator(
      //   onRefresh: onRefresh,
      //   child: ListView.separated(
      //     physics: const BouncingScrollPhysics(),
      //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //     itemCount: videosListing.length,
      //     itemBuilder: (BuildContext context, int index) {
      //       final data = videosListing[index];
      //       return videoWidget(data);
      //     },
      //     separatorBuilder: (BuildContext context, int index) {
      //       return const SizedBox(height: 10);
      //     },
      //   ),
      // ),
    );
  }
}
