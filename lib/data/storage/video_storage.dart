import 'package:video_downloader_test/models/video_set/video_set.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';


class VideoStorage {
  static final VideoStorage _instance = VideoStorage._internal();

  final List<VideoStorageItem> videosData = [];
  final List<VideoSet> videosSets = [];

  factory VideoStorage() {
    return _instance;
  }

  VideoStorage._internal();
}
