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
  }

  void goToSong(int index) {
    playlistProvider.currentSongIndex = index;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SongPage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.inversePrimary),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ResponsiveLayout(
                  mobileScaffold: MobileScaffold(),
                  tabletScaffold: TabletScaffold(),
                  desktopScaffold: DesktopScaffold(),
                ),
              ),
            );
          },
        ),
        title: Text('P L A Y L I S T',
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      ),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          return ListView.builder(
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                final Song song = playlist[index];


                return ListTile(
                  title: Text(song.songName, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  subtitle: Text(song.artistName, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  leading: Image.asset(song.albumArtImagePath),
                  onTap: () => goToSong(index),
                );
              });
        },
      ),
    );
  }
}
