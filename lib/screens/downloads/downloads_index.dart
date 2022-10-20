import 'package:app/screens/videos_listing/widgets/videoDownloadedWidget.dart';
import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:app/utilities/common/save_json_to_storage/videoModal.dart';

import 'package:flutter/material.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  late Future<List<VideoToStoreModal>> downloadsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    downloadsData = getDownloads();

    print('downloadsData $downloadsData');
  }



  Future<List<VideoToStoreModal>> getDownloads() async {
    final downloadsData = await readFile();
    print('downloadsData inside ${downloadsData.length}');
    return downloadsData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),

      body: FutureBuilder <List<VideoToStoreModal>>(
        future: downloadsData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<VideoToStoreModal> data = snapshot.data!;
            return buildData(data);
          } else {
            return const Text('No donwloads found. Pull to refresh');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  // data listing view
  Widget buildData(List<VideoToStoreModal> data) => ListView.separated(
    // padding: const EdgeInsets.all(20),
    separatorBuilder: (context, i) {
      return const Divider();
    },
    itemCount: data.length,
    itemBuilder: (context, i) {
      return VideoDownloadedWidget(
        video: data[i],
      );
    },
  );
}

