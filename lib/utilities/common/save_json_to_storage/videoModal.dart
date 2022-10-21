class VideoToStoreModal {
  final String videoId;
  final String videoThumbnailUrl;
  final String videoPath;
  final String videoTitle;
  final String videoDuration;
  final String timeStamp;

  VideoToStoreModal({
    required this.videoId,
    required this.videoThumbnailUrl,
    required this.videoPath,
    required this.videoTitle,
    required this.videoDuration,
    required this.timeStamp
  });

  Map toJson() => {
    'videoId': videoId,
    'videoThumbnailUrl': videoThumbnailUrl,
    'videoPath': videoPath,
    'videoTitle': videoTitle,
    'videoDuration': videoDuration,
    'timeStamp': timeStamp,
  };

}