class VideoModal {
  final String videoId;
  final String videoUrl;
  final String videoThumbnailUrl;
  final String videoTitle;
  final String videoDuration;
  final DateTime timeStamp;

  VideoModal(
      {required this.videoId,
      required this.videoUrl,
      required this.videoThumbnailUrl,
      required this.videoTitle,
      required this.videoDuration,
      required this.timeStamp});
}
