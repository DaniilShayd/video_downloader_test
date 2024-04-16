part of 'video_bloc.dart';

class VideoState {
  final List<VideoStorageItem> videos;
  final bool isLoading;

  VideoState({
    this.videos = const [],
    this.isLoading = false,
  });

  VideoState copyWith({
    List<VideoStorageItem>? videos,
    bool isLoading = false,
  }) {
    return VideoState(
      videos: videos ?? this.videos,
      isLoading: isLoading,
    );
  }
}
