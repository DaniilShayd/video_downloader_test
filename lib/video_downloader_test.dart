import 'package:flutter/material.dart';
import 'package:video_downloader_test/features/videos_list/videos_list.dart';
import 'package:video_downloader_test/routes/routes.dart';
import 'package:video_downloader_test/theme/color_schemes.g.dart';
final rootKey = GlobalKey<NavigatorState>();

class VideoDownloaderTest extends StatelessWidget {
  const VideoDownloaderTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: rootKey,
      title: "video",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: false, colorScheme: darkColorScheme),
      routes: routes,
    );
  }
}
