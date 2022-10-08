import 'package:flutter/material.dart';

class VideoViewScreen extends StatefulWidget {
  const VideoViewScreen({Key? key}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('hello there'),
    );
  }
}
