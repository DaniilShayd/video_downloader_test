import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../models/video/video.dart';

class VideoRepository {
  Future<List<Video>> getVideos() async {
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

    List<Video> videos = [];
    ((response.data as Map<String, dynamic>)['data'] as List<dynamic>)
        .forEach((element) {
      videos.add(Video.fromJson(element));
    });
    //debugPrint(videos.first.assets['mp4']);

    return videos;
  }
}
