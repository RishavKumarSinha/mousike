import 'package:flutter/material.dart';
import 'package:mousike/models/playlist_provider.dart';
import 'package:mousike/models/spotify_service.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/mobile_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:mousike/models/song.dart';
import 'song_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Song> _searchResults = [];

  void _searchSongs(String query) async {
    final spotifyService = Provider.of<SpotifyService>(context, listen: false);
    final results = await spotifyService.searchTracks(query);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  mobileScaffold: const MobileScaffold(),
                  tabletScaffold: const TabletScaffold(),
                  desktopScaffold: DesktopScaffold(),
                ),
              ),
            );
          },
        ),
        title: Text('Search Songs', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              cursorColor: Theme.of(context).colorScheme.inversePrimary,
              style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
              decoration: InputDecoration(
                labelText: 'Search for a song',
                labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                helperStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                fillColor: Theme.of(context).colorScheme.inversePrimary,
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                iconColor: Theme.of(context).colorScheme.inversePrimary,
                prefixStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                counterStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Theme.of(context).colorScheme.inversePrimary),
                  onPressed: () {
                    _searchSongs(_searchController.text);
                  },
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              onSubmitted: _searchSongs,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final song = _searchResults[index];
                  return ListTile(
                    leading: Image.network(song.albumArtImagePath),
                    title: Text(song.songName, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    subtitle: Text(song.artistName, style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                    onTap: () {
                      final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);

                      // Check if the song is already in the playlist
                      if (!playlistProvider.playlist.contains(song)) {
                        playlistProvider.addSongToPlaylist(song);
                      }

                      // Set the current song index to the selected song
                      final songIndex = playlistProvider.playlist.indexOf(song);
                      playlistProvider.currentSongIndex = songIndex;

                      // Navigate to SongPage and automatically start playback
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SongPage(),
                        ),
                      );
                    },
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
