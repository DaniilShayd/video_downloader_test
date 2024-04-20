import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/menu_button/menu_button.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/video_card/video_card_view.dart';
import 'video_bloc/video_bloc.dart';

class VideosList extends StatelessWidget {
  const VideosList({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 44),
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            final videos = state.videos;
            if (videos.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (videos.isNotEmpty) {
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
                    }, childCount: videos.length),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                  ),
                ],
              );
            }
            return const Center(child: Text('Videos not found'));
          },
        ),
      );

  }
}
