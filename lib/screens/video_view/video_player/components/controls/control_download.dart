import 'dart:async';
import 'dart:io';

import 'package:app/screens/video_view/video_player/components/dialogs/dialog_download.dart';
import 'package:app/screens/videos_listing/models/video.dart';
import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:app/utilities/common/save_json_to_storage/videoModal.dart';
import 'package:flutter/material.dart';

// package | path provider
import 'package:path_provider/path_provider.dart';

// package | video player
import 'package:video_player/video_player.dart';

// package | uuid
import 'package:uuid/uuid.dart';

// package | dio
import 'package:dio/dio.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

// styles
const TextStyle textControlStyle = TextStyle(
  color: Colors.white,
  fontSize: 14
);
const TextStyle headStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20
);
const TextStyle subHeadStyle = TextStyle(
    fontSize: 13
);
const TextStyle percentageStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14
);

final downloadProgressProvider = StateProvider<int>((_) => 0);
final downloadCompleteProvider = StateProvider<bool>((_) => false);

class ControlDownload extends ConsumerStatefulWidget {
  final VideoPlayerController controller;
  final VideoModal selectedVideo;

  const ControlDownload({
    Key? key,
    required this.controller,
    required this.selectedVideo,
  }) : super(key: key);

  @override
  ConsumerState<ControlDownload> createState() => _ControlDownloadState();
}

class _ControlDownloadState extends ConsumerState<ControlDownload> {
  CancelToken token = CancelToken();
  String downloadIndicator = '0.0%';

  // void | function
  void resetDownloadState() {
    ref.read(downloadProgressProvider.notifier).state = 0;
    ref.read(downloadCompleteProvider.notifier).state = false;
  }

  // Future<String> | function
  Future<String> generateVideoPath() async {
    const uuid = Uuid();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return '$appDocPath/${uuid.v4()}_video_file';
  }

  // void | function
  void showSnackBarMessage(String type, String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      backgroundColor: type == 'success' ? Colors.greenAccent : Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Future<void> | function
  Future<void> saveVideoDetails(String videoPath) async {
    // getting already saved files
    final List<VideoToStoreModal> savedDownloads = await readFile();

    // new file to store
    final videoToStore = VideoToStoreModal(
      videoId: widget.selectedVideo.videoId,
      videoThumbnailUrl: widget.selectedVideo.videoThumbnailUrl,
      videoPath: videoPath,
      videoTitle: widget.selectedVideo.videoTitle,
      videoDuration: widget.selectedVideo.videoDuration
    );

    // adding data to existing list
    savedDownloads.add(videoToStore);

    // updating the file
    writeToFile(savedDownloads);
  }

  // void | function
  void downloadVideo() async {
    final isDownloadedAlready = await checkIdInList(widget.selectedVideo.videoId);
    // check if already downloaded
    if(isDownloadedAlready) {
      showSnackBarMessage(
        'error',
        'Video is already downloaded. Please check download folder.'
      );
      return;
    }

    // continue if not downloaded already
    try {
      final String videoPath = await generateVideoPath();

      // setting default values
      resetDownloadState();

      // showing dialog
      showDialog(
        context: context,
        builder: (context) => openDialog()
      );

      // starting download video
      await Dio().download(
        cancelToken: token,
        widget.selectedVideo.videoUrl,
        videoPath,
        onReceiveProgress: (int received, int total) async {
          if(total != -1) { // if download has size
            double progress = received / total;
            int downloadPercentage = (progress * 100).floor();

            // setting progress to state
            ref.read(downloadProgressProvider.notifier).state = downloadPercentage;

            // when download complete
            if(progress == 1) {
              await saveVideoDetails(videoPath);

              // setting progress to state
              ref.read(downloadCompleteProvider.notifier).state = true;

              // showing message
              showSnackBarMessage('success', "Download Successful");
            }
          }
        }
      );
    } on DioError catch(err) {
      print('onReceiveProgress error while getting the path $err');
    } on Exception catch(err) {
      print('onReceiveProgress exception error while getting the path $err');
    }
  }

  // void | function
  void cancelDownload() {
    // cancelling download
    token.cancel();

    // closing modal
    Navigator.of(context).pop();

    // showing message
    showSnackBarMessage('success', "Download Cancelled");

    ref.read(downloadProgressProvider.notifier).state = 0;
    token = CancelToken();
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10 + 35,
      child: InkWell(
        onTap: downloadVideo,
        child: const Icon(
          Icons.download,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }


  // downloading dialog
  Widget openDialog() => Consumer(
    builder: (BuildContext context, WidgetRef ref, child) {
      final int downloadProgress = ref.watch(downloadProgressProvider);
      final bool isDownloadComplete = ref.watch(downloadCompleteProvider);

      return SimpleDialog(
        titlePadding: const EdgeInsets.only(left: 20, right: 20, bottom: 0, top: 20),
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        title: const Text(
          "Downloading Video",
          style: headStyle,
        ),

        children: [
          const Text(
            "Please do not close the dialog. otherwise the downloading will be cancelled",
            style: subHeadStyle,
          ),
          const SizedBox(height: 15),

          Text(
            '$downloadProgress%',
            textAlign: TextAlign.center,
            style: percentageStyle,
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation(Colors.greenAccent),
              minHeight: 10,
              value: downloadProgress / 100,
            ),
          ),
          const SizedBox(height: 15),

          if(isDownloadComplete) ...[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                elevation: 0,
                backgroundColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Go back'),
            ),
          ] else ...[
            ElevatedButton(
              onPressed: cancelDownload,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 11),
                elevation: 0,
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text('Cancel Download'),
            ),
          ],
        ],
      );
    }
  );
}
