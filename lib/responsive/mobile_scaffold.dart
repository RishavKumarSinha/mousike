import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousike/components/mydrawer.dart';
import 'package:mousike/util/my_box.dart';
import 'package:mousike/util/my_tile.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('MOUSIKE'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        titleSpacing: 20,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 24,
          fontFamily: GoogleFonts.pacifico().fontFamily,
        ),
        centerTitle: false,
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
                    aspectRatio: 4,
                    child: SizedBox(
                      width: double.infinity,
                      child: GridView.builder(
                        itemCount: 4,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          // Define the list of image paths
                          final imagePaths = [
                            'assets/images/champion.jpeg',
                            'assets/images/peru.jpeg',
                            'assets/images/danger.jpeg',
                            'assets/images/home.jpeg',
                          ];

                          return MyBox(
                            imagePaths: [imagePaths[index]], // Pass one image path per box
                          );
                        },
                      ),
                    ),
                  ),

            Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            MyTile(song: Song(songName: "FireFlies", artistName: "Owl City", albumArtImagePath: 'assets/images/fireflies.jpeg'),),
                            MyTile(song: Song(songName: "One(Is the Loneliest Number)", artistName: "L'Orchestra Cinematica", albumArtImagePath: "assets/images/one.jpeg"),),
                            MyTile(song: Song(songName: "CornField Chase", artistName: "Hans Zimmer", albumArtImagePath: "assets/images/interstellar.jpg"),),
                            MyTile(song: Song(songName: "Sparkle", artistName: "RADWIMPS", albumArtImagePath: "assets/images/sparkle.jpg"),),
                            MyTile(song: Song(songName: "SpaceSong", artistName: "BeachHouse", albumArtImagePath: "assets/images/spacesong.jpg"),),
                            MyTile(song: Song(songName: "All the Stars", artistName: "Kendrick Lamar", albumArtImagePath: "assets/images/allthestars.jpeg"),),
                            MyTile(song: Song(songName: "I See Fire", artistName: "Ed Sheeran", albumArtImagePath: "assets/images/iseefire.jpg"),),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}