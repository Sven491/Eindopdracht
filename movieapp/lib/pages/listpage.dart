// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, unused_import

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late SupabaseClient supabase;
  List<Map<String, dynamic>> watchlistMovies = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    supabase = Supabase.instance.client;
    loadWatchlist();
  }

  Future<void> loadWatchlist() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('watchlist')
        .select('movie_id')
        .eq('user_id', user.id);

    List<dynamic> movieIds = response;
    List<Map<String, dynamic>> resultList = [];

    for (var item in movieIds) {
      int id = item['movie_id'];
      final movieService = RemoteMovieService();
      final movieData = await movieService.getMovie(id);
      if (movieData != null) {
        resultList.add(movieData);
      }
    }

    setState(() {
      watchlistMovies = resultList;
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("My Watchlist", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: isLoaded == false
          ? const Center(child: CircularProgressIndicator())
          : watchlistMovies.isEmpty
              ? const Center(
                  child: Text(
                    "Your watchlist is empty...",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: watchlistMovies.length,
                  itemBuilder: (context, index) {
                    final movie = watchlistMovies[index];

                    final image = movie['poster_path'] != null
                        ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                        : 'https://www.content.numetro.co.za/ui_images/no_poster.png';

                    String title = movie['title'] ?? 'Unknown';
                    String release = movie['release_date'] ?? '---';

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'id': movie['id'],
                            'title': movie['title'],
                            'overview': movie['overview'],
                            'posterPath': movie['poster_path'],
                            'releaseDate': movie['release_date'],
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                image,
                                height: 120,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 14),

                            // movie info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    release.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[400],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
