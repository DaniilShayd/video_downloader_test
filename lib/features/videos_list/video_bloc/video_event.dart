part of 'video_bloc.dart';

@immutable
sealed class VideoEvent {}

class GetVideosEvent extends VideoEvent {}

class AddLocalVideoEvent extends VideoEvent {
  final VideoStorageItem localVideo;

  AddLocalVideoEvent({required this.localVideo});
}

class UpdateVideoListEvent extends VideoEvent {}
