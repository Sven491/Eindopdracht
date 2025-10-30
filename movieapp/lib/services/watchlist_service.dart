import 'package:supabase_flutter/supabase_flutter.dart';

class WatchlistService {
  static const String supabaseUrl = 'https://tgngawbyutmabrogghlw.supabase.co';
  static const String supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRnbmdhd2J5dXRtYWJyb2dnaGx3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzM2MzUsImV4cCI6MjA3NTYwOTYzNX0.IFqM3-sB2_NgnlnOHxlL1uIed8BS9froouZZMHabXEU';

  static final _supabase = SupabaseClient(supabaseUrl, supabaseKey);

  static Future<void> addToWatchlist({
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
