import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/features/videos_list/create_set_bloc/create_set_bloc.dart';

import '../download_video_dialog/download_video_dialog.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              height: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text("Создать сет"),
                    onPressed: () {
                      context.read<CreateSetBloc>().add(CreateSetEvent());
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Добавить видео"),
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DownloadVideoDialog();
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
