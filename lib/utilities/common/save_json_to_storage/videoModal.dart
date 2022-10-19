class VideoToStoreModal {
  final String videoId;
  final String videoThumbnailUrl;
  final String videoPath;
  final String videoTitle;
  final String videoDuration;

  VideoToStoreModal({
    required this.videoId,
    required this.videoThumbnailUrl,
    required this.videoPath,
    required this.videoTitle,
    required this.videoDuration,
  });

  Map toJson() => {
    'videoId': videoId,
    'videoThumbnailUrl': videoThumbnailUrl,
    'videoPath': videoPath,
    'videoTitle': videoTitle,
    'videoDuration': videoDuration,
  };

}