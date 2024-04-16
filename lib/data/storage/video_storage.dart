
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';

import '../../models/video/video.dart';


class VideoStorage {
  static final VideoStorage _instance = VideoStorage._internal();

  final List<VideoStorageItem> videosData = [];

  factory VideoStorage() {
    return _instance;
  }

  VideoStorage._internal();


}