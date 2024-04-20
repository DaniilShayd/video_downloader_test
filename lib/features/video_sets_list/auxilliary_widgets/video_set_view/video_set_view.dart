import 'package:flutter/material.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video_set/video_set.dart';

import '../../../videos_list/auxiliary_widgets/video_card/video_card_view.dart';

class VideoSetView extends StatelessWidget {
  const VideoSetView({super.key});

  @override
  Widget build(BuildContext context) {

    final arguments =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final int index = arguments['set_index'] as int;
    final VideoSet indexedSet = VideoStorage().videosSets[index];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 44),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                  padding: const EdgeInsets.all(8),
                  child: VideoCardView(
                  index: VideoStorage()
                  .videosData
                  .indexOf(indexedSet.set[index]),
              ),
              );
            },
            childCount: indexedSet.set.length),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3))
          ],
        ),
      ),
    );
  }
}
