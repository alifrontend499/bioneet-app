import 'dart:convert';

import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:app/utilities/common/save_json_to_storage/videoModal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  void buttonAction() async {
    final isExist = await readFile();

    print('isDownloadedAlready length ${isExist.length}');
    isExist.forEach((element) {
      print('isDownloadedAlready where ${element.videoId}');
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: buttonAction,
          child: Text('click me here'),
        ),
      ),
    );
  }
}

