import 'package:flutter/material.dart';

// package | video player
import 'package:video_player/video_player.dart';

// styles
import 'package:app/screens/video_view/video_player/components/settngs/styles/settings_styles.dart';

Widget playerVideoSpeed(context, VideoPlayerController controller) {

  void setVideoSpeed(double speed) {
    // setting speed
    controller.setPlaybackSpeed(speed);

    // closing bottomsheet
    Navigator.pop(context);
  }

  return Container(
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // child | top small bar
        SizedBox(
          width: 40,
          height: 6,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),

        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(0.25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          '0.25x',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(0.50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          '0.50x',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          'Normal',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(1.25),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          '1.25x',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(1.50),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          '1.50x',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // child link
                InkWell(
                  highlightColor: Colors.black12,
                  splashColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () => setVideoSpeed(2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Text(
                          '2x',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}