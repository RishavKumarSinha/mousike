import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mousike/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: "Celestial",
      artistName: "Ed Sheeran",
      albumArtImagePath: "assets/images/pokemon.png",
      audioPath: "audio/celestial.mp3",
    ),
  ];

  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  PlaylistProvider() {
    listenToDuration();
    if (_playlist.isNotEmpty) {
      _currentSongIndex = 0; // Initialize the index to the first song in the playlist
    }
  }

  void play() async {
    if (_currentSongIndex != null) {
      final String path = _playlist[_currentSongIndex!].audioPath;
      print('Attempting to play: $path'); // Debugging statement
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(AssetSource(path)); // No need to check result
        _isPlaying = true;
        print('Playback started successfully');
      } catch (e) {
        print('Error during playback: $e');
      }
      notifyListeners();
    }
  }


  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
      play(); // Automatically play the next song
    }
  }

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      await _audioPlayer.seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
      play(); // Automatically play the previous song
    }
  }

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (_currentSongIndex != null) {
      play();
    }

    notifyListeners();
  }
}
