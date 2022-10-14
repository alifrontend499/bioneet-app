import 'package:flutter/material.dart';

// package | video player
import 'package:video_player/video_player.dart';

// styles
import 'package:app/screens/video_view/video_player/components/settngs/styles/settings_styles.dart';

// controls
import 'package:app/screens/video_view/video_player/components/settngs/setting_video_speed.dart';

Widget playerSettings(context, VideoPlayerController controller) {
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
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      ),
                    ),
                    builder: (context) => playerVideoSpeed(context, controller),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Icon(Icons.speed),
                        SizedBox(width: 15),

                        Text(
                          'Speed',
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
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: const [
                        Icon(Icons.dangerous),
                        SizedBox(width: 15),

                        Text(
                          'Report',
                          style: bottomSheetLinkTextStyles,
                        ),
                      ],
                    ),
                  ),
                ),




              ],
            ),
          ),
        ),
      ],
    ),
  );
}