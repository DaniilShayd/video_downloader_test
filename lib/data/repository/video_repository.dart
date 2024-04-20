import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';

import '../../models/video/video.dart';

class VideoRepository {
  Future<List<VideoStorageItem>> getVideos() async {
    String username = "Aqp7qj954LdNC7hJITlTBviub1wtYtRzcNK6z6BYWHT";
    String password = "";

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    final response = await Dio().get(
      "https://sandbox.api.video/videos",
      options: Options(
        headers: {
          'Authorization': basicAuth,
        },
      ),
    );
    debugPrint(response.toString());

    List<VideoStorageItem> videos = [];
    ((response.data as Map<String, dynamic>)['data'] as List<dynamic>)
        .forEach((element) {
      videos.add(VideoStorageItem(
          video: Video.fromJson(element), videoType: VideoType.network));
    });
    //debugPrint(videos.first.assets['mp4']);

    return videos;
  }
}
