// ignore_for_file: library_private_types_in_public_api

import 'package:MovieList/model/GET.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  TmdbDiscover? discoverMovies;
  var isLoaded = false;

  @override 
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    discoverMovies = await RemoteDiscoveryService().getDiscovery();
    if (discoverMovies != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF1C1C2E),
        title: const Text(
          'Discover',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white70,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(color: Colors.deepPurple),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 0.55,
            ),
            itemCount: discoverMovies?.results.length,
            itemBuilder: (context, index) {
              final movie = discoverMovies!.results[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/detail', 
                    arguments: {
                      'id': movie.id,
                      'title': movie.title,
                      'posterPath': movie.posterPath,
                      'overview': movie.overview,
                      'releaseDate': movie.releaseDate,
                    });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C2E),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 6,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          movie.posterPath != null 
                              ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                              : 'https://www.content.numetro.co.za/ui_images/no_poster.png',
                          height: 270,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}