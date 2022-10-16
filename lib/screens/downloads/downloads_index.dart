import 'package:app/utilities/common/save_json_to_storage/index.dart';
import 'package:flutter/material.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  void buttonAction() async {
    print('updated data ');
    await readFile();
    writeToFile('videoThumbnailUrl', 'videoThumbnailUrl');

    final updatedData = await readFile();
    print('updated data $updatedData');
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

