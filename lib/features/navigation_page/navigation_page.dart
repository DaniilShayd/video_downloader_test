import 'package:flutter/material.dart';

import '../video_sets_list/video_sets_list.dart';
import '../videos_list/auxiliary_widgets/menu_button/menu_button.dart';
import '../videos_list/videos_list.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;
  bool activeSetCreate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const MenuButton(),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.satellite_rounded),
            icon: Icon(Icons.satellite_rounded),
            label: 'Видео',
          ),
          NavigationDestination(
            icon: Icon(Icons.save_rounded),
            label: 'Сеты',
          ),
        ],
      ),
      body: <Widget>[
        const VideosList(),
        const VideoSetsList(),

      ][currentPageIndex],
    );
  }
}
