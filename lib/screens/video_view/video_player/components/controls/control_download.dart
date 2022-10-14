import 'dart:io';

import 'package:flutter/material.dart';

// package | path provider
import 'package:path_provider/path_provider.dart';

// package | video player
import 'package:video_player/video_player.dart';

// package | uuid
// import 'package:uuid/uuid.dart';

// package | dio
// import 'package:dio/dio.dart';

// styles
const TextStyle textControlStyle = TextStyle(
  color: Colors.white,
  fontSize: 14
);

class ControlDownload extends StatefulWidget {
  final VideoPlayerController controller;
  final String videoUrl;

  const ControlDownload({
    Key? key,
    required this.controller,
    required this.videoUrl
  }) : super(key: key);

  @override
  State<ControlDownload> createState() => _ControlDownloadState();
}

class _ControlDownloadState extends State<ControlDownload> {

  double progress = 0;
  String downloadIndicator = '0.0%';
  bool isDownloading = false;

  void downloadVideo() async {
    print('onReceiveProgress clicked');
    // try {
    //   Directory appDocDir = await getApplicationDocumentsDirectory();
    //   String appDocPath = appDocDir.path;
    //   const uuid = Uuid();
    //   final String path = '$appDocPath/${uuid.v4()}_video_file';
    //
    //   setState(() {
    //     isDownloading = true;
    //   });
    //
    //   final response = await Dio().download(
    //     widget.videoUrl,
    //     path,
    //     onReceiveProgress: (int received, int total) {
    //       print('onReceiveProgress receiveBytes $received');
    //       print('onReceiveProgress totalBytes $total');
    //
    //       if(total != -1) {
    //         setState(() {
    //           progress = received / total;
    //           if(progress == 1) { // download complete
    //             isDownloading = false;
    //           }
    //           downloadIndicator = "${(progress * 100).toStringAsFixed(2)}%";
    //
    //         });
    //       }
    //
    //     }
    //   );
    //
    //   const snackBar = SnackBar(
    //     content: Text('File Download successfully!! pls check the download folder'),
    //     backgroundColor: Colors.greenAccent,
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //
    //   print('onReceiveProgress here file $path');
    //   print('onReceiveProgress here $response');
    //
    // } on DioError catch(err) {
    //   print('onReceiveProgress error while getting the path $err');
    //   const snackBar = SnackBar(
    //     content: Text('Unknown error occured please try again'),
    //     backgroundColor: Colors.redAccent,
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // } on Exception catch(err) {
    //   print('onReceiveProgress exception error while getting the path $err');
    //   const snackBar = SnackBar(
    //     content: Text('Unknown error occured please try again'),
    //     backgroundColor: Colors.redAccent,
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // }
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
              size: 19,
            ),
            const SizedBox(width: 5),

            Text('prog: $downloadIndicator', style: const TextStyle(color: Colors.white),)
          ],
        ),
      )
    );
  }
}
