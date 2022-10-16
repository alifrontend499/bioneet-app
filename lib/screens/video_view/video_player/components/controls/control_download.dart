import 'dart:io';

import 'package:app/screens/video_view/video_player/components/dialogs/dialog_download.dart';
import 'package:app/screens/videos_listing/models/video.dart';
import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:flutter/material.dart';

// package | path provider
import 'package:path_provider/path_provider.dart';

// package | video player
import 'package:video_player/video_player.dart';

// package | uuid
import 'package:uuid/uuid.dart';

// package | dio
import 'package:dio/dio.dart';

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

class ControlDownload extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoModal selectedVideo;

  const ControlDownload({
    Key? key,
    required this.controller,
    required this.selectedVideo,
  }) : super(key: key);

  @override
  State<ControlDownload> createState() => _ControlDownloadState();
}

class _ControlDownloadState extends State<ControlDownload> {
  CancelToken token = CancelToken();
  double progress = 0;
  String downloadIndicator = '0.0%';
  bool isDownloading = false;

  void downloadVideo() async {
    print('onReceiveProgress clicked ${widget.selectedVideo.videoUrl}');

    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      const uuid = Uuid();
      final String path = '$appDocPath/${uuid.v4()}_video_file';

      setState(() {
        isDownloading = true;
      });

      // showDialog(
      //   context: context,
      //   builder: (context) => StatefulBuilder(
      //     builder: (context, setState) => WillPopScope(
      //       onWillPop: () async => true,
      //       child: openDialog(),
      //     )
      //   )
      // );

      await Dio().download(
        cancelToken: token,
        widget.selectedVideo.videoUrl,
        path,
        onReceiveProgress: (int received, int total) {
          if(total != -1) {
            setState(() {
              progress = received / total;
              if(progress == 1) { // download complete
                isDownloading = false;
              }
              downloadIndicator = "${(progress * 100).toStringAsFixed(2)}%";
            });
          }
        }
      );

      // saving details for the video
      // creating data to be saved
      final fileDetails = {
        'videoThumbnailUrl': widget.selectedVideo.videoThumbnailUrl,
        'videoPath': path,
        'videoTitle': widget.selectedVideo.videoTitle,
        'videoDuration': widget.selectedVideo.videoDuration,
      };
      await readFile(); // reading the content of the file

      const snackBar = SnackBar(
        content: Text('File Download successfully!!'),
        backgroundColor: Colors.greenAccent,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } on DioError catch(err) {
      print('onReceiveProgress error while getting the path $err');
    } on Exception catch(err) {
      print('onReceiveProgress exception error while getting the path $err');
    }
  }

  void cancelDownload() {
    // cancelling download
    token.cancel();

    // closing modal
    Navigator.of(context).pop();

    const snackBar = SnackBar(
      content: Text('Download cancelled'),
      backgroundColor: Colors.greenAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10 + 35,
      child: InkWell(
        onTap: () {
          if(isDownloading == false) {
            downloadVideo();
          }
        },
        child: Row(
          children: [
            const Icon(
              Icons.download,
              color: Colors.white,
              size: 22,
            ),
            // if(isDownloading) ...[
            //   const SizedBox(width: 10),
            //   Text(downloadIndicator),
            // ]
          ],
        ),
      )
    );
  }

  Widget openDialog() => SimpleDialog(
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
        '${this.progress.round()}',
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
          value: this.progress.roundToDouble(),
        ),
      ),
      const SizedBox(height: 15),

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
      )
    ],
  );
}
