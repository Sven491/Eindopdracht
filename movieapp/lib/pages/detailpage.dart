// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, unused_import, unnecessary_string_interpolations, use_build_context_synchronously

import 'dart:ui';
import 'package:MovieList/model/GET.dart';
import 'package:MovieList/model/GET_watchlist.dart';
import 'package:MovieList/services/remote_service.dart';
import 'package:MovieList/services/watchlist_service.dart';
import 'package:amicons/amicons.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({super.key});
  
  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<Detailpage> {
  TmdbDiscover? discoverMovies;
  var isLoaded = false;

    @override 
  void initState() {
    super.initState();

    getData();
  }


  getData() async{
    final tmdbData = await RemoteDiscoveryService().getDiscovery();
    if(tmdbData != null){
      setState(() {
        discoverMovies = tmdbData;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final String movieTitle = args['title'];
    final String? movieImage = args['posterPath'];
    final String movieOverview = args['overview'];
    final int movieId = args['id'];

    final supabase = Supabase.instance.client;
    final User? user = supabase.auth.currentUser;
    final String? userId = user?.id;
    final Currentwatchlist = 'yes';

    return Scaffold(
      extendBodyBehindAppBar: true,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [ Stack(
          children: [
            SizedBox(
              child:  Image.network( (movieImage != null && movieImage.isNotEmpty)
              ? 'https://image.tmdb.org/t/p/w500$movieImage'
              : 'https://www.content.numetro.co.za/ui_images/no_poster.png', fit: BoxFit.cover,)    
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black87,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                  (movieImage != null && movieImage.isNotEmpty)
                  ? ('https://image.tmdb.org/t/p/w500$movieImage')
                  : ('https://www.content.numetro.co.za/ui_images/no_poster.png'),
                  fit:BoxFit.cover,
                  height: 400,),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$movieTitle',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$movieOverview',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    IconButton(
                      icon: Icon(
                      Icons.favorite
                      ),
                        onPressed: () async {
                          await supabase
                          .from('watchlist')
                          .insert({'user_id': userId, 'movie_id': movieId});

                          await supabase
                          .from('watchlist')
                          .select();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[700],
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
        ]
      ),
    );
  }
}