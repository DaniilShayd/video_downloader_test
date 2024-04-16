import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/features/videos_list/videos_list.dart';
import 'package:video_downloader_test/video_downloader_test.dart';

import 'features/videos_list/video_bloc/video_bloc.dart';

class VideoDownloaderWrapper extends StatelessWidget {
  const VideoDownloaderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideoBloc>(
      create: (context) => VideoBloc()..add(GetVideosEvent()),
      child: VideoDownloaderTest(),
    );
  }
}
