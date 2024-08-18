import 'package:flutter/material.dart';
import 'package:mousike/models/playlist_provider.dart';
import 'package:mousike/models/song.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/mobile_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:mousike/song_page.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  late final PlaylistProvider playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    
    // Add the hardcoded "Celestial" song if not already added
    playlistProvider.addCelestialSongIfNotAdded();
  }

  void goToSong(int index) {
    playlistProvider.currentSongIndex = index;
    
    // Start playing the song before navigating to the SongPage
    playlistProvider.play();

    // Navigate to the SongPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResponsiveLayout(
                  mobileScaffold: MobileScaffold(),
                  tabletScaffold: TabletScaffold(),
                  desktopScaffold: DesktopScaffold(),
                ),
              ),
            );
          },
        ),
        title: Text(
          'P L A Y L I S T',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];

              return ListTile(
                title: Text(
                  song.songName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                subtitle: Text(
                  song.artistName,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: song.albumArtImagePath.startsWith('http')
                      ? Image.network(
                          song.albumArtImagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        )
                      : Image.asset(
                          song.albumArtImagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirm Deletion',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                          content: Text('Are you sure you want to delete this song from the playlist?',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                          actions: [
                            TextButton(
                              child: Text('Cancel',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                              onPressed: () {
                                Navigator.of(context).pop(); // Dismiss the dialog
                              },
                            ),
                            TextButton(
                              child: Text('Delete',style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                              onPressed: () {
                                playlistProvider.playlist.removeAt(index);
                                Navigator.of(context).pop(); // Dismiss the dialog
                                // Optionally, update the UI
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}