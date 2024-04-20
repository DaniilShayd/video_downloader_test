import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/video_card/video_card_view.dart';
import 'package:video_downloader_test/features/videos_list/create_set_bloc/create_set_bloc.dart';
import 'package:video_downloader_test/models/video_set/video_set.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'video_bloc/video_bloc.dart';

class VideosList extends StatefulWidget {
  const VideosList({super.key});

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  TextEditingController _setNameEditingController = TextEditingController();
  final List<bool?> newSetList = [];

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
            if (newSetList.length < videos.length) {
              newSetList.addAll(List.generate(videos.length - newSetList.length, (index) => false));
            }


            return BlocBuilder<CreateSetBloc, bool>(
              builder: (context, state) {
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: <Widget>[
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
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
                                ),
                                if (state)
                                  Container(
                                    padding: const EdgeInsets.only(right: 20),
                                    alignment: Alignment.topRight,
                                    child: Checkbox(
                                      value: newSetList[index],
                                      onChanged: (bool? checkVideo) {
                                        setState(() {
                                          newSetList[index] = checkVideo!;
                                          print(newSetList);
                                        });
                                      },
                                    ),
                                  ),
                              ],
                            );
                          }, childCount: videos.length),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                        ),
                      ],
                    ),
                    if (state)
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.bottomLeft,
                        child: ElevatedButton(
                          onPressed: () async{
                            final List<VideoStorageItem> videoSetList = [];
                            for (int addVideo = 0; addVideo < newSetList.length; addVideo ++) {
                              if (newSetList[addVideo] == true) {
                                videoSetList.add(videos[addVideo]);
                              }
                            }
                            String? videoSetTitle = await _createNewSetNameDialog(context);
                            if (videoSetList.isNotEmpty){
                              VideoStorage().videosSets.add(VideoSet(setTitle: videoSetTitle ?? "MyNewSet", set: videoSetList));

                            }
                            context.read<CreateSetBloc>().add(CreateSetEvent());
                          },
                          child: const Text("Создать новый сет"),
                        ),
                      ),
                  ],
                );
              },
            );
          }
          return const Center(child: Text('Videos not found'));
        },
      ),
    );
  }
  Future<String?> _createNewSetNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: TextField(
              controller: _setNameEditingController,
              decoration: const InputDecoration(hintText: "Введите название нового сета"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context, _setNameEditingController.text),
              ),
            ],
          );
        });
  }
}
