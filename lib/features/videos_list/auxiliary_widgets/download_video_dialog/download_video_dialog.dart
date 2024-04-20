import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_test/features/videos_list/video_bloc/video_bloc.dart';
import 'package:video_downloader_test/models/video/video.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';

class DownloadVideoDialog extends StatefulWidget {
  const DownloadVideoDialog({super.key});

  @override
  State<DownloadVideoDialog> createState() => _DownloadVideoDialogState();
}

class _DownloadVideoDialogState extends State<DownloadVideoDialog> {
  late TextEditingController videoNameTextController;
  String? videoName;
  PlatformFile? videoFile;

  @override
  void initState() {
    super.initState();
    videoNameTextController = TextEditingController();
  }

  @override
  void dispose() {
    videoNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      actionsAlignment: MainAxisAlignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      actions: <Widget>[
        Column(
          children: [
            _buildTextField(),
            _buildElevatedButton(
                text: "загрузить видео",
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                  videoFile = result.files.first;
                  videoNameTextController.text = videoFile!.name;
                },
                color: const Color(0xFFF5BA41)),
            _buildElevatedButton(
              text: "Готово",
              onPressed: () {
                if (videoFile != null) {
                  context.read<VideoBloc>().add(AddLocalVideoEvent(
                      localVideo: VideoStorageItem(
                          video: Video(
                              title: videoName ?? videoFile!.name,
                              assets: {'mp4': videoFile!.path.toString()}),
                          videoType: VideoType.file)));
                }
                Navigator.pop(context);
              },
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      width: 244,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: TextField(
        maxLines: 1,
        decoration: const InputDecoration(
          hintStyle: TextStyle(),
          hintText: 'Название видео.com',
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
        ),
        scribbleEnabled: false,
        controller: videoNameTextController,
        onChanged: (String value) {
          videoName = value;
        },
      ),
    );
  }

  Widget _buildElevatedButton(
      {required String text,
      required VoidCallback onPressed,
      required Color color}) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: 254,
      height: 54,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
