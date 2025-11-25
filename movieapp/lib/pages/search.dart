// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, unused_import, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:MovieList/model/GET.dart';
import 'package:amicons/amicons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Result> _searchResults = [];
  bool _isLoading = false;

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _searchResults = [];
    });

    final results = await RemoteSearchService().getSearch(query);

    setState(() {
      _searchResults = results?.results ?? [];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search for a movie...',
            hintStyle: TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)),)),
          
          onSubmitted: _performSearch,
        ),
        actions: [
          IconButton(
            icon: const Icon(Amicons.remix_search2_fill, color: Colors.white),
            onPressed: () => _performSearch(_searchController.text),
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? const Center(
                  child: Text(
                    'Begin typing...',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final movie = _searchResults[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: {
                            'id': movie.id,
                            'title': movie.title,
                            'overview': movie.overview,
                            'posterPath': movie.posterPath,
                            'releaseDate': movie.releaseDate,
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                movie.posterPath != null
                                    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                    : 'https://www.content.numetro.co.za/ui_images/no_poster.png',
                                height: 140,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${movie.releaseDate.toLocal().toString().split(' ')[0]}',
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    movie.overview,
                                    style: const TextStyle(color: Colors.white70),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
