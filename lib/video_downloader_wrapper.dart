import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloader_test/features/video_sets_list/update_video_sets_bloc/update_video_sets_bloc.dart';
import 'package:video_downloader_test/features/videos_list/create_set_bloc/create_set_bloc.dart';
import 'package:video_downloader_test/video_downloader_test.dart';

import 'features/videos_list/video_bloc/video_bloc.dart';

class VideoDownloaderWrapper extends StatelessWidget {
  const VideoDownloaderWrapper({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VideoBloc>(
          create: (context) =>
          VideoBloc()
            ..add(GetVideosEvent()),
        ),
        BlocProvider<CreateSetBloc>(
          create: (context) =>
          CreateSetBloc(),
        ),
        BlocProvider<UpdateVideoSetsBloc>(
          create: (context) =>
              UpdateVideoSetsBloc(),
        ),
      ],
      child: VideoDownloaderTest(),
    );
  }
}
