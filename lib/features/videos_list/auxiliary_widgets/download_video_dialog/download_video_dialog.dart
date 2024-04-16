

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_downloader_test/data/storage/video_storage.dart';
import 'package:video_downloader_test/features/videos_list/videos_list.dart';
import 'package:video_downloader_test/models/video/video.dart';
import 'package:video_downloader_test/models/video_storage_item/video_storage_item.dart';
import 'package:video_downloader_test/models/video_type/video_type.dart';

class DownloadVideoDialog extends StatelessWidget {
  const DownloadVideoDialog({super.key});

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

                  final file = result.files.first;
                  VideoStorage().videosData.add(VideoStorageItem(
                      Video(
                          title: file.name,
                          assets: {'mp4': file.path.toString()}),
                      VideoType.file));
                },
                color: const Color(0xFFF5BA41)),
            _buildElevatedButton(
              text: "Готово",
              onPressed: () {},
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
      height: 44,
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(14)),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintStyle: TextStyle(),
          hintText: 'Название видео.com',
          contentPadding: EdgeInsets.all(8),
          border: InputBorder.none,
        ),
        scribbleEnabled: false,
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
