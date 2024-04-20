part of 'update_video_sets_bloc.dart';

@immutable
class UpdateVideoSetsState {
  final List<VideoSet> sets;
  final bool isLoading;

  UpdateVideoSetsState({
    this.sets = const [],
    this.isLoading = false,
  });

  UpdateVideoSetsState copyWith({
    List<VideoSet>? sets,
    bool isLoading = false,
  }) {
    return UpdateVideoSetsState(
      sets: sets ?? this.sets,
      isLoading: isLoading,
    );
  }
}

final class UpdateVideoSetsInitial extends UpdateVideoSetsState {}
