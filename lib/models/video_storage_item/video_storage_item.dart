import '../video/video.dart';
import '../video_type/video_type.dart';

class VideoStorageItem {
  Video video;
  final VideoType videoType;

  VideoStorageItem({required this.video, required this.videoType});

  VideoStorageItem copyWith({
    Video? video,
    VideoType? videoType,
  }) {
    return VideoStorageItem(
      video: video ?? this.video,
      videoType: videoType ?? this.videoType,
    );
  }
}
