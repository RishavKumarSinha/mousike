import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mousike/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [];
  bool _hasCelestialAdded = false;
  int? _currentSongIndex;
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  final List<Song> _favoriteSongs = [];

  List<Song> get playlist => _playlist;
  
  List<Song> get favoriteSongs => _favoriteSongs;
  int? get currentSongIndex => _currentSongIndex;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  bool get isPlaying => _isPlaying;

  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _completionSubscription;

  void addSongToPlaylist(Song song) {
    if (!_playlist.contains(song)) {
      _playlist.add(song);
      notifyListeners();
    }
  }

  void play() async {
  if (_playlist.isNotEmpty && _currentSongIndex != null) {
    final Song song = _playlist[_currentSongIndex!];
    final String path = song.audioPath;

    try {
      await _audioPlayer.stop();

      // Determine whether to use AssetSource or UrlSource
      if (path.startsWith('http') || path.startsWith('https')) {
        // If the path is a URL
        await _audioPlayer.play(UrlSource(path));
      } else {
        // If the path is a local asset
        await _audioPlayer.play(AssetSource(path));
      }

      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Error during playback: $e');
    }
  } else if (_playlist.isNotEmpty) {
    // If _currentSongIndex is null, set it to the first song and play it
    _currentSongIndex = 0;
    final Song song = _playlist[_currentSongIndex!];
    final String path = song.audioPath;

    try {
      await _audioPlayer.stop();

      // Determine whether to use AssetSource or UrlSource
      if (path.startsWith('http') || path.startsWith('https')) {
        // If the path is a URL
        await _audioPlayer.play(UrlSource(path));
      } else {
        // If the path is a local asset
        await _audioPlayer.play(AssetSource(path));
      }

      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Error during playback: $e');
    }
  }
}


  void addCelestialSongIfNotAdded() {
  if (!_hasCelestialAdded) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final celestialSong = Song(
        songName: "Celestial",
        artistName: "Ed Sheeran",
        albumArtImagePath: 'assets/images/pokemon.png',
        audioPath: 'audio/celestial.mp3',
      );
      addSongToPlaylist(celestialSong);
      _hasCelestialAdded = true; // Update the flag
    });
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
  }

  void addFavoriteSong(Song song) {
    if (!_favoriteSongs.contains(song)) {
      _favoriteSongs.add(song);
      notifyListeners();
    }
  }

  void removeFavoriteSong(Song song) {
    if (_favoriteSongs.contains(song)) {
      _favoriteSongs.remove(song);
      notifyListeners();
    }
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
    _currentDuration = position;
    notifyListeners();
  }

  void playNextSong() {
    if (_currentSongIndex != null && _playlist.isNotEmpty) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  void playPreviousSong() async {
    if (_playlist.isEmpty || _currentSongIndex == null) return;

    if (_currentDuration.inSeconds > 2) {
      await _audioPlayer.seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  void startListening() {
    _durationSubscription = _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _completionSubscription = _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void stopListening() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _completionSubscription?.cancel();
  }

  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;
    if (_currentSongIndex != null) {
      play();
    }
  }
}
