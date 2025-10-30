import 'package:MovieList/model/GET.dart';
import 'package:http/http.dart' as http;

class RemoteDiscoveryService {
  Future<TmdbDiscover?> getDiscovery() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/discover/movie');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      return tmdbDiscoverFromJson(jsonString);
    }

    return null;
  }
}

class RemoteSearchService {
  Future<TmdbDiscover?> getSearch() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/search/multi');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      return tmdbDiscoverFromJson(jsonString);
    }

    return null;
  }
}

class RemoteWatchlistService {
  Future<TmdbDiscover?> getSearch() async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/search/multi');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      return tmdbDiscoverFromJson(jsonString);
    }

    return null;
  }
}