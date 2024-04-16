import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_downloader_test/data/repository/video_repository.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';

part 'video_event.dart';

part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc() : super(VideoState()) {
    on<GetVideosEvent>(_onGetVideo);
    on<AddLocalVideoEvent>(_onAddLocalVideo);
    on<UpdateVideoListEvent>(_onUpdateVideoList);
  }

  _onGetVideo(GetVideosEvent event, Emitter<VideoState> emit) async {
    emit(state.copyWith(isLoading: true));
    final List<VideoStorageItem> videos = await VideoRepository().getVideos();
    for (var element in videos) {
      VideoStorage().videosData.add(element);
    }
    emit(state.copyWith(videos: videos));
  }

  _onAddLocalVideo(AddLocalVideoEvent event, Emitter<VideoState> emit) {
    emit(state.copyWith(isLoading: true));

    VideoStorage().videosData.add(event.localVideo);
    List<VideoStorageItem> videos = state.videos;
    videos.add(event.localVideo);
    emit(state.copyWith(videos: videos));
  }
  _onUpdateVideoList(UpdateVideoListEvent event, Emitter<VideoState> emit) {
    List<VideoStorageItem> videos = VideoStorage().videosData;
    emit(state.copyWith(videos: videos));
  }
}
