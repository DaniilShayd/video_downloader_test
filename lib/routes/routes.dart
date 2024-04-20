import 'package:video_downloader_test/features/video_player/video_player.dart';
import 'package:video_downloader_test/features/videos_list/auxiliary_widgets/menu_button/menu_button.dart';

import 'package:video_downloader_test/features/videos_list/videos_list.dart';

import '../features/navigation_page/navigation_page.dart';

final routes = {
  "/" : (context) => const NavigationPage(),
  "/video_player" : (context) =>  const VideoPlayer(),
  "/videos_list/menu_button": (context) => const MenuButton(),
};