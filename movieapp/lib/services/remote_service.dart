import 'package:MovieList/model/GET.dart';
import 'package:http/http.dart' as http;

class RemoteDiscoveryService {
  /// Returns the decoded `TmdbDiscover` object or null on failure.
  Future<TmdbDiscover?> getDiscovery() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/discover/movie');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      // tmdbDiscoverFromJson returns a TmdbDiscover
      return tmdbDiscoverFromJson(jsonString);
    }

    return null;
  }
}

/* class RemoteImageService {
  /// Returns the decoded `TmdbDiscover` object or null on failure.
  Future<TmdbImage?> getImage() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/movie/movie_id/images');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      // tmdbDiscoverFromJson returns a TmdbDiscover
      return tmdbImageFromJson(jsonString);
    }

    return null;
  }
} */