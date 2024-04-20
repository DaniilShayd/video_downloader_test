import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';

class VideoSet {
  final String setTitle;
  final List<VideoStorageItem> set;

  VideoSet({
    required this.setTitle,
    required this.set,
  });
}
