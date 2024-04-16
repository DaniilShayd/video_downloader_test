import 'package:flutter/material.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';

import '../../../../models/video/video.dart';

class VideoCardView extends StatelessWidget {
  final int index;

  const VideoCardView({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Stack(fit: StackFit.expand, children: [
              Image.network(
                VideoStorage().videosData[index].video.assets['thumbnail'] ==
                        null
                    ? 'https://pub-static.fotor.com/assets/bg/e9f1764c-0bdc-496a-be56-2aef89924b4b.jpg'
                    : VideoStorage()
                        .videosData[index]
                        .video
                        .assets['thumbnail']
                        .toString(),

                fit: BoxFit.fill,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const LinearProgressIndicator();
                },
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ]),
          ),
        ),
        Text(VideoStorage().videosData[index].video.title, maxLines: 1,),
      ],
    );
  }
}
