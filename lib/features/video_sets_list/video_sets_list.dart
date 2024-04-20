import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/features/video_sets_list/update_video_sets_bloc/update_video_sets_bloc.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/video_card/video_card_view.dart';
import 'package:video_downloader_test/models/video_set/video_set.dart';


class VideoSetsList extends StatelessWidget {
  const VideoSetsList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<VideoSet> sets = VideoStorage().videosSets;

    return Padding(
        padding: const EdgeInsets.only(top: 44),
        child: BlocBuilder<UpdateVideoSetsBloc, UpdateVideoSetsState>(
            builder: (context, state) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (sets.isEmpty) {
                      return const Center(child: Text("Нет сетов"));
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/video_set_view',
                            arguments: <String, dynamic>{
                              'set_index': index,
                            },
                          );
                        },
                        child: VideoCardView(
                          index: VideoStorage()
                              .videosData
                              .indexOf(sets[index].set.first),
                          setTitle: sets[index].setTitle,
                        ),
                      ),
                    );
                  },
                  childCount: sets.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              )
            ],
          );
        }));
  }
}
