import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/models/video/video.dart';

import '../../videos_list/video_bloc/video_bloc.dart';

class ChangeVideoNameButton extends StatefulWidget {
  const ChangeVideoNameButton({super.key, required this.videoIndex});

  final int videoIndex;

  @override
  State<ChangeVideoNameButton> createState() => _ChangeVideoNameButtonState();
}

class _ChangeVideoNameButtonState extends State<ChangeVideoNameButton> {
  late TextEditingController videoNameTextController;
  late String videoSaveText;

  @override
  void initState() {
    super.initState();
    videoNameTextController = TextEditingController();
    videoNameTextController.text =
        VideoStorage().videosData[widget.videoIndex].video.title;
    videoSaveText = videoNameTextController.text;
  }

  @override
  void dispose() {
    videoNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _showNameChangeModalBottomSheet,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        side: const BorderSide(color: Colors.white, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 80.0),
        child: Text(
          "Изменить название видео",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void _showNameChangeModalBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.black54,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    onChanged: (String value) {
                      videoSaveText = value;
                    },
                    controller: videoNameTextController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                  _buildChangeNameButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChangeNameButton() {
    return ElevatedButton(
      onPressed: () {
        Map<String, String> videoAsset =
            VideoStorage().videosData[widget.videoIndex].video.assets;
        VideoStorage().videosData[widget.videoIndex].video =
            Video(title: videoSaveText, assets: videoAsset);

        context.read<VideoBloc>().add(UpdateVideoListEvent());
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        side: const BorderSide(color: Colors.white, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 90.0),
        child: Text(
          "Применить изменения",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
