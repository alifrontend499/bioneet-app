import 'package:app/screens/videos_listing/widgets/videoDownloadedWidget.dart';
import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:app/utilities/common/save_json_to_storage/videoModal.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../videos_listing/models/video.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  late Future<List<VideoModal>> downloadsData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    downloadsData = getDownloads();
  }

  // function | List - VideoToStoreModal
  Future<List<VideoModal>> getDownloads() async {
    final downloadsData = await readFile();
    return downloadsData;
  }

  // function | void
  Future<void> onRefresh() async {
    setState(() {
      downloadsData = getDownloads();
    });

    // closing all toasts
    Fluttertoast.cancel();
    // showing toast
    Fluttertoast.showToast(msg: 'List Updated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),

      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: FutureBuilder <List<VideoModal>>(
          future: downloadsData,
          builder: (context, snapshot) {
            print('downloadsData snapshot ${snapshot.hasData}');
            if(snapshot.hasData) {
              List<VideoModal> data = snapshot.data!;
              return buildData(data);
            }
            if(!snapshot.hasData) {
              return const Text('No downloads found. Pull to refresh');
            }
            return const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
        ),
      ),
    );
  }

  // data listing view
  Widget buildData(List<VideoModal> data) => ListView.separated(
    // physics: const BouncingScrollPhysics(),
    separatorBuilder: (context, i) {
      return const Divider();
    },
    itemCount: data.length,
    itemBuilder: (context, i) {
      return Column(
        children: [
          VideoDownloadedWidget(
            video: data[i],
          ),
        ],
      );
    },
  );
}

