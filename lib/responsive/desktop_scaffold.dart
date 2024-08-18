import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mousike/components/mydrawer.dart';
import '../util/my_box.dart';
import '../util/my_tile.dart';

class DesktopScaffold extends StatefulWidget {
  DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // open drawer
            const MyDrawer(),

            // first half of page
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  // first 4 boxes in grid
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


                  // list of previous days
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            MyTile(
                              song: Song(
                                  songName: "FireFlies",
                                  artistName: "Owl City",
                                  albumArtImagePath:
                                      'assets/images/fireflies.jpeg'),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "One(Is the Loneliest Number)",
                                  artistName: "L'Orchestra Cinematica",
                                  albumArtImagePath: "assets/images/one.jpeg"),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "CornField Chase",
                                  artistName: "Hans Zimmer",
                                  albumArtImagePath:
                                      "assets/images/interstellar.jpg"),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "Sparkle",
                                  artistName: "RADWIMPS",
                                  albumArtImagePath:
                                      "assets/images/sparkle.jpg"),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "SpaceSong",
                                  artistName: "BeachHouse",
                                  albumArtImagePath:
                                      "assets/images/spacesong.jpg"),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "All the Stars",
                                  artistName: "Kendrick Lamar",
                                  albumArtImagePath:
                                      "assets/images/allthestars.jpeg"),
                            ),
                            MyTile(
                              song: Song(
                                  songName: "I See Fire",
                                  artistName: "Ed Sheeran",
                                  albumArtImagePath:
                                      "assets/images/iseefire.jpg"),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // second half of page
           Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 335,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[400],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/images.jpeg', // Replace with your image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/pokemon.png', // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
