import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/video_downloader_test.dart';

void main() {


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
  ));
  runApp(const VideoDownloaderTest());
}
