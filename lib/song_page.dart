import 'package:flutter/material.dart';
import 'package:mousike/components/neu_box.dart';
import 'package:mousike/models/playlist_provider.dart';
import 'package:mousike/models/song.dart';
import 'package:mousike/playlist_page.dart';
import 'package:mousike/search_page.dart';
import 'package:provider/provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {

  @override
  void initState() {
    super.initState();
    // Start listening to playback updates when the widget is created.
    Provider.of<PlaylistProvider>(context, listen: false).startListening();
  }

  @override
  void dispose() {
    // Stop listening to playback updates when the widget is disposed.
    Provider.of<PlaylistProvider>(context, listen: false).stopListening();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";
    return formattedTime;
  }

  void onSongSelected(Song selectedSong) {
    final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    
    if (!playlistProvider.playlist.contains(selectedSong)) {
      playlistProvider.addSongToPlaylist(selectedSong);
    }

    playlistProvider.currentSongIndex = playlistProvider.playlist.indexOf(selectedSong);
    playlistProvider.play(); // Ensure playback starts immediately

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SongPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(builder: (context, value, child) {
      final playlist = value.playlist;
      final currentSong = playlist[value.currentSongIndex ?? 0];
      final isFavorite = value.favoriteSongs.contains(currentSong);

      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchScreen()),
                        );
                      },
                      icon: Icon(Icons.arrow_back,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlaylistPage(),
                          ),
                        );
                      },
                      child: Text(
                        "P L A Y L I S T",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: currentSong.albumArtImagePath.startsWith('http')
                            ? Image.network(
                                currentSong.albumArtImagePath,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.broken_image,
                                  size: 200,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              )
                            : Image.asset(
                                currentSong.albumArtImagePath,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                  Icons.broken_image,
                                  size: 200,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentSong.songName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                ),
                                Text(
                                  currentSong.artistName,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Theme.of(context).colorScheme.inversePrimary,
                              ),
                              onPressed: () {
                                final playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
                                if (isFavorite) {
                                  playlistProvider.removeFavoriteSong(currentSong);
                                } else {
                                  playlistProvider.addFavoriteSong(currentSong);
                                }
                                // Update state to reflect changes
                                setState(() {});
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(value.currentDuration),
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.inversePrimary),
                          ),
                          Icon(
                            Icons.shuffle,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          Icon(
                            Icons.repeat,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          Text(
                            formatTime(value.totalDuration),
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.inversePrimary),
                          ),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 0,
                        ),
                      ),
                      child: Slider(
                        min: 0,
                        max: value.totalDuration.inSeconds.toDouble(),
                        value: value.currentDuration.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (double newValue) {
                          value.seek(Duration(seconds: newValue.toInt()));
                        },
                        onChangeEnd: (double newValue) {
                          value.seek(Duration(seconds: newValue.toInt()));
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playPreviousSong,
                        child: NeuBox(
                          child: Icon(
                            Icons.skip_previous,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: value.pauseOrResume,
                        child: NeuBox(
                          child: Icon(
                            value.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: GestureDetector(
                        onTap: value.playNextSong,
                        child: NeuBox(
                          child: Icon(
                            Icons.skip_next,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
