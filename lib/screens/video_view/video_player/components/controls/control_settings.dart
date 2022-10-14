import 'package:flutter/material.dart';

// package | video player
import 'package:video_player/video_player.dart';

// settings
import 'package:app/screens/video_view/video_player/components/settngs/setting_player_settings.dart';

class ControlSettings extends StatefulWidget {
  final VideoPlayerController controller;

  const ControlSettings({
    Key? key,
    required this.controller
  }) : super(key: key);

  @override
  State<ControlSettings> createState() => _ControlSettingsState();
}

class _ControlSettingsState extends State<ControlSettings> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: InkWell(
        onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ),
          ),
          builder: (context) => playerSettings(context, widget.controller),
        ),
        child: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 20,
        ),
      )
    );
  }
}


