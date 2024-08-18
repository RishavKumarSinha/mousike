import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mousike/models/song.dart';

class SpotifyService {
  final String clientId;
  final String clientSecret;

  SpotifyService({required this.clientId, required this.clientSecret});

  Future<String> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$clientId:$clientSecret')),
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['access_token'];
    } else {
      throw Exception('Failed to retrieve access token');
    }
  }

  Future<List<Song>> searchTracks(String query) async {
    final accessToken = await _getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/search?q=$query&type=track'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final tracks = data['tracks']['items'] as List;

      return tracks.map((track) {
        return Song(
          songName: track['name'],
          artistName: track['artists'][0]['name'],
          albumArtImagePath: track['album']['images'][0]['url'],
          audioPath: track['preview_url'] ?? '', 
        );
      }).toList();
    } else {
      throw Exception('Failed to load tracks');
    }
  }
}
