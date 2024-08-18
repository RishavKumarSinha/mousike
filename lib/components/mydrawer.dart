import 'package:flutter/material.dart';
import 'package:mousike/playlist_page.dart';
import 'package:mousike/search_page.dart';
import 'package:mousike/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var drawerTextColor = TextStyle(
      color: Theme.of(context).colorScheme.inversePrimary,
    );
    var tilePadding = const EdgeInsets.only(left: 8.0, right: 8, top: 8);
    return DrawerTheme(
      data: DrawerThemeData(
        backgroundColor: Theme.of(context).colorScheme.surface,
        scrimColor:
            Theme.of(context).colorScheme.inversePrimary,
        shadowColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Drawer(
        surfaceTintColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(
                Icons.music_note_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 64,
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'D A S H B O A R D',
                  style: drawerTextColor,
                ),
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(
                  Icons.library_music,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'P L A Y L I S T',
                  style: drawerTextColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlaylistPage(),
                      )
                  );
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(
                  Icons.travel_explore,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'S E A R C H',
                  style: drawerTextColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'S E T T I N G S',
                  style: drawerTextColor,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsPage(),
                      ));
                },
              ),
            ),
            Padding(
              padding: tilePadding,
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: Text(
                  'L O G O U T',
                  style: drawerTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
