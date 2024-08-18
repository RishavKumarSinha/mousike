import 'package:flutter/material.dart';

class Song {
  final String songName;
  final String artistName;
  final String albumArtImagePath;

  Song({
    required this.songName,
    required this.artistName,
    required this.albumArtImagePath,
  });
}


class MyTile extends StatelessWidget {
  final Song song;

  const MyTile({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
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
          ),
        ),
      ),
    );
  }
}
