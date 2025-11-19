import 'package:MovieList/model/GET.dart';
import 'package:MovieList/model/GET_actor.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RemoteMovieService {
  Future<Map<String, dynamic>?> getMovie(int movieId) async {
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/$movieId');

    var response = await http.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}

class RemoteDetailService {
  Future<Map<String, dynamic>?> getMovie(int movieId) async {
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/$movieId');
    var response = await http.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }
}

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
  Future<TmdbDiscover?> getSearch(String query) async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/search/movie?query=$query');
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

class WatchlistService {
  static const String supabaseUrl = 'https://tgngawbyutmabrogghlw.supabase.co';
  static const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbmdhd2J5dXRtYWJyb2dnaGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzM2MzUsImV4cCI6MjA3NTYwOTYzNX0.IFqM3-sB2_NgnlnOHxlL1uIed8BS9froouZZMHabXEU';

  static final _supabase = SupabaseClient(supabaseUrl, supabaseKey);

  static Future<void> addtoWatchlist({
    required String userId,
    required int movieId,
  }) async {
    await _supabase.from('watchlist').insert({
      'user_id': userId,
      'movie_id': movieId,
    });
  }

  static Future<List<Map<String, dynamic>>> getWatchlist(String userId) async {
    final data = await _supabase
        .from('watchlist')
        .select('*')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(data);
  }

  static Future<void> removeFromWatchlist(int movieId, String userId) async {
    await _supabase
        .from('watchlist')
        .delete()
        .eq('movie_id', movieId)
        .eq('user_id', userId);
  }

  static Future<bool> isInWatchlist(int movieId, String userId) async {
    final data = await _supabase
        .from('watchlist')
        .select('movie_id')
        .eq('movie_id', movieId)
        .eq('user_id', userId)
        .maybeSingle();

    return data != null;
  }
}

class RemoteActorService {
  Future<Tmdbactor?> getActor(int movieId) async {
    var client = http.Client();

    var uri = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/credits');
    var response = await client.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final jsonString = response.body;
      return tmdbactorFromJson(jsonString);
    }

    return null;
  }
}

class RemoteGenreService {
  Future<List<Genre>> getGenres(int movieId) async {
    var uri = Uri.parse('https://api.themoviedb.org/3/movie/$movieId');
    var response = await http.get(uri, headers: {
      'Authorization': 'bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiY2MxN2M2ZmMwZWYyODlhYWZlOGNiMDM0YzI5NzZiYiIsIm5iZiI6MTc1ODAxNjMwNy4xODMsInN1YiI6IjY4YzkzMzMzMGRhZDgwMjliNGU1MWFhYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GomQJqzYbrQLRXKj4MZGOxUY2nI2sEbg9Rm9P_IK3PM',
      'Content-Type': 'application/json;charset=utf-8',
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final genreList = data['genres'] as List<dynamic>;
      return genreList.map((g) => Genre.fromJson(g)).toList();
    }

    return [];
  }
}