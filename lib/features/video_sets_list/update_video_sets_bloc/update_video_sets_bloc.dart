import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video_set/video_set.dart';


part 'update_video_sets_event.dart';

part 'update_video_sets_state.dart';

class UpdateVideoSetsBloc
    extends Bloc<UpdateVideoSetsEvent, UpdateVideoSetsState> {
  UpdateVideoSetsBloc() : super(UpdateVideoSetsState()) {
    on<UpdateVideoSetsEvent>(
      (event, emit) {
        emit(UpdateVideoSetsState().copyWith(sets: VideoStorage().videosSets));
      },
    );
  }
}
