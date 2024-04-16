import 'dart:ffi';
import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
  });

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late FlickManager flickManager;

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int index = arguments['index'] as int;
    final String videoLink =
        VideoStorage().videosData[index].video.assets['mp4'].toString();

    if (VideoStorage().videosData[index].videoType == VideoType.network) {
      flickManager = FlickManager(
          videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(videoLink)));
    } else {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.file(File(videoLink)));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: FlickVideoPlayer(
            flickManager: flickManager,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.black,
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(
            "Изменить название видео",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
}
