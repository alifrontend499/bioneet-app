import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// miniplayer
import 'package:miniplayer/miniplayer.dart';

// providers
import 'package:app/screens/main_content/main_content_index.dart';

// package | video player
import 'package:video_player/video_player.dart';
// package | auto orientation
// import 'package:auto_orientation/auto_orientation.dart';

// package | riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ControlFullScreen extends ConsumerStatefulWidget {
  final VideoPlayerController controller;
  final Orientation orientation;

  const ControlFullScreen({
    Key? key,
    required this.controller,
    required this.orientation
  }) : super(key: key);

  @override
  ConsumerState<ControlFullScreen> createState() => _ControlFullScreenState();
}

class _ControlFullScreenState extends ConsumerState<ControlFullScreen> {

  Future setLandScape() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]
    );
    ref.read(isPlayerFullScreenProvider.notifier).state = true;
    // setting mini player to full screen
    ref.read(miniPlayerControllerProvider.notifier).state.animateToHeight(
        state: PanelState.MAX
    );
  }

  Future setPortrait() async {
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    await SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown
        ]
    );
    ref.read(isPlayerFullScreenProvider.notifier).state = false;

    // setting mini player to full screen
    ref.read(miniPlayerControllerProvider.notifier).state.animateToHeight(
        state: PanelState.MAX
    );
  }

  void toggleViewport() {
    final isFullScreen = ref.watch(isPlayerFullScreenProvider);

    if(isFullScreen) {
      setPortrait();
    } else {
      setLandScape();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = widget.orientation == Orientation.portrait;

    return Positioned(
      bottom: 10,
      right: 5,
      child: InkWell(
        onTap: toggleViewport,
        child: const Icon(
          Icons.fullscreen,
          color: Colors.white,
          size: 23,
        ),
      ),
    );
  }
}
