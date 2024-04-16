import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';

part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String title,
    required Map<String, String> assets,
  }) = _Video;

  factory Video.fromJson(Map<String, Object?> json) => _$VideoFromJson(json);
}
