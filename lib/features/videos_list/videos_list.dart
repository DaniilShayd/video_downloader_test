import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:video_downloader_test/data/repository/video_repository.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/menu_button/menu_button.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/video_card/video_card_view.dart';

import '../../models/video/video.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  GlobalKey<_VideosListState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MenuButton(),
        body: Padding(
          padding: const EdgeInsets.only(top: 44),
          child: FutureBuilder(
            future: VideoRepository().getVideos(),
            builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Align(
                  alignment: Alignment.center,
                  child: Text('Error'),
                );
              } else if (snapshot.hasData) {
                VideoStorage().videosData.removeWhere((element) => element.videoType == VideoType.network);
                for (Video element in snapshot.data!) {
                  VideoStorage()
                      .videosData
                      .add(VideoStorageItem(element, VideoType.network));
                }
              }

              return CustomScrollView(
                slivers: <Widget>[
                  SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(

                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/video_player',
                                arguments: <String, dynamic>{
                                  'index': index,
                                },
                              );
                            },
                            child: VideoCardView(index: index)),
                      );
                    }, childCount: VideoStorage().videosData.length),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                  ),
                ],
              );
            },
          ),
        ),
      );
  }
}
